return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  },
  opts = {
    options = {
      separator_style = "slant",
      buffer_close_icon = "",
      max_name_length = 18,
      show_buffer_close_icons = false,
      close_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("lazyvim.config").icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
          separator = false,
        },
      },
    },

    highlights = {
      background = {
        bg = "#011627",
      },
      info = {
        sp = "#fc514e",
        bg = "#011627",
      },
      info_diagnostic = {
        sp = "#fc514e",
        bg = "#011627",
      },
      hint_diagnostic = {
        sp = "#fc514e",
        bg = "#011627",
      },
      error_diagnostic = {
        sp = "#fc514e",
        bg = "#011627",
      },
      warning_diagnostic = {
        sp = "#fc514e",
        bg = "#011627",
      },
      diagnostic = {
        bg = "#011627",
      },
      hint = {
        bg = "#011627",
      },
      error = {
        sp = "#fc514e",
        bg = "#011627",
      },
      warning = {
        sp = "#fc514e",
        bg = "#011627",
      },
      modified = {
        bg = "#011627",
        fg = "#1d3b53",
      },

      fill = {
        bg = "#080808",
      },
      separator = {
        fg = "#080808",
        bg = "#011627",
      },
      separator_visible = {
        fg = "#080808",
        bg = "#1d3b53",
      },
      separator_selected = {
        fg = "#080808",
        bg = "#1d3b53",
      },
      buffer_visible = {
        bg = "#1d3b53",
        fg = "#22C7A8",
        bold = true,
        italic = true,
      },
      buffer_selected = {
        bg = "#1d3b53",
        fg = "#22C7A8",
        bold = true,
        italic = true,
      },
      modified_visible = {
        bg = "#1d3b53",
        fg = "#22C7A8",
      },
      modified_selected = {
        bg = "#1d3b53",
        fg = "#22C7A8",
      },

      diagnostic_visible = {
        bg = "#1d3b53",
        fg = "#22C7A8",
      },
      warning_diagnostic_visible = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },
      warning_visible = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },
      error_visible = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },

      hint_diagnostic_visible = {
        bg = "#1d3b53",
      },
      hint_visible = {
        bg = "#1d3b53",
      },

      warning_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },
      error_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },

      hint_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },
      hint_diagnostic_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },
      diagnostic_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },
      warning_diagnostic_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },

      error_diagnostic_visible = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },
      error_diagnostic_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },

      info_visible = {
        bg = "#1d3b53",
      },
      info_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },
      info_diagnostic_visible = {
        bg = "#1d3b53",
      },
      info_diagnostic_selected = {
        bg = "#1d3b53",
        bold = true,
        italic = true,
      },

      trunc_marker = {
        bg = "#1d3b53",
        fg = "#22C7A8",
      },
    },
  },
}
