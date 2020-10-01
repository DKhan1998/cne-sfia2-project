#!/bin/bash
#install python environment
. ./app/bin/activate
python -m pip install pytest-cov pytest-xdist
python -m pip list