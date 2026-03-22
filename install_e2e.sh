#!/bin/bash

cd tests/src/e2e
py -m venv .venv
.venv\Scripts\activate
py -m pip install -U pip setuptools wheel

# py -m pip install black robotframework robotframework-seleniumlibrary robotframework-faker robotframework-jsonlibrary beautifulsoup4 numpy opencv-python pandas pykeepass
# pip freeze > requirements.txt

py -m pip install -r requirements.txt
