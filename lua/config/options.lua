-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.swapfile = false

-- better coop with fzf-lua
vim.env.FZF_DEFAULT_OPTS = ""
vim.g.ai_cmp = false
-- vim.g.lazyvim_blink_main = not jit.os:find("Windows")
vim.opt.clipboard = "unnamedplus"
