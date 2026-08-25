#!/bin/bash
# Claude Code status line: model name + context window usage percentage.

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

if [ -n "$used" ]; then
  printf '\033[2m%s | Context: %.0f%% used\033[0m' "$model" "$used"
else
  printf '\033[2m%s\033[0m' "$model"
fi
