# OCR EXTRACTION

This repository is for the testing of the Dockerfile. I have addded `extraction.py` file which extract text from the image. Before passing the image to the `tesseract` model, `pdf2image` library is used to convert a PDF to images. Those images are then pass to the `tesseract` model to extract the text and then display the text of the first page. It is just for the demonstration purposes.

### Requirements File
In `requirements.txt`, all the required dependencies are included.

### Dockerfile
In `Dockerfile`, I have added seven (7) lines of code.
#### FIRST LINE OF CODE:
```
FROM python:3.11.4-slim
```
This line is used to initialize the environment or programming language of the project.
#### SECOND LINE OF CODE:
```
WORKDIR /app
```
This line of code creates a new working directory named as `app`, where our code will be copied.
#### THIRD LINE OF CODE:
```
COPY requirements.txt .
```
This line of code copy the `requirements.txt` file into the newly created directory `app`.
#### FOURTH LINE OF CODE:
```
RUN apt-get update && apt-get install -y libgl1-mesa-glx poppler-utils tesseract-ocr
```
This line of code updates the system and then install all the required packages into the virtual system which includes `libgl1-mesa-glx`, `poppler-utils` and `tesseract-ocr`.
#### FIFTH LINE OF CODE:
```
RUN pip install --no-cache-dir -r requirements.txt
```
This line of code runs the `requirements.txt` and install all the required python libraries.
#### SIXTH LINE OF CODE:
```
COPY . .
```
This line of code copy the current directory into the container's current working directory.
#### SEVENTH LINE OF CODE:
```
CMD ["python", "extraction.py"]
```
This line of code is actually the `shell` command which runs our main script file which is `extraction.py`.

### HOW TO RUN:
Clone the repository into your local system. Open a terminal and use the following command to run the docker container.
#### NOTE: MAKE SURE DOCKER IS INSTALLED AND RUNNING
```
$ docker run -it ocr_extraction
```
