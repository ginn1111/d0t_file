return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    require("onedarkpro").setup({
      options = {
        cursorline = true, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        lualine_transparency = true, -- Center bar transparency?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
      },
      styles = {
        types = "italic",
        methods = "italic",
        numbers = "italic",
        strings = "italic",
        comments = "italic",
        keywords = "bold,italic",
        constants = "italic",
        functions = "italic",
        operators = "italic",
        variables = "italic",
        parameters = "italic",
        conditionals = "italic",
        virtual_text = "italic",
      },
    })
    -- vim.cmd("colorscheme onedark")
  end,
}
