#!/usr/bin/env sh
set -e

HOST="0.0.0.0"
PORT="${PORT:-8080}"

echo "Starting service on ${HOST}:${PORT}"

# Si c'est un projet Laravel
if [ -f artisan ]; then
  # Nettoyage léger (ne bloque pas si ça échoue)
  php artisan optimize:clear >/dev/null 2>&1 || true

  # Démarrage Laravel (respecte $PORT)
  exec php artisan serve --host="${HOST}" --port="${PORT}"
fi

# Sinon (app PHP simple avec dossier public/)
exec php -S "${HOST}:${PORT}" -t public
