#!/usr/bin/env bash
# Import the shared instructions while keeping this machine's own lines.
set -eu

import_line="@~/.agents/AGENTS.md"
current="$(cat)"

if grep -Fqx "$import_line" <<<"$current"; then
    printf '%s\n' "$current"
    exit 0
fi

printf '%s\n' "$import_line"
[[ -z $current ]] || printf '\n%s\n' "$current"
