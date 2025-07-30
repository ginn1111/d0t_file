return {
  "gaelph/logsitter.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local logsitter = require("logsitter")
    logsitter.setup({
      path_format = "default",
      prefix = "[☠️] ->",
      separator = "->",
    })
  end,
}
