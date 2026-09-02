-- Prefer tools managed by aqua over binaries supplied by plugin managers.
local aqua_root = vim.env.AQUA_ROOT_DIR
  or ((vim.env.XDG_DATA_HOME or vim.fn.expand("~/.local/share")) .. "/aquaproj-aqua")
local aqua_bin = aqua_root .. "/bin"
if vim.fn.isdirectory(aqua_bin) == 1 then
  vim.env.PATH = aqua_bin .. ":" .. vim.env.PATH
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
