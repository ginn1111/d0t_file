return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        mdx_analyzer = {
          filetypes = { "mdx" },
        },
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "mdx", -- Ensure vtsls runs on mdx files too
          },
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifierPreference = "non-relative",
              },
            },
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@mdx-js/typescript-plugin",
                    location = vim.fn.stdpath("data")
                      .. "/mason/packages/mdx-analyzer/node_modules/@mdx-js/typescript-plugin",
                    languages = { "mdx" },
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
