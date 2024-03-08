vim.g.mapleader = ";"

local opt = vim.opt
opt.winbar = "%=%m %f"
opt.spell = true
opt.spelllang = { "en_us" }

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
-- vim.cmd(
--   [[hi SpellBad   guisp=red    gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=undercurl ctermul=red]]
-- )
-- vim.cmd(
--   [[hi SpellCap   guisp=yellow    gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=undercurl ctermul=yellow]]
-- )

-- indentation
opt.foldlevelstart = 99
opt.foldlevel = 20
opt.foldmethod = "indent"

-- split window
opt.splitright = true
opt.splitbelow = true
