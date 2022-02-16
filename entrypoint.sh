#!/bin/bash

set -eu
tmux new -s foo -d && tmux ls

exec "$@"

