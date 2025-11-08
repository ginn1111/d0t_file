-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
-- local oil = require("oil")

keymap.set("n", "<leader>v", "<C-W>v<cr>")
keymap.set("n", "dw", "viw d")
keymap.set("n", "cw", "viw c")
keymap.set("n", "vw", "viw")
-- keymap.set("n", "<C-f>", ':call smoothie#do("<C-D>")<cr>', { silent = true })
keymap.set("", "<leader>ev", "<cmd>vsplit $MYVIMRC<cr>", { silent = true })
keymap.set("", "<leader>es", "<cmd>source $MYVIMRC<cr>", { silent = true })
keymap.set("n", "<leader>F", "<cmd>Neotree toggle=true<cr>", { silent = true })
-- keymap.set("n", "-", oil.open_float, { silent = true })
keymap.set("n", "glc", function()
  require("timber.actions").clear_log_statements({ global = false })
end)
