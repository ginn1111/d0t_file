local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    diagnostics = "nvim_lsp",
    --[[ separator_style = "thin", ]]
    separator_style = "slant",
    enforce_regular_tabs = true,
    modified_icon = '●',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
  --[[ highlights = { ]]
  --[[ separator = { ]]
  --[[   fg = '#44474d', ]]
  --[[ }, ]]
  --[[ separator_selected = { ]]
  --[[   bg = '#44474d', ]]
  --[[ }, ]]
  --[[ background = { ]]
  --[[   bg = '#44474d' ]]
  --[[ }, ]]
  --[[ buffer_selected = { ]]
  --[[   fg = '#fdf6e3', ]]
  --[[   bold = true ]]
  --[[ }, ]]
  --[[ fill = { ]]
  --[[   bg = '#383b42', ]]
  --[[ } ]]
  --[[ }, ]]
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
