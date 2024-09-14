return {
  "lukas-reineke/indent-blankline.nvim",
  event = "LazyFile",
  config = function()
    local highlight = {
      "RainbowViolet",
    }

    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#444761" })
    end)

    require("ibl").setup({ indent = { highlight = highlight, char = "┆", tab_char = "➜" } })
  end,
}
