COMPOSE	= ./srcs/docker-compose.yml

all: up

up:
	@docker compose -f $(COMPOSE) up -d --build

down:
	@docker compose -f $(COMPOSE) down

clean: down
	@docker system prune -a -f

logs:
	@docker compose -f $(COMPOSE) logs -f

info:
	@docker ps


.PHONY = all up down clean
