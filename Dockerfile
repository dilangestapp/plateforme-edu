FROM composer:2 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-interaction --no-progress --optimize-autoloader
COPY . /app

FROM php:8.2-cli-alpine
WORKDIR /app

RUN apk add --no-cache bash icu-dev libzip-dev oniguruma-dev \
  && docker-php-ext-install intl mbstring zip pdo pdo_mysql

COPY --from=vendor /app /app

RUN sed -i 's/\r$//' /app/start.sh && chmod +x /app/start.sh \
  && mkdir -p storage bootstrap/cache \
  && chmod -R 775 storage bootstrap/cache || true

EXPOSE 8080
CMD ["sh","-lc","./start.sh"]
