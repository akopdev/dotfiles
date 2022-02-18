#!/usr/bin/env bash

link_file ".zshrc"

if [[ ! -d "${HOME}/go" ]]; then
    mkdir "${HOME}/go"
fi

