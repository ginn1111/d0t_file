return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  name = "onedark",
  config = function()
    local onedark = require("onedark")
    onedark.setup({
      style = "deep",
      transparent = true,
      lualine = {
        transparent = true,
      },
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    })

    vim.cmd([[colorscheme onedark]])
  end,
}
