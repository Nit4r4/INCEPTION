#!/bin/sh
-include srcs/.env
# Define colors
PURP	= \e[35m
GREEN	= \e[32m
RED		= \e[31m
WHITE	= \e[39m
YELLOW	= \033[33m
RESET	= \e[0m
BLUE	= \033[34m
CYAN	= \033[36m
MAGENTA = \033[35m

# Define variables
COMPOSE_FILE = srcs/docker-compose.yml
DComp = docker compose -f $(COMPOSE_FILE)
# DComp = docker-compose -f $(COMPOSE_FILE)

# Default target
all: build run ok

# message de fin
ok:
	@echo "Everything went smoothly 😎"

# Build Docker images using docker-compose
build:
	@echo "⬇️  Building ... ⬇️"
	@mkdir -p ${HOME}/data/wordpress-data
	@mkdir -p ${HOME}/data/mariadb-data
	@$(DComp) build
	@echo "Build ✅"

# Run Docker containers using docker-compose
run:
	@echo "⬇️  Runing ... ⬇️"
	@$(DComp) up -d
	@echo "Run ✅"

# Stop and remove Docker containers
stop:
	@echo "⬇️  Stoping and cleaning... ⬇️ "
	@$(DComp) down -v --remove-orphans

# Clean up Docker images, volumes, and networks
clean: stop ok
	@echo "⬇️  Stoping and cleaing... ⬇️ "
	@$(DComp) rm -f
	@rm -rf ${HOME}/data/wordpress-data
	@rm -rf ${HOME}/data/mariadb-data
	@docker volume prune -f
	@echo "Stop and clean volume ✅"
	@docker network prune -f
	@echo "Stop and clean network ✅"
	@echo ""

#	@echo "yes" | docker images prune -a si besoin
fclean: clean ok
	@echo "⬇️  Stoping and cleaing ... ⬇️ "
	@$(DComp) rm -f
	@rm -rf ${HOME}/data/wordpress-data
	@rm -rf ${HOME}/data/mariadb-data
	@docker image prune -af
	@echo "Stop and clean image ✅"
	@docker system prune -f
	@echo "Stop and clean system ✅"

# Restart Docker containers
restart: stop run ok

# View logs of Docker containers
logs:
	@$(DComp) logs -f

ps:
	@$(DComp) ps -f

# Access a shell inside a specific service container (e.g., nginx)
shell-nginx:
	@$(DComp) exec nginx /bin/sh

# Access a shell inside a specific service container (e.g., wordpress)
shell-wordpress:
	@$(DComp) exec wordpress /bin/sh

# Access a shell inside a specific service container (e.g., mariadb)
shell-mariadb:
	@$(DComp) exec mariadb /bin/sh
