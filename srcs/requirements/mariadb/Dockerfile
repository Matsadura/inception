FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client libmariadb-dev-compat libmariadb-dev && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3306

ENTRYPOINT  
