-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/config.lua
return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
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
    opts.defaults = {
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      prompt_prefix = "󰜴 ",
      selection_caret = "󱖘 ",
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
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
  end,
}
