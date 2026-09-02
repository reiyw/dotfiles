return {
  {
    "mason-org/mason.nvim",
    opts = {
      -- Keep tools selected by the shell (including aqua's tree-sitter) ahead
      -- of Mason's bin directory. Mason defaults to prepending its directory.
      PATH = "append",
    },
  },
}
