vim.cmd("autocmd!")
vim.cmd [[
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup END
]]
vim.cmd [[ autocmd FileType css,scss setlocal iskeyword+=-,?,! ]]
local set = vim.opt
vim.scriptencoding = 'utf-8'
set.encoding = 'utf-8'

set.fileencoding = 'utf-8'

vim.wo.number = true

set.foldlevelstart = 99
set.foldmethod = "indent"
set.foldlevel = 20
set.title = true
set.autoindent = true
set.smartindent = true
set.hlsearch = true
set.backup = false
set.showcmd = true
set.cmdheight = 1
set.laststatus = 2
set.expandtab = true
set.scrolloff = 10
set.shell = 'zsh'
set.backupskip = { '/tmp/*', '/private/tmp/*' }
set.inccommand = 'split'
set.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
set.smarttab = true
set.breakindent = true
set.shiftwidth = 2
set.tabstop = 2
set.wrap = false -- No Wrap lines
set.backspace = { 'start', 'eol', 'indent' }
set.path:append { '**' } -- Finding files - Search down into subfolders
set.wildignore:append { '*/node_modules/*' }
set.mouse = a
set.listchars = {
  tab = '├─',
  trail = '·'

}

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- comfortable-motion
--[[ vim.g['comfortable_motion_no_default_key_mappings'] = 1 ]]

-- prettier
vim.g['prettier#config#tab_width'] = 2
vim.g['prettier#config#parser'] = typescript
vim.g['prettier#autoformat_config_files'] = 'css', 'javascript', 'typescript', 'html', 'jsx', 'markdown'
vim.g['prettier#autoformat'] = 1
vim.g['prettier#autoformat_require_pragma'] = 0
vim.g['prettier#quickfix_enabled'] = 0
vim.g['prettier#partial_format'] = 1

-- emmet
vim.g['user_emmet_mode'] = 'a'
vim.g['user_emmet_install_global'] = 0
vim.g['user_emmet_leader_key'] = '<C-Y>'
vim.cmd [[autocmd FileType html,css EmmetInstall]]

-- NERDTree
vim.cmd [[autocmd VimEnter * NERDTree | wincmd p]]
--Exit Vim if NERDTree is the only window remaining in the only tab.
vim.cmd [[autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]]
-- Close the tab if NERDTree is the only window remaining in it.
vim.cmd [[autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]]
--Open the existing NERDTree on each new tab.
vim.cmd [[autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif]]

vim.g.NERDTreeDirArrowExpandable = ''
--vim.g.NERDTreeDirArrowCollapsible = ''

vim.cmd 'colorscheme material'
vim.g.material_style = "deep ocean"
