return {
  -- Add the VS Code theme plugin
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optional: Configure the variant style (dark, light, transparent)
      require("vscode").setup({
        style = "dark",
        transparent = true,
      })
    end,
  },

  -- Configure LazyVim to load it automatically
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
