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
launch `$SHELL` start zsh. Non-interactive shells are left unchanged.

A chezmoi modify script preserves the system-provided `~/.bashrc` and appends
the paths and environment needed by the installed CLI tools. The managed block
intentionally does not define aliases, so it does not hide standard commands.
Machine-specific bash configuration can be added to `~/.bashrc.local`.

## Agent skills

Agent skills are managed as chezmoi externals under `~/.agents/skills`. They are
installed and refreshed automatically by `chezmoi apply`. Chezmoi also creates
links under `~/.claude/skills` so Claude Code can discover the same skills.
