#!/usr/bin/env bash
input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Build directory display (shorten home to ~)
home_dir="$HOME"
display_cwd="${cwd/#$home_dir/\~}"

# Build context segment
ctx_segment=""
if [ -n "$used" ]; then
    ctx_segment=" | ctx:$(printf '%.0f' "$used")%"
fi

# Build model segment
model_segment=""
if [ -n "$model" ]; then
    model_segment=" | $model"
fi

printf "\033[32m%s@%s\033[0m:\033[34m%s\033[0m%s%s" \
    "$user" "$host" "$display_cwd" "$model_segment" "$ctx_segment"
