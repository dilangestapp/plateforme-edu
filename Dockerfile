FROM php:8.2-cli-alpine
WORKDIR /app

RUN apk add --no-cache bash icu-dev libzip-dev oniguruma-dev \
    && docker-php-ext-install intl mbstring zip pdo pdo_mysql

COPY . /app

RUN mkdir -p storage bootstrap/cache \
 && chmod -R 775 storage bootstrap/cache

ENV APP_ENV=production
ENV LOG_CHANNEL=stderr

# IMPORTANT: utiliser $PORT (pas ${PORT})
CMD ["sh", "-lc", "echo PORT=$PORT && php -S 0.0.0.0:$PORT -t public public/index.php"]
