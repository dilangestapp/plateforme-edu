FROM php:8.2-cli-alpine

WORKDIR /app

# Extensions PHP nécessaires (Laravel + MySQL)
RUN apk add --no-cache bash icu-dev libzip-dev oniguruma-dev \
    && docker-php-ext-install intl mbstring zip pdo pdo_mysql

# Copier tout le projet
COPY . /app

# Permissions + corriger CRLF Windows sur le script
RUN mkdir -p storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache \
    && sed -i 's/\r$//' docker/entrypoint.sh \
    && chmod +x docker/entrypoint.sh

EXPOSE 8080
ENV PORT=8080

CMD ["sh", "docker/entrypoint.sh"]
