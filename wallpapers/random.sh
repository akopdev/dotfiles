#!/usr/bin/env bash
feh --bg-fill $(ls .wallpapers/*.{png,jpg} | shuf -n 1)

