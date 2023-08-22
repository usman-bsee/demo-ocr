
# Variables
DOCKER_COMPOSE_FILE = /media/cactus/sda2/cactus/demo-ocr/docker-compose.yaml
CONTAINER_NAME = ocr-extraction

# Build the Docker image
build:
	docker-compose build

# Run the Docker container in detached mode
run-detached:
	docker-compose up

# Start the Docker container and attach to its interactive shell
shell:
	docker-compose -f $(DOCKER_COMPOSE_FILE) exec ocr-extraction /bin/bash

# Clean up (remove Docker image)
clean:
	docker-compose -f $(CONTAINER_NAME) down

start-build:
	@make build
	@make run-detached

lint:
	@./helpers/pep8/run_flake8.sh

lint-fix:
	@./helpers/pep8/auto_format.sh
