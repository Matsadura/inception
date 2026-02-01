FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client libmariadb-dev-compat libmariadb-dev && \
    rm -rf /var/lib/apt/lists/*

COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.conf
COPY tools/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld", "--user=mysql", "--bind-address=0.0.0.0"]
