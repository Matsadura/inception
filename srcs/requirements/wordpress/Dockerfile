FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates wordpress php php-fpm php-mysql && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

WORKDIR /var/www/wordpress

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["php-fpm8.2", "-F"]