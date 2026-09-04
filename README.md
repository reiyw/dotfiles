# dotfiles

My [chezmoi](https://www.chezmoi.io/) configuration.

## Usage

```shell
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply reiyw
```

The installer installs zsh on Linux and makes it the login shell. The shell
change is non-interactive: if passwordless `sudo` is unavailable, the installer
prints the `chsh` command to run manually instead of interrupting the remaining
setup.

## Agent skills

Agent skills are managed as chezmoi externals under `~/.agents/skills`. They are
installed and refreshed automatically by `chezmoi apply`.
