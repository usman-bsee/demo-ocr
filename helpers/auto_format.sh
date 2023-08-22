#!/bin/bash

# This script finds all files with the .py extension and runs autopep8 on them.
# It will run in parallel on up to 4 files at a time.
# If possible it will run autopep8 in a Docker container, otherwise it will run it locally.

# Check for uncommitted changes
if git diff-index --quiet HEAD --; then
    # No changes
    echo "No uncommitted changes detected."

    # Function to run autopep8 on a file
    function run_autopep8 {
        echo "Processing $1"
        autopep8 --in-place --aggressive --aggressive $1
    }

    # Check for running Docker container
    if docker container ls | grep ocr-extraction > /dev/null ; then
        echo "Running autopep8 in Docker container..."
        docker exec -it ocr-extraction bash -c 'find . -name "*.py" | xargs -I{} -P 4 bash -c '\''echo "Processing {}"; autopep8 --in-place --aggressive --aggressive {}'\'
    else
        echo "Docker container not found. Running autopep8 in local environment..."
        # Check if autopep8 is installed
        if ! command -v autopep8 &> /dev/null; then
            echo "The docker container is not running and autopep8 is not installed for you locally."
            read -p "Would you like to install autopep8? (y/n) " yn
            case $yn in
                [Yy]* ) pip install autopep8;;
                [Nn]* ) echo "Please run the docker container or install autopep8 locally."; exit;;
                * ) echo "Please answer yes or no."; exit;;
            esac
        fi
        export -f run_autopep8
        find . -name '*.py' | xargs -I{} -P 4 bash -c 'run_autopep8 "$0"' {} 
    fi

    # Check if any files were modified
    modified_files=$(git diff --name-only | wc -l)
    if [ $modified_files -ne 0 ]; then
        echo -e "\n\n$modified_files file(s) were modified by autopep8.\nPlease review the changes and commit them."
    else
        echo -e "\n\nNo files were modified by autopep8."
    fi
else
    # Changes
    echo "Uncommitted changes detected. Please commit or stash changes before running this script."
    exit 1
fi