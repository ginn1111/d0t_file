return {
  "eldritch-theme/eldritch.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("eldritch").setup({
      -- disable italic for functions
      transparent = true,
      hide_inactive_statusline = true,
      styles = {
        functions = {},
      },
      sidebars = { "qf", "vista_kind", "terminal", "packer" },
      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = "#ff0000"
      end,
      fzf_colors = {
        true,
        bg = "-1",
        gutter = "-1",
      },
    })
    vim.cmd([[colorscheme eldritch]])
  end,
}
