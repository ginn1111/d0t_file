return {
  "luisiacc/the-matrix.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    -- Enable telescope theme
    vim.g.thematrix_telescope_theme = 1

    -- Enable transparent mode
    vim.g.thematrix_transparent_mode = 1
    vim.cmd.colorscheme("thematrix")
  end,
}
