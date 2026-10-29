return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    opts = {
      inlay_hints = {
        inline = false,
        show_parameter_hints = false,
      },
    },
  },
}
