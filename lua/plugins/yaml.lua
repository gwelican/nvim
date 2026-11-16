local function yayamlls_render_lint()
  local filename = vim.api.nvim_buf_get_name(0)
  local root = vim.fs.root(filename, { ".yayamlls.yaml", ".git" }) or LazyVim.root.get()
  local target = (filename ~= "" and vim.fs.relpath(root, filename)) or "."
  local yayamlls = vim.fn.expand("~/.local/share/mise/shims/yayamlls")

  Snacks.terminal({
    vim.fn.executable(yayamlls) == 1 and yayamlls or "yayamlls",
    "validate",
    "--render",
    "--root",
    root,
    target,
  }, { cwd = root })
end

return {
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
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        yaml = { "prettier" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "yamllint" },
      },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>cY", yayamlls_render_lint, desc = "Lint current Kubernetes YAML (yayamlls --render)" },
    },
  },
}
