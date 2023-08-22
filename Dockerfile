# Use the official Python image as the base image with version 3.11.4
FROM python:3.11.4-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install required packages including DVC
RUN apt-get update && apt-get install -y libgl1-mesa-glx poppler-utils tesseract-ocr git
RUN pip install --no-cache-dir flake8 autopep8
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .

# Keep the container running with a long-running process
CMD tail -f /dev/null
