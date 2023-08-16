# Use the official Python image as the base image with version 3.11.4
FROM python:3.11.4-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install Poppler utilities and required Python packages
RUN apt-get update && apt-get install -y libgl1-mesa-glx poppler-utils tesseract-ocr
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .

# Run your Python script
CMD ["python", "extraction.py"]
