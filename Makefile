# Define variables
COMPOSE_FILE = srcs/docker-compose.yml

# Default target
all: build run

# Build Docker images using docker-compose
build:
	docker-compose -f $(COMPOSE_FILE) build

# Run Docker containers using docker-compose
run:
	docker-compose -f $(COMPOSE_FILE) up -d

# Stop and remove Docker containers
stop:
	docker-compose -f $(COMPOSE_FILE) down

# Clean up Docker images, volumes, and networks
clean: stop
	docker-compose -f $(COMPOSE_FILE) rm -f
	docker volume prune -f
	docker network prune -f

# Restart Docker containers
restart: stop run

# View logs of Docker containers
logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

# Access a shell inside a specific service container (e.g., nginx)
shell-nginx:
	docker-compose -f $(COMPOSE_FILE) exec nginx /bin/sh

# Access a shell inside a specific service container (e.g., wordpress)
shell-wordpress:
	docker-compose -f $(COMPOSE_FILE) exec wordpress /bin/sh

# Access a shell inside a specific service container (e.g., mariadb)
shell-mariadb:
	docker-compose -f $(COMPOSE_FILE) exec mariadb /bin/sh
