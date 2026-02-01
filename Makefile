COMPOSE	= ./srcs/docker-compose.yml
USER_DATA = /home/zzaoui/data
DB_DATA = $(USER_DATA)/mariadb
WP_DATA  = $(USER_DATA)/wordpress

all: setup up

setup:
	sudo mkdir -p $(DB_DATA) $(WP_DATA)
	@sudo chmod 777 $(DB_DATA) $(WP_DATA)

up:
	@docker compose -f $(COMPOSE) up -d --build

down:
	@docker compose -f $(COMPOSE) down

clean: down
	@docker system prune -a -f

fclean: clean
	@sudo rm -rf $(USER_DATA)
	@docker volume rm $(docker volume ls -q) 2>/dev/null || true

re: fclean all

logs:
	@docker compose -f $(COMPOSE) logs -f

info:
	@docker ps


.PHONY = all up down clean re fclean logs info setup
