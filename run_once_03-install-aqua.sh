#!/usr/bin/env bash
set -e

curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.0/aqua-installer
echo "8299de6c19a8ff6b2cc6ac69669cf9e12a96cece385658310aea4f4646a5496d  aqua-installer" | sha256sum -c
chmod +x aqua-installer
./aqua-installer
rm aqua-installer
