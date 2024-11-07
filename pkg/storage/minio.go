package storage

import (
	"log"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/storage/minio"
	"github.com/gofiber/storage/postgres/v3"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/zeusWPI/wolk/pkg/config"
)

var Storage fiber.Storage

func Init(pool *pgxpool.Pool) {
	env := config.GetDefaultString("storage.provider", "minio")
	switch env {
	case "minio":
		Storage = minio.New(minio.Config{
			Bucket:   config.GetDefaultString("storage.minio.bucket", "am-assets"),
			Endpoint: config.GetString("storage.minio.endpoint"),
			Secure:   config.GetDefaultBool("storage.minio.secure", false),
			Credentials: minio.Credentials{
				AccessKeyID:     config.GetString("storage.minio.username"),
				SecretAccessKey: config.GetString("storage.minio.password"),
			},
		})
	case "postgres":
		Storage = postgres.New(postgres.Config{
			DB:         pool,
			Table:      "fiber_storage",
			Reset:      false,
			GCInterval: 10 * time.Second,
		})
	default:
		log.Fatalf("Invalid storage provider: %s", env)
	}
}
