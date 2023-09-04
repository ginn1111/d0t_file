-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- key binding mapleader
vim.g.mapleader = ";"

local opt = vim.opt
opt.winbar = "%=%m %f"

-- indentation
opt.foldlevelstart = 99
opt.foldlevel = 20
opt.foldmethod = "indent"

-- split window
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
