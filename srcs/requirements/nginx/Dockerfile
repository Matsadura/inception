FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY tools/ssl.cert /etc/ssl/certs/ssl.cert
COPY tools/ssl.key /etc/ssl/private/ssl.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
