# Inception

A 42 Lyon project: a small web infrastructure with Docker Compose, where every image is built from my own Dockerfile (Alpine base) instead of a ready-made image.

**Status: in progress.** The containers build and talk to each other, but the project is not finished (see "What is left").

## What works today

| Service | What it does |
|---|---|
| `mariadb` | Alpine + MariaDB. On first start, `init-db.sh` creates the system tables, the database and the user, then runs `mariadbd` as PID 1 |
| `wordpress` | Alpine + php-fpm 8.3 on port 9000, with WordPress downloaded at build time |
| `nginx` | Serves the WordPress files from a shared volume and passes `.php` requests to php-fpm with FastCGI |
| `adminer` | Official image, only here to inspect the database while I work |

Two named volumes keep the database and the WordPress files.

## Run

```sh
docker compose -f srcs/docker-compose.yaml up -d --build
# site: http://localhost:8000   adminer: http://localhost:8080
docker compose -f srcs/docker-compose.yaml down        # stop
docker compose -f srcs/docker-compose.yaml down -v     # stop and delete the volumes
```

## What is left

- TLS on nginx (HTTPS only, port 443)
- WordPress setup (`wp-config.php`, site install, users)
- Credentials read from `srcs/.env` (template in `srcs/.env.example`); the compose file still uses throwaway test values
- The root `Makefile`, still empty
- A dedicated Docker network and the volume paths asked by the subject
