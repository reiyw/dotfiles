# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## tree-sitter CLI

The tree-sitter CLI is installed by aqua. It is pinned to v0.25.10 because the
v0.26 Linux binary requires GLIBC 2.39 and cannot run on older Linux hosts.
Building v0.26 with Cargo is not used as a fallback: it requires native build
dependencies that cannot be installed in environments without sudo access.
Neovim also appends Mason's bin directory to `PATH` instead of prepending it;
otherwise Mason's newer `tree-sitter` can shadow the aqua-managed version only
inside Neovim, even when `tree-sitter` works correctly in the shell.

After applying these dotfiles, restart Neovim and run `:TSUpdate` to rebuild or
update parsers.
