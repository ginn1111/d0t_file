-- Lualine theme table, independent of the Neovim colorscheme.
local p = {
  canvas = '#141523', surface = '#191a21', text = '#f8f8f2',
  muted = '#7f848e', purple = '#bd93f9', mint = '#20e3b2',
  yellow = '#fde181', red = '#ff5555', status = '#7f5cdf',
}
local theme = {
  normal = { a = { fg = p.text, bg = p.status, gui = 'bold' },
             b = { fg = p.text, bg = p.surface },
             c = { fg = p.text, bg = p.canvas } },
  insert = { a = { fg = p.canvas, bg = p.mint, gui = 'bold' } },
  visual = { a = { fg = p.canvas, bg = p.purple, gui = 'bold' } },
  replace = { a = { fg = p.canvas, bg = p.red, gui = 'bold' } },
  command = { a = { fg = p.canvas, bg = p.yellow, gui = 'bold' } },
  inactive = { a = { fg = p.muted, bg = p.surface },
               b = { fg = p.muted, bg = p.surface },
               c = { fg = p.muted, bg = p.canvas } },
}
return theme
