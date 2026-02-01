COMPOSE	= ./srcs/docker-compose.yml
USER_DATA = /home/zzaoui/data
DB_DATA = $(USER_DATA)/mariadb
WP_DATA  = $(USER_DATA)/wordpress

all: setup up

setup:
	sudo mkdir -p $(DB_DATA) $(WP_DATA)
# Set WordPress folder to www-data (UID 33)
	@sudo chown -R 33:33 $(WP_DATA)
	# Set MariaDB folder to mysql (UID 999 is standard for the official image)
	@sudo chown -R 999:999 $(DB_DATA)

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
