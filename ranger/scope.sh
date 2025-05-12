!#!/bin/bash

if [ "$extension" = "ipynb" ]; then
    nbcat "$1"
    exit 0
fi
