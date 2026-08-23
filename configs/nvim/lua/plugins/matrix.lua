return {
  "luisiacc/the-matrix.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    -- Match the Kitty Matrix theme from configs/kitty/Matrix.conf.
    vim.o.background = "dark"
    vim.g.thematrix_background_color = "dark"
    vim.g.thematrix_telescope_theme = 1
    vim.g.thematrix_transparent_mode = 1

    vim.g.thematrix_color_overrides = {
      background = "#0f160f",
      background_dark = "#0f160f",
      foreground = "#83f5c8",
      green0 = "#83f5c8",
      green05 = "#1ad6b0",
      green = "#18e000",
      green1 = "#2f7e25",
      green2 = "#044e04",
      comment = "#5f887f",
      dark_green = "#267d69",
      gray1 = "#83f5c8",
      gray2 = "#5f887f",
      gray3 = "#355249",
      error = "#df8008",
      highlight = "#1b342d",
      string = "#bde000",
      keyword = "#00a9df",
    }

    vim.g.thematrix_highlights = {
      Normal = { fg = "#83f5c8", bg = "NONE" },
      NormalFloat = { fg = "#83f5c8", bg = "#112615" },
      CursorLine = { bg = "#1b342d" },
      CursorLineNr = { fg = "#1ad6b0", bg = "#1b342d", style = "bold" },
      LineNr = { fg = "#355249" },
      Visual = { bg = "#1b342d" },
      Search = { fg = "#0f160f", bg = "#bde000" },
      IncSearch = { fg = "#0f160f", bg = "#1ad6b0" },
      Pmenu = { fg = "#83f5c8", bg = "#112615" },
      PmenuSel = { fg = "#0f160f", bg = "#18e000" },
      WinSeparator = { fg = "#267d69" },
      StatusLine = { fg = "#83f5c8", bg = "#112615" },
      StatusLineNC = { fg = "#5f887f", bg = "#0f160f" },
      DiagnosticError = { fg = "#df8008" },
      DiagnosticWarn = { fg = "#bde000" },
      DiagnosticInfo = { fg = "#00a9df" },
      DiagnosticHint = { fg = "#1ad6b0" },
    }
  end,
  config = function()
    vim.cmd.colorscheme("thematrix")
  end,
}
