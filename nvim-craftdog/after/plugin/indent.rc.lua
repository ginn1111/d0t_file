vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#6b6b8b gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#23262F gui=nocombine]]

vim.cmd [[highlight IndentBlanklineIndent7 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent8 guibg=#1a1a1a gui=nocombine]]

--vim.opt.list = true
  vim.opt.listchars:append "space:⋅"
  vim.opt.listchars:append "eol:↴"
  vim.opt.listchars:append "extends:→"
  vim.opt.listchars:append "precedes:←"

require("indent_blankline").setup {
--    indent_blankline_context_char_blankline = '┆',
--    space_char_blankline = " ",
  context_highlight_list = {
      --[[ "IndentBlanklineIndent1", ]]
      --[[ "IndentBlanklineIndent2", ]]
      --[[ "IndentBlanklineIndent3", ]]
      --[[ "IndentBlanklineIndent4", ]]
      --[[ "IndentBlanklineIndent6", ]]
      --[[ "IndentBlanklineIndent1", ]]
      --[[ "IndentBlanklineIndent2", ]]
      --[[ "IndentBlanklineIndent3", ]]
      --[[ "IndentBlanklineIndent4", ]]
      "IndentBlanklineIndent2",
  },
  char = '▏',
  --[[ char = '┆', ]]
  char_highlight_list = {
      "IndentBlanklineIndent6",
  },

  show_current_context_start = true,
  show_first_indent_level = false,
  show_current_context = true,
  --use_treesitter_scope = true,
}
