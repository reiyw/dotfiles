# dotfiles

My [chezmoi](https://www.chezmoi.io/) configuration.

## Usage

```shell
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply reiyw
```

The installer installs zsh on Linux and makes it the login shell. The shell
change is non-interactive: if passwordless `sudo` is unavailable, the installer
prints the `chsh` command to run manually instead of interrupting the remaining
setup. As a fallback for accounts where `chsh` cannot be used, the installer
uses a chezmoi modify script to preserve the existing `~/.bash_profile` and add
an interactive-shell guard. Non-interactive shells are left unchanged.

## Agent skills

Agent skills are managed as chezmoi externals under `~/.agents/skills`. They are
installed and refreshed automatically by `chezmoi apply`.
