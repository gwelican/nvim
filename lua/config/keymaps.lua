-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", ",s", ':split <C-R>=expand("%:p:h") .. "/"<CR>', { noremap = true })
vim.keymap.set("n", ",v", ':vsplit <C-R>=expand("%:p:h") .. "/"<CR>', { noremap = true })
-- vim.keymap.set("n", ",e", ':e <C-R>=expand("%:p:h") .. "/"<CR>', { noremap = true })
