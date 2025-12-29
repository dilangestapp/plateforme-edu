FROM php:8.2-cli-alpine
WORKDIR /app

# Extensions PHP nécessaires (Laravel + MySQL)
RUN apk add --no-cache bash icu-dev libzip-dev oniguruma-dev \
    && docker-php-ext-install intl mbstring zip pdo pdo_mysql

# Copie TOUT le projet (y compris vendor si tu l'as commité)
COPY . /app

# Permissions Laravel
RUN mkdir -p storage bootstrap/cache \
 && chmod -R 775 storage bootstrap/cache

ENV APP_ENV=production
ENV LOG_CHANNEL=stderr

EXPOSE 8000

# Railway fournit PORT, fallback 8000
CMD ["sh", "-lc", "php -S 0.0.0.0:$PORT -t public public/index.php"]
