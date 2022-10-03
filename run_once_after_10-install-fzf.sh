#!/usr/bin/env bash
if [[ -e "$HOME/.fzf.zsh" ]]; then
    echo "fzf already installed"
else
    ~/.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
fi
