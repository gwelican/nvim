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
          cmd = { vim.fn.expand("~/.local/share/mise/shims/yayamlls") },
          filetypes = { "yaml" },
          root_markers = { ".yayamlls.yaml", ".git" },
        },
      },
    },
  },
}
