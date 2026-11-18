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

## T3 Code

On Linux and macOS, the installer installs the `t3` CLI at the version pinned
in `run_onchange_after_03-install-t3code.sh.tmpl` and runs it as a background
service: a systemd user service on Linux (with lingering enabled), a launchd
agent on macOS. Run `t3 up` afterwards to choose how other devices reach it.

A machine with the T3 Code desktop app is skipped. The app writes its own `t3`
command to `~/.t3/bin/t3` and keeps its data in `~/.t3`, so a separately
installed CLI would share that data at a different version. Such a machine
gets T3 Code updates from the app.

## Tailscale

How Tailscale is installed on Linux depends on the `tailscaleMode` that
`chezmoi init` stores in the chezmoi config. It is decided once so that it does
not change between runs with the sudo credential cache:

- `system` (root, a member of `sudo`, `wheel` or `admin`, passwordless `sudo`,
  or Tailscale already installed): the installer installs Tailscale from its
  package repository and enables the `tailscaled` system service, so
  `apt-get upgrade` keeps it up to date. `chezmoi apply` asks for the `sudo`
  password if it needs one; if `sudo` fails, the script fails and the next
  `chezmoi apply` tries again.
- `userspace` (no root): aqua installs `tailscale` and `tailscaled`, and
  `tailscaled` runs as the systemd user service
  `~/.config/systemd/user/tailscaled.service` in
  [userspace networking mode](https://tailscale.com/kb/1112/userspace-networking).
  The package is listed in `~/.config/aqua/imports/tailscale.aqua.yaml`, which
  only these machines get, so aqua's link never hides the system `tailscale`
  elsewhere.
- `none`: Codespaces, dev containers and non-Linux systems.

On macOS, the installer installs the Tailscale app with Homebrew.

To change the mode, for example after gaining `sudo`, run `chezmoi init` again
or edit `tailscaleMode` in `~/.config/chezmoi/chezmoi.toml`. Moving from
`userspace` to `system` stops and removes the user service. Machines set up
before `tailscaleMode` existed need `chezmoi init` (or `chezmoi apply --init`)
once.

Joining the tailnet needs a browser login, so it is not automated. Run this
once and open the URL it prints:

```shell
sudo tailscale up --operator=$USER  # system
tailscale up                        # userspace
```

`--operator` lets later `tailscale` commands run without `sudo`. On macOS, log
in from the Tailscale app.

In userspace mode:

- The `tailscale` command is a zsh alias that adds `--socket`, because the
  user service's socket is not at the default path. A shell started before
  `chezmoi apply` added the alias does not have it; run `exec zsh` first, or
  `tailscale` fails with `dial unix /var/run/tailscale/tailscaled.sock`.
- Connections from the tailnet to this machine reach the same port on
  localhost, so SSH and development servers work as usual.
- The machine has no Tailscale network interface. Connect out to the tailnet
  through the SOCKS5/HTTP proxy on `localhost:1055` (e.g.
  `curl --proxy socks5h://localhost:1055 http://host:8080`) or, for SSH, with
  `ProxyCommand tailscale --socket=… nc %h %p`. MagicDNS names resolve only
  through these.
- `tailscaled` keeps running after logout only when lingering is enabled.
  `chezmoi apply` tries to enable it and reports when it cannot.
- After Renovate updates the version, run
  `systemctl --user restart tailscaled`. `chezmoi apply` does not restart it,
  because that would drop SSH sessions over the tailnet.

## Agent skills

Agent skills are managed as chezmoi externals under `~/.agents/skills`. They are
installed and refreshed automatically by `chezmoi apply`. Chezmoi also creates
links under `~/.claude/skills` so Claude Code can discover the same skills.

Global agent instructions live in `~/.agents/AGENTS.md`. Chezmoi links
`~/.codex/AGENTS.md` to it for Codex. For Claude Code, chezmoi adds the line
`@~/.agents/AGENTS.md` to `~/.claude/CLAUDE.md` and keeps any other lines in
that file, so machine-specific instructions can stay there.
