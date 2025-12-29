#!/bin/sh
set -e

PORT="${PORT:-8080}"

echo "Starting server on 0.0.0.0:$PORT"
mkdir -p storage bootstrap/cache || true
chmod -R 775 storage bootstrap/cache || true

exec php -S 0.0.0.0:$PORT -t public
