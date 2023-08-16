# Makefile

# Variables
DOCKER_IMAGE_NAME = my_ocr_project
SCRIPT_NAME = extraction.py

# Build the Docker image
build:
	docker build -t $(DOCKER_IMAGE_NAME) .

# Run the Docker container
run:
	docker run -it $(DOCKER_IMAGE_NAME)

# Run the Python script inside the Docker container
script:
	docker run -it $(DOCKER_IMAGE_NAME) python $(SCRIPT_NAME)

# Clean up (remove Docker image)
clean:
	docker rmi $(DOCKER_IMAGE_NAME)

start-build:
	@make build
	@make run