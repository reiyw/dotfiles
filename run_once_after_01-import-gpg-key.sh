#!/usr/bin/env bash
gpg --list-keys AF24ED1B3F9F1EE143224EE3321EA0F603AD4F4C || gpg --import ~/.local/gpg_key_for_signing_commits
