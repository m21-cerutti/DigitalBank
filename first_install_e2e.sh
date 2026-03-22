#!/bin/bash

cd ./tests/src/e2e

python -m venv .venv

# Windows .venv/Scripts/activate
source .venv/bin/activate

py -m pip install -U pip setuptools wheel
py -m pip install black robotframework robotframework-seleniumlibrary robotframework-faker robotframework-jsonlibrary beautifulsoup4 numpy opencv-python pandas pykeepass
pip freeze > requirements.txt

read -p "Press enter to continue"