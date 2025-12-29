FROM php:8.2-cli-alpine
WORKDIR /app

# Extensions PHP nécessaires (Laravel + DB)
RUN apk add --no-cache bash icu-dev libzip-dev oniguruma-dev \
    && docker-php-ext-install intl mbstring zip pdo pdo_mysql pdo_pgsql

# Copie TOUT le projet (y compris vendor déjà présent)
COPY . /app

# Permissions Laravel
RUN mkdir -p storage bootstrap/cache \
 && chmod -R 775 storage bootstrap/cache

ENV APP_ENV=production
ENV LOG_CHANNEL=stderr

# Railway fournit PORT, fallback 8000
EXPOSE 8000

# Démarrage + migrations (sans entrypoint externe)
CMD ["sh", "-lc", "php artisan migrate --force && php -S 0.0.0.0:${PORT:-8000} -t public public/index.php"]
