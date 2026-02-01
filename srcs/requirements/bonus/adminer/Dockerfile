FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    wget \
    php \
    php-mysql \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN wget https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php -O index.php

EXPOSE 8081

CMD ["php", "-S", "0.0.0.0:8081", "-t", "/var/www/html"]