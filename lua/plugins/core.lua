return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = { enabled = false },
        yayamlls = {
          mason = false,
          cmd = { "yayamlls" },
          filetypes = { "yaml" },
          root_markers = { ".yayamlls.yaml", ".git" },
        },
      },
    },
  },
}
