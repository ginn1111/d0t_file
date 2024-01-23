return {
  "stevearc/conform.nvim",
  opts = {
    fromatters_by_ft = {
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
    },
    formatters = {
      my_formatter = {
        cwd = require("conform.util").root_file({
          ".editorconfig",
          "package.json",
          ".prettierrc",
          "prettier.config.js",
        }),
      },
    },
  },
}
