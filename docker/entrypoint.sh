#!/bin/sh
set -e

cd /app

# Si tu utilises SQLite (optionnel), on crée le fichier en /tmp
if [ "${DB_CONNECTION}" = "sqlite" ]; then
  if [ -z "${DB_DATABASE}" ]; then
    export DB_DATABASE=/tmp/database.sqlite
  fi
  mkdir -p /tmp
  touch "${DB_DATABASE}"
fi

# Cache/clear safe (ne casse pas si APP_KEY pas prêt)
php artisan config:clear || true
php artisan route:clear || true
php artisan view:clear || true

# Migrations (ne bloque pas le démarrage si DB pas prêt)
php artisan migrate --force || true

# Démarrage (OBLIGATOIRE: écouter sur $PORT pour Koyeb)
exec php -S 0.0.0.0:${PORT:-8000} -t public public/index.php
