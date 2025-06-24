return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "never" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    fromatters_by_ft = {
      lua = { "stylua" },
      javascript = { "biome", "biome-organize-imports" },
      javascriptreact = { "biome", "biome-organize-imports" },
      typescript = { "biome", "biome-organize-imports" },
      typescriptreact = { "biome", "biome-organize-imports" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt" },
    },
    formatters = {
      my_formatter = {
        cwd = require("conform.util").root_file({
          "biome.json",
          ".editorconfig",
          "package.json",
          ".prettierrc",
          "prettier.config.js",
        }),
      },
    },
  },
}
