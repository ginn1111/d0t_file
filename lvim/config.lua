--general
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

vim.opt.termguicolors = true
vim.opt.relativenumber = true
lvim.log.level = "warn"
lvim.transparent_window = true
lvim.format_on_save.enabled = true
lvim.colorscheme = "monokai"
vim.api.nvim_exec([[
  augroup TelescopeColors
    autocmd!
    autocmd ColorScheme * highlight TelescopeNormal guibg=none
    autocmd ColorScheme * highlight TelescopePrompt guibg=#1f2335
    autocmd ColorScheme * highlight TelescopeBorder guibg=none
  augroup END
]], false)
lvim.autocommands = {
  {
    "ColorScheme",
    { command = "hi NvimTreeNormalNC guibg=NONE" },
  }
}
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }

vim.keymap.set('n', 'dw', 'viw d')
vim.keymap.set('n', 'cw', 'viw c')
vim.keymap.set('n', 'vw', 'viw')

vim.g.nvim_tree_auto_close = '1'
lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true

--Auto close when last windown exsit - NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
        and layout[3] == nil then
      vim.cmd("confirm quit")
    end
  end
})

--Encoding
vim.opt.fileencoding = 'utf-8'

--Fold setting
vim.opt.foldmethod = 'indent'
vim.cmd [[
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup END
]]
-- vim.cmd [[autocmd FileType css, scss setlocal iskeyword += -,?, ! ]]
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 20

--THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
--Lualine
lvim.builtin.lualine.options.section_separators = { left = '', right = '' }
lvim.builtin.lualine.options.component_separators = { left = '', right = '' }

--Theme scheme
lvim.builtin.lualine.options.theme = 'solarized'

-- Nvim TS Rainbow
lvim.builtin.treesitter.rainbow.enable = true

-- Codi
lvim.keys.normal_mode[";oo"] = ":Codi<CR>"
lvim.keys.normal_mode[";ox"] = ":CodiExpand<CR>"

--prettier
vim.g["prettier#autoformat_require_pragma"] = 0
vim.g["prettier#autoformat"] = 1
vim.g["prettier#autoformat_config_present"] = 1
vim.g["prettier#exec_cmd_path"] = "~/.prettierrc"

--Plugin
lvim.plugins = {
  {
    "tanvirtin/monokai.nvim"
  },

  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  }, {
  'terryma/vim-multiple-cursors'
},
  {
    'prettier/vim-prettier'
  },
  {
    'mattn/emmet-vim'
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120,             --Width of the floating window
        height = 50,             --Height of the floating window
        default_mappings = true, --Bind default mappings
        border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
        -- winblend = 10,
        post_open_hook = nil, --A function taking two arguments, a buffer and a window to be ran as a hook.
        focus_on_open = true,
        -- references = {        -- Configure the telescope UI for slowing the references cycling window.
        --   telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        -- },
        bufhidden = "wipe"
      }
    end
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      local status, colorizer = pcall(require, "colorizer")
      if (not status) then return end
      colorizer.setup()
    end
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 1
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,    --Enable 'number' for the window while peeking
        show_cursorline = true, --Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    "overcache/NeoSolarized"
  },
}
--to disable icons and use a minimalist setup, uncomment the following
--lvim.use_icons = true


lvim.leader = ";"
--add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader>n"] = ":tabnew<CR>"
lvim.keys.normal_mode["<leader>v"] = ":vsplit<CR>"
lvim.keys.normal_mode[";ss"] = ":split<CR>"

--unmap a default keymapping
--vim.keymap.del("n", "<C-Up>")
--override a default keymapping
--lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>")

--Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
--we use protected - mode(pcall) just in case the plugin wasn't loaded yet.
--local _, actions = pcall(require, "telescope.actions")
--lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--i = {
--["<C-j>"] = actions.move_selection_next,
--["<C-k>"] = actions.move_selection_previous,
--["<C-n>"] = actions.cycle_history_next,
--["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--n = {
--["<C-j>"] = actions.move_selection_next,
--["<C-k>"] = actions.move_selection_previous,
--   },
-- }

--Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
--lvim.builtin.theme.options.style = "storm"

--Use which - key to add extra bindings with the leader - key prefix
-- lvim.builtin.which_key.mappings[";pp"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.keys.normal_mode[";P"] = "<cmd>Telescope projects<CR>"
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

--TODO: User Config for predefined plugins
--After changing plugin config exit and reopen LunarVim, Run : PackerInstall: PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
-- lvim.builtin.nvimtree.setup.view.preserve_window_proportions = true
-- lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
-- lvim.builtin.telescope.defaults.winblend = 10
lvim.builtin.telescope.pickers.live_grep = {
  layout_strategy = "horizontal",
  layout_config = {
    width = 0.95,
  },
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "json",
  "javascript",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

--generic LSP settings

-- --make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "jsonls",
  "tsserver",
  "tailwindcss"
}
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    exe = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
  },
}
-- --change UI setting of`LspInstallInfo`
-- --see < https://github.com/williamboman/nvim-lsp-installer#default-configuration>
--lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
--lvim.lsp.installer.setup.ui.border = "rounded"
--lvim.lsp.installer.setup.ui.keymaps = {
--uninstall_server = "d",
--toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
--lvim.lsp.installer.setup.automatic_installation = false

-- --- configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- --- see the full default list`:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
--vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
--local opts = {} -- check the lspconfig documentation for a list of all possible options
--require("lvim.lsp.manager").setup("pyright", opts)

-- --- remove a server from the skipped list, e.g.eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- --- `:LvimInfo` lists which server(s) are skipped for the current filetype
--lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
--end, lvim.lsp.automatic_configuration.skipped_servers)

-- --you can set a custom on_attach function that will be used for all the language servers
-- --See < https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
--lvim.lsp.on_attach_callback = function(client, bufnr)
--local function buf_set_option(...)
--vim.api.nvim_buf_set_option(bufnr, ...)
--end
--   --Enable completion triggered by < c - x > <c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--{ command = "black", filetypes = { "python" } },
--{ command = "isort", filetypes = { "python" } },
--{
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = {"--print-with", "100"},
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = {"typescript", "typescriptreact"},
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--{ command = "flake8", filetypes = { "python" } },
--{
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = {"--severity", "warning"},
--   },
--   {
--command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = {"javascript", "python"},
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--{
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--pattern = {"*.json", "*.jsonc"},
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
