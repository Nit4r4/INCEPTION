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

# Default target
all: build run ok

# message de fin
ok:
	@echo "Everything went smoothly 😎"

# Build Docker images using docker-compose
build:
	@echo "⬇️  Building ... ⬇️"
	@docker-compose -f $(COMPOSE_FILE) build
	@echo "Build ✅"

# Run Docker containers using docker-compose
run:
	@echo "⬇️  Runing ... ⬇️"
	@docker-compose -f $(COMPOSE_FILE) up -d
	@echo "Run ✅"

# Stop and remove Docker containers
stop:
	@echo "⬇️  Stoping and cleaning... ⬇️ "
	@docker-compose -f $(COMPOSE_FILE) down -v --remove-orphans

# Clean up Docker images, volumes, and networks
clean: stop ok
	@echo "⬇️  Stoping and cleaing... ⬇️ "
	@docker-compose -f $(COMPOSE_FILE) rm -f
	@docker volume prune -f
	@echo "Stop and clean volume ✅"
	@docker network prune -f
	@echo "Stop and clean network ✅"
	@echo ""

fclean: clean ok
	@echo "⬇️  Stoping and cleaing ... ⬇️ "
	@docker-compose -f $(COMPOSE_FILE) rm -f
	@docker image prune -f
	@echo "Stop and clean image ✅"
	@echo ""
	@docker system prune -f
	@echo "Stop and clean system ✅"

# Restart Docker containers
restart: stop run ok

# View logs of Docker containers
logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f

ps:
	@docker-compose -f $(COMPOSE_FILE) ps -f

# Access a shell inside a specific service container (e.g., nginx)
shell-nginx:
	@docker-compose -f $(COMPOSE_FILE) exec nginx /bin/sh

# Access a shell inside a specific service container (e.g., wordpress)
shell-wordpress:
	@docker-compose -f $(COMPOSE_FILE) exec wordpress /bin/sh

# Access a shell inside a specific service container (e.g., mariadb)
shell-mariadb:
	@docker-compose -f $(COMPOSE_FILE) exec mariadb /bin/sh
