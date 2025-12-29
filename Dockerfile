FROM php:8.2-cli-alpine

WORKDIR /app

# Dépendances + extensions nécessaires
RUN apk add --no-cache bash icu-dev libzip-dev oniguruma-dev \
    && docker-php-ext-install intl mbstring zip pdo pdo_mysql

# Copier le projet
COPY . /app

# Corriger CRLF Windows sur start.sh et donner droits
RUN sed -i 's/\r$//' /app/start.sh && chmod +x /app/start.sh \
    && mkdir -p storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache || true

EXPOSE 8080

# Lancer via script (gère PORT correctement)
CMD ["sh", "start.sh"]
