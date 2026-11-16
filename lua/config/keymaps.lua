-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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

vim.keymap.set("n", "<leader>cY", yayamlls_render_lint, { desc = "Lint current Kubernetes YAML (yayamlls --render)" })
