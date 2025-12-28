#!/bin/sh
set -e

cd /app

# SQLite optionnel
if [ "${DB_CONNECTION}" = "sqlite" ]; then
  if [ -z "${DB_DATABASE}" ]; then
    export DB_DATABASE=/tmp/database.sqlite
  fi
  mkdir -p /tmp
  touch "${DB_DATABASE}"
fi

php artisan config:clear || true
php artisan route:clear || true
php artisan view:clear || true

php artisan migrate --force || true

exec php -S 0.0.0.0:${PORT:-8000} -t public public/index.php
