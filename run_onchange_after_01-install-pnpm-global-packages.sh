#!/usr/bin/env bash
set -e

export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export AQUA_GLOBAL_CONFIG="$HOME/aqua.yaml"
export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
export PATH="$PNPM_HOME/bin:$PATH"

pnpm add -g \
    --allow-build=node-pty \
    @getpaseo/cli
