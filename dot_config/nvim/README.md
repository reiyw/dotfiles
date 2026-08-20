# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## tree-sitter CLI

The tree-sitter CLI is installed declaratively with aqua. Neovim puts aqua's
bin directory first in its `PATH`, so nvim-treesitter uses the pinned CLI
instead of a binary supplied by a plugin manager that may require a newer glibc
(for example, GLIBC 2.39).

After applying these dotfiles, restart Neovim and run `:TSUpdate` to rebuild or
update parsers.
