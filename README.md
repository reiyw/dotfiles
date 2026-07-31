# dotfiles

My [chezmoi](https://www.chezmoi.io/) configuration.

## Usage

```shell
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply reiyw
```

## Agent skills

Agent skills are managed as chezmoi externals under `~/.agents/skills`. They are
installed and refreshed automatically by `chezmoi apply`.
