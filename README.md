# OCR EXTRACTION

## DOCKER SETUP
We are installing the airflow with the help of dockers. So, to continue installation of airflow, we have to install and run dockers first. Steps to install dockers in ubuntu are as folow:

1. Download docker desktop from their official website.
2. Set up the repository
Update the `apt` package index and install packages to allow `apt` to use a repository over HTTPS:
```
$ sudo apt-get update
$ sudo apt-get install ca-certificates curl gnupg
```
3. Add Docker's official GPG key:
```
$ sudo install -m 0755 -d /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$ sudo chmod a+r /etc/apt/keyrings/docker.gpg
```
4. Use the following command to set up the repository:
```
$ echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
5. Update the `apt` package index:
```
$ sudo apt-get update
```
6. Download the latest `deb` package
7. Install the package with apt as follows:
```
$ sudo apt-get install ./docker-desktop-<version>-<arch>.deb
```

To check if docker-desktop is successfully installed, check its version using the following command:
```
$ docker --version
```
### Launch Docker Desktop:
To start Docker Desktop for Linux, search Docker Desktop on the Applications menu and open it. Alternatively, open a terminal and run"
```
$ systemctl --user start docker-desktop
```

## INSTALL REQUIREMENTS
Follow the following command to install all the required dependencies:
```
$ pip install -r requirements.txt
```

## DEMO
I have addded `extraction.py` file in the `src/models/` directory, which extract text from the image. Before passing the image to the `tesseract` model, `pdf2image` library is used to convert a PDF to images. Those images are then pass to the `tesseract` model to extract the text and then display the text of the first page. It is just for the demonstration purposes.

### Dockerfile
In `Dockerfile`, I have added eight (8) lines of code.
```
$ FROM python:3.11.4-slim
```
This line is used to initialize the environment or programming language of the project.

```
$ WORKDIR /app
```
This line of code creates a new working directory named as `app`, where our code will be copied.

```
$ COPY requirements.txt .
```
This line of code copy the `requirements.txt` file into the newly created directory `app`.

```
$ RUN apt-get update && apt-get install -y libgl1-mesa-glx poppler-utils tesseract-ocr
$ RUN pip install --no-cache-dir flake8 autopep8
$ RUN pip install --no-cache-dir -r requirements.txt
```
This line of code updates the system and then install all the required packages into the virtual system which includes `libgl1-mesa-glx`, `poppler-utils`, `tesseract-ocr`, `flake8`, `autopep8` and `requirements.txt` that install all the required python libraries.

```
$ COPY . .
```
This line of code copy the current directory into the container's current working directory.

```
$ CMD tail -f /dev/null
```
This line of code keeps the container running with a long-running process.


### Makefile
The `Makefile` is used to compile the Docker image. There are multiple commands in the `Makefile` which are used to compile the Docker image. Here is the explanation of them.
```
build:
	docker-compose build
```
This line of code is used to build the Docker image.
```
run-detached:
	docker-compose up
```
This line of code is used to run the Docker image in detached mode.
```
shell:
	docker-compose -f $(CONTAINER_NAME) exec ocr-extraction /bin/bash
```
This line of code is used to run the Docker image in shell mode.
```
clean:
	docker-compose -f $(CONTAINER_NAME) down
```
This line of code is used to clean the Docker image.


### docker-compose.yaml
This file is used to configure the Docker container. Here is the explanation of them.
```
version: '3'
services:
  ocr-extraction:
    container_name: ocr-extraction
    build:
      context: .
      dockerfile: Dockerfile
    command: tail -f /dev/null
```    

### HOW TO RUN:
Clone the repository into your local system. Open a terminal and use the following command to run the docker container.
#### NOTE: MAKE SURE DOCKER IS INSTALLED AND RUNNING
```
$ make start-build
```


### Linting
Before submitting your code, please ensure it follows the PEP 8 guidelines. We utilize [flake8](http://flake8.pycqa.org/en/latest/) to check our code for PEP 8 compliance. To run it simply run `make lint`. This will run flake8 for you using our `helpers/pep8/run_flake8.sh` script. 

#### Auto fix lint errors
If you would like to attempt to automatically fix some of the PEP 8 errors you can run `make lint-fix` which will run `helpers/pep8/auto_format.sh` to run autopep8 on all of your python files efficiently; this will attempt to fix PEP8 errors but will not fix every error. Be sure to re-run `make lint` after running `make lint-fix` to check for the errors that couldn't be automatically fixed!

Adhering to these style guidelines not only helps keep the codebase clean and consistent, but also makes it easier for others to read and understand your code. Thank you for helping maintain the quality of our code!

#### ALTERNATIVELY
You can directly run `./helpers/pep8/run_flake8.sh` to run flake8 on your code and then run `./helpers/pep8/auto_format.sh` to run autopep8 on your code.