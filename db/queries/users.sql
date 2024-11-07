-- name: GetUserByName :one
SELECT *
FROM users
WHERE name=$1;

-- name: CreateUser :one
INSERT INTO users (name, admin)
VALUES ($1, $2)
RETURNING *;
