#!/usr/bin/env zsh
set -eu

testing_commands=(
    fzf
    gh
    ghq
    git-town
    just
    lsd
    nvim
)

for cmd in $testing_commands; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Could not find $cmd"
        exit 1
    fi
done
