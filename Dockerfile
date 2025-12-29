FROM composer:2 AS vendor
WORKDIR /app

# ✅ Evite GitHub API (psysh 504), force dist, et tolère les timeouts
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_DISABLE_NETWORK=0 \
    COMPOSER_PROCESS_TIMEOUT=1200

COPY composer.json composer.lock ./

RUN composer config -g preferred-install dist \
 && composer config -g github-protocols https \
 && composer config -g secure-http true \
 && composer install --no-dev --prefer-dist --no-interaction --no-progress

COPY . .
RUN composer dump-autoload --optimize

FROM php:8.2-cli-alpine
WORKDIR /app

RUN apk add --no-cache bash icu-dev libzip-dev oniguruma-dev \
    && docker-php-ext-install intl mbstring zip pdo pdo_mysql pdo_pgsql

COPY --from=vendor /app /app

RUN mkdir -p storage bootstrap/cache \
 && chmod -R 775 storage bootstrap/cache

ENV APP_ENV=production
ENV LOG_CHANNEL=stderr
EXPOSE 8000

CMD ["php", "-S", "0.0.0.0:8000", "-t", "public", "public/index.php"]
