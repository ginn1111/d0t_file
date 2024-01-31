return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "deep",
      transparent = true,
      diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
      },
    })
    vim.cmd([[colorscheme onedark]])
  end,
}
