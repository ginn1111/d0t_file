return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    -- or "fzf-lua" or "snacks" or "default"
    picker = "telescope",
    -- bare Octo command opens picker of commands
    enable_builtin = true,
  },
  config = function(_, opts)
    require("octo").setup(opts)
    -- Fake alpha: Neovim has no bg transparency, so mix the color into Normal bg.
    local function blend(fg, alpha)
      local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg or 0
      local out = 0
      for shift = 0, 16, 8 do
        local f, b = bit.band(bit.rshift(fg, shift), 0xff), bit.band(bit.rshift(bg, shift), 0xff)
        out = out + bit.lshift(math.floor(f * alpha + b * (1 - alpha) + 0.5), shift)
      end
      return out
    end
    local function set_diff_hl()
      local hl = vim.api.nvim_set_hl
      local green, red = 0x2ea043, 0xf85149 -- GitHub diff green/red
      hl(0, "OctoReviewDiffAdd", { bg = blend(green, 0.25) })
      hl(0, "OctoReviewDiffAddText", { bg = blend(green, 0.70), bold = true })
      hl(0, "OctoReviewDiffDelete", { bg = blend(red, 0.25) })
      hl(0, "OctoReviewDiffDeleteText", { bg = blend(red, 0.70), bold = true })
      -- Pure add/delete lines + filler use global DiffAdd/DiffDelete (theme's neon); tame in octo panes only.
      local c = require("octo.constants")
      for _, ns in ipairs({ c.OCTO_REVIEW_LEFT_HIGHLIGHT_NS, c.OCTO_REVIEW_RIGHT_HIGHLIGHT_NS }) do
        hl(ns, "DiffAdd", { link = "OctoReviewDiffAdd" })
        hl(ns, "DiffDelete", { bg = blend(red, 0.25), fg = blend(red, 0.45) })
      end
    end
    set_diff_hl()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_diff_hl })
  end,
  keys = {
    {
      "<leader>oi",
      "<CMD>Octo issue list<CR>",
      desc = "List GitHub Issues",
    },
    {
      "<leader>op",
      "<CMD>Octo pr list<CR>",
      desc = "List GitHub PullRequests",
    },
    {
      "<leader>od",
      "<CMD>Octo discussion list<CR>",
      desc = "List GitHub Discussions",
    },
    {
      "<leader>on",
      "<CMD>Octo notification list<CR>",
      desc = "List GitHub Notifications",
    },
    {
      "<leader>os",
      function()
        require("octo.utils").create_base_search_command({ include_current_repo = true })
      end,
      desc = "Search GitHub",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    -- OR "ibhagwan/fzf-lua",
    -- OR "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons", -- optional if file_panel.icons is a function
  },
}
