return {
  -- Add the VS Code theme plugin
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Optional: Configure the variant style (dark, light, transparent)
    require("vscode").setup({
      style = "dark",
      transparent = true,
      color_overrides = {
        vscBack = "#001419",
        vscLeftBar = "#1E1E1E",
        vscTabCurrent = "#252526",
        vscTabOther = "#191a21",
        vscPopupBack = "#252526",
        vscMenuBack = "#252526",
        vscVisual = "#264F78",
        vscLineNumber = "#576d74",
        vscCursorDarkDark = "#3a0d0c",
        vscGreen = "#23D18B",
        vscBlue = "#4EC9B0",
        vscYellow = "#DCDCAA",
        vscOrange = "#c94c16",
        vscRed = "#db302d",
        vscPink = "#d33682",
        vscNone = "NONE",
      },
    })
    vim.cmd.colorscheme("vscode")
  end,

  -- Configure LazyVim to load it automatically
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "evondev_dracula",
  --   },
  -- },
}
