vim.g.mapleader = ";"

local opt = vim.opt
-- opt.winbar = "%=%m %f"
opt.spell = true
opt.spelllang = { "en_us" }

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- indentation
opt.foldlevelstart = 99
opt.foldlevel = 20
opt.foldmethod = "indent"

-- split window
opt.splitright = true
opt.splitbelow = true
vim.g["signify_sign_add"] = "┃"
vim.g["signify_sign_change"] = "┃"
vim.g["signify_sign_delete"] = "•"

-- cursor

vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver100,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
function hiCursor()
  vim.api.nvim_set_hl(0, "Cursor", { fg = "#cc9900", bg = "#36F499" })
  vim.api.nvim_set_hl(0, "CursorReset", { fg = "white", bg = "white" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = hiCursor,
})

vim.g.lazyvim_prettier_needs_config = true
