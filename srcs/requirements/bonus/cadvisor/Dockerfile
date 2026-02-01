FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/google/cadvisor/releases/download/v0.56.2/cadvisor-v0.56.2-linux-amd64 -O /usr/local/bin/cadvisor

RUN chmod +x /usr/local/bin/cadvisor

EXPOSE 8080

CMD ["/usr/local/bin/cadvisor", "-logtostderr"]