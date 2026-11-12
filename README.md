# dotfiles

My [chezmoi](https://www.chezmoi.io/) configuration.

## Usage

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply reiyw
```

A minimal Debian or Ubuntu installation does not include `curl`. Install the
bootstrap packages first (prefix the commands with `sudo` when not running as
root):

```shell
apt-get update
apt-get install -y ca-certificates curl git
```

On Linux, the installer then installs the remaining base packages with `apt-get`,
including `build-essential`, `gnupg`, `python3` and `zsh`. This step requires
root or passwordless `sudo`; otherwise it is skipped.

The installer installs zsh on Linux and makes it the login shell. The shell
change is non-interactive: if passwordless `sudo` is unavailable, the installer
continues without attempting a password-based `chsh`. As a fallback for
accounts where `chsh` cannot be used, the installer uses chezmoi modify scripts
to preserve the existing `~/.bash_profile` and `~/.profile` and add an
interactive-shell guard. The fallback also updates `SHELL`, so programs that
launch `$SHELL` start zsh. Non-interactive login shells (e.g. `bash -lc` from
GUI tools) are not switched to zsh; they get the CLI tool environment described
below from `~/.profile`.

A chezmoi modify script preserves the system-provided `~/.bashrc` and appends
the paths and environment needed by the installed CLI tools. The managed block
intentionally does not define aliases, so it does not hide standard commands.
Machine-specific bash configuration can be added to `~/.bashrc.local`.

The environment for the CLI tools (`PATH` entries for aqua, pnpm, cargo and
`~/.local/bin`, plus their settings, `TZ`, and `CLAUDE_CODE_SHELL=/bin/bash`
so that Claude Code runs commands in bash instead of the interactive zsh setup)
is defined once in
`.chezmoitemplates/cli-env`. It is rendered into `~/.zshrc`, `~/.bashrc`,
`~/.profile` and, on Linux, `~/.config/environment.d/10-cli-tools.conf`, so
systemd user services (such as the T3 Code server) that do not read shell
startup files see the same `PATH`. After that file changes, `chezmoi apply`
reloads the systemd user manager; restart running services to pick it up.

## Agent skills

Agent skills are managed as chezmoi externals under `~/.agents/skills`. They are
installed and refreshed automatically by `chezmoi apply`. Chezmoi also creates
links under `~/.claude/skills` so Claude Code can discover the same skills.
