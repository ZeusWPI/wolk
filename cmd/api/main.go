package main

import (
	"fmt"

	"github.com/getsentry/sentry-go"
	"github.com/zeusWPI/wolk/internal/api"
	"github.com/zeusWPI/wolk/pkg/config"
	"github.com/zeusWPI/wolk/pkg/logger"
	"go.uber.org/zap"
)

func main() {
	err := config.Init()
	if err != nil {
		panic(err)
	}

	if dsn := config.GetString("app.dsn"); dsn != "" {
		if err := sentry.Init(sentry.ClientOptions{
			Dsn:              dsn,
			EnableTracing:    true,
			TracesSampleRate: 1.0,
			AttachStacktrace: true,
		}); err != nil {
			fmt.Printf("Sentry initialization failed: %v\n", err)
		}
	}

	zapLogger := logger.New()
	zap.ReplaceGlobals(zapLogger)

	server, err := api.NewServer()
	if err != nil {
		zap.L().Fatal("Failed to create server", zap.Error(err))
	}

	zap.L().Info(fmt.Sprintf("Server is running on %s", server.Addr))
	if err := server.Listen(server.Addr); err != nil {
		zap.L().Fatal("Failure while running the server", zap.Error(err))
	}
}
