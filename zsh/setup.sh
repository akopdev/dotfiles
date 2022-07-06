#!/usr/bin/env bash

link_file ".zshrc"

if [[ ! -d "${HOME}/go" ]]; then
    mkdir -p "${HOME}"/go/{bin,src,pkg}
fi

