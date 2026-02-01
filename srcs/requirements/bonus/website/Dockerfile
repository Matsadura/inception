FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY index.html /var/www/html/index.html

EXPOSE 1212

CMD ["nginx", "-g", "daemon off;"]
