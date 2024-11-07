package auth

import (
	"errors"

	"github.com/gofiber/fiber/v2"
	"github.com/jackc/pgx/v5"
	"github.com/markbates/goth"
	"github.com/shareed2k/goth_fiber"
	"github.com/zeusWPI/wolk/internal/middlewares"
	"github.com/zeusWPI/wolk/internal/util"
	"github.com/zeusWPI/wolk/pkg/config"
	"github.com/zeusWPI/wolk/pkg/goth/zauth"
	"github.com/zeusWPI/wolk/pkg/sqlc"
	"go.uber.org/zap"
)

type AuthRouter struct {
	router fiber.Router
	db     *sqlc.Queries
}

func NewAPI(db *sqlc.Queries, router fiber.Router) {
	goth.UseProviders(zauth.New(config.GetString("auth.zauth.client_id"), config.GetString("auth.zauth.client_secret"), config.GetString("auth.zauth.callbackURL")))

	api := &AuthRouter{
		router,
		db,
	}

	api.Router()
}

func (r *AuthRouter) Router() {
	auth := r.router.Group("/auth")
	auth.Get("/login/:provider", goth_fiber.BeginAuthHandler)
	auth.Get("/callback/:provider", r.LoginCallbackHandler)
	auth.Get("/logout", r.LogoutHandler)
	auth.Get("/session", middlewares.ProtectedRoute, r.SessionHandler)
}

func (r *AuthRouter) LoginCallbackHandler(c *fiber.Ctx) error {
	// if we get logged out, we should overwrite this is with a shouldLogout = false
	user, err := goth_fiber.CompleteUserAuth(c)
	if err != nil {
		zap.L().Error("failed to complete user auth", zap.Error(err))
	}

	dbUser, err := r.db.GetUserByName(c.Context(), user.Name)
	if err != nil && !errors.Is(err, pgx.ErrNoRows) {
		zap.L().Error("failed to search user", zap.Error(err))
		return fiber.ErrInternalServerError
	}

	if dbUser.ID == 0 {
		dbUser, err = r.db.CreateUser(c.Context(), sqlc.CreateUserParams{
			Name:  user.Name,
			Admin: user.RawData["admin"].(bool),
		})
		if err != nil {
			zap.L().Error("failed to insert user", zap.Error(err))
			return fiber.ErrInternalServerError
		}
	}

	err = util.StoreInSession("userId", dbUser.ID, c)
	if err != nil {
		zap.L().Error("failed to store user in session", zap.Error(err))
		return fiber.ErrInternalServerError
	}

	return c.Redirect("/admin")
}

func (r *AuthRouter) LogoutHandler(c *fiber.Ctx) error {
	if err := goth_fiber.Logout(c); err != nil {
		zap.L().Error("failed to logout", zap.Error(err))
	}

	return c.SendString("logout")
}

func (r *AuthRouter) SessionHandler(c *fiber.Ctx) error {
	return c.SendStatus(200)
}
