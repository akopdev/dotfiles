#!/usr/bin/env bash
set -euo pipefail

i3status | while IFS= read -r line; do
  # Pass through the i3bar protocol headers untouched
  if [[ "$line" == '{"version"'* || "$line" == '[' ]]; then
    printf '%s\n' "$line"
    continue
  fi

  prefix=""
  [[ "$line" == ,* ]] && prefix="," && line="${line:1}"

  layout=$(xkb-switch -p 2>/dev/null | tr 'a-z' 'A-Z')

  # Prepend the layout block to the JSON array in a single jq call
  merged=$(printf '%s' "$line" | jq -c --arg text " $layout " \
    '[{full_text: $text, name: "keyboard_layout"}] + .')

  printf '%s%s\n' "$prefix" "$merged"
done
