-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/config.lua
return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "debugloop/telescope-undo.nvim",
      keys = { { "<leader>U", "<cmd>Telescope undo<cr>" } },
      config = function()
        require("telescope").load_extension("undo")
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  keys = {
    {
      "<leader>fn",
      function()
        local telescope = require("telescope")
        telescope.extensions.notify.notify({
          layout_strategy = "center",
          layout_config = {
            prompt_position = "top",
          },
        })
      end,
    },
    {
      "<leader>fl",
      function()
        local files = {} ---@type table<string, string>
        for _, plugin in pairs(require("lazy.core.config").plugins) do
          repeat
            if plugin._.module then
              local info = vim.loader.find(plugin._.module)[1]
              if info then
                files[info.modpath] = info.modpath
              end
            end
            plugin = plugin._.super
          until not plugin
        end
        require("telescope.builtin").live_grep({
          default_text = "/",
          search_dirs = vim.tbl_values(files),
        })
      end,
      desc = "Find Lazy Plugin Spec",
    },
    {
      "<leader>fP",
      function()
        require("telescope.builtin").find_files({
          cwd = require("lazy.core.config").options.root,
        })
      end,
      desc = "Find Plugin File",
    },
    {
      ";f",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          no_ignore = false,
          hidden = true,
        })
      end,
    },
    {
      ";r",
      function()
        local builtin = require("telescope.builtin")
        builtin.live_grep()
      end,
    },
    {
      "\\\\",
      function()
        local builtin = require("telescope.builtin")
        builtin.buffers()
      end,
    },
    {
      ";t",
      function()
        local builtin = require("telescope.builtin")
        builtin.help_tags()
      end,
    },
    {
      ";;",
      function()
        local builtin = require("telescope.builtin")
        builtin.resume()
      end,
    },
    {
      ";s",
      function()
        local builtin = require("telescope.builtin")
        builtin.treesitter()
      end,
    },
    {
      "sf",
      function()
        local telescope = require("telescope")
        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
        })
      end,
    },
  },

  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    -- local colors = {
    --   surface0 = "#1d3b53",
    --   surface1 = "#2d5d84",
    --   mantle = "#011627",
    --   primary = "#22C7A8",
    --   accent = "#2d5d84",
    --   text = "#011627",
    -- }

    -- local TelescopeColor = {
    --   TelescopeMatching = { fg = colors.text, bg = colors.primary },
    --   TelescopeSelection = { bg = colors.accent },
    --
    --   TelescopePromptPrefix = { bg = colors.surface1 },
    --   TelescopePromptNormal = { bg = colors.surface1 },
    --   TelescopeResultsNormal = { bg = colors.surface0 },
    --   TelescopePreviewNormal = { bg = colors.surface0 },
    --   TelescopePromptBorder = { bg = colors.surface1, fg = colors.surface1 },
    --   TelescopeResultsBorder = { bg = colors.surface0, fg = colors.surface0 },
    --   TelescopePreviewBorder = { bg = colors.surface0, fg = colors.surface0 },
    --   TelescopePromptTitle = { bg = colors.primary, fg = colors.text },
    --   TelescopeResultsTitle = { fg = colors.primary },
    --   TelescopePreviewTitle = { bg = colors.primary, fg = colors.text },
    --   TelescopePreviewLine = { bg = colors.accent },
    -- }

    -- for hl, col in pairs(TelescopeColor) do
    --   vim.api.nvim_set_hl(0, hl, col)
    -- end

    opts.defaults = {
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      prompt_prefix = "󰜴 ",
      -- selection_caret = "  ",
      wrap_results = true,
      layout_strategy = "horizontal",
      layout_config = {
        height = 40,
        prompt_position = "bottom",
        horizontal = {
          preview_width = 0.5, -- Set preview window to take 50% of the total width
        },
        vertical = {
          preview_height = 0.5, -- In case you're using vertical layout, set the preview height
        },
      },
      file_ignore_patterns = { "node_modules" },
      sorting_strategy = "ascending",
      initial_mode = "normal",
      winblend = 0,
      mappings = {
        n = {
          ["h"] = fb_actions.goto_parent_dir,
          ["<C-u>"] = function(prompt_bufnr)
            for _ = 1, 10 do
              actions.move_selection_previous(prompt_bufnr)
            end
          end,
          ["<C-f>"] = function(prompt_bufnr)
            for _ = 1, 10 do
              actions.move_selection_next(prompt_bufnr)
            end
          end,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
        },
      },
    }
    opts.pickers = {
      find_files = {
        initial_mode = "insert",
      },
      live_grep = {
        initial_mode = "insert",
      },
    }
    opts.extensions = {
      file_browser = {
        layout_strategy = "horizontal",
        mappings = {
          ["n"] = {
            ["N"] = fb_actions.create,
            ["<PageUp>"] = actions.preview_scrolling_up,
            ["<PageDown>"] = actions.preview_scrolling_down,
          },
        },
      },
    }
    telescope.setup(opts)
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("notify")
    require("telescope").load_extension("undo")
  end,
}
