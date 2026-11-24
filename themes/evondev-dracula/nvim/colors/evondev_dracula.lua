-- Standalone opt-in colorscheme; no plugin dependency.
vim.cmd('highlight clear')
vim.g.colors_name = 'evondev_dracula'
vim.o.termguicolors = true
local p = {
  canvas = '#141523', surface = '#191a21', selection = '#44475a',
  text = '#f8f8f2', muted = '#7f848e', purple = '#bd93f9',
  mint = '#20e3b2', yellow = '#fde181', red = '#ff5555',
  cyan = '#8be9fd', pink = '#ff6bcb', orange = '#ffb86c',
  status = '#7f5cdf',
}
local hi = function(group, spec) vim.api.nvim_set_hl(0, group, spec) end
hi('Normal', { fg = p.text, bg = p.canvas })
hi('NormalFloat', { fg = p.text, bg = p.surface })
hi('FloatBorder', { fg = p.purple, bg = p.surface })
hi('SignColumn', { bg = p.canvas })
hi('LineNr', { fg = p.muted })
hi('CursorLineNr', { fg = p.purple, bold = true })
hi('CursorLine', { bg = p.surface })
hi('Visual', { bg = p.selection })
hi('Search', { fg = p.canvas, bg = p.yellow })
hi('StatusLine', { fg = p.text, bg = p.status })
hi('StatusLineNC', { fg = p.muted, bg = p.surface })
hi('Pmenu', { fg = p.text, bg = p.surface })
hi('PmenuSel', { fg = p.text, bg = p.selection })
hi('Comment', { fg = p.muted, italic = true })
hi('String', { fg = '#f1fa8c' })
hi('Number', { fg = p.orange })
hi('Keyword', { fg = p.pink })
hi('Function', { fg = p.mint })
hi('Type', { fg = p.cyan })
hi('Constant', { fg = p.purple })
hi('Identifier', { fg = p.text })
hi('Error', { fg = p.red })
hi('DiagnosticError', { fg = p.red })
hi('DiagnosticWarn', { fg = p.yellow })
hi('DiagnosticInfo', { fg = p.cyan })
hi('DiagnosticOk', { fg = p.mint })
hi('DiffAdd', { fg = p.mint, bg = p.surface })
hi('DiffDelete', { fg = p.red, bg = p.surface })
hi('@comment', { link = 'Comment' })
hi('@string', { link = 'String' })
hi('@keyword', { link = 'Keyword' })
hi('@function', { link = 'Function' })
hi('@type', { link = 'Type' })
