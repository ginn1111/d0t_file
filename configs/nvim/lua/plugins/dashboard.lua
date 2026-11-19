-- Cindy palette (configs/hermes/skins/solarized-osaka-cindy.yaml)
local cindy = {
  red_light = "#f25c59",
  red = "#db302d",
  red_dark = "#a3221f",
  orange = "#c94c16",
  text = "#9eabac",
  dim = "#576d74",
}

-- logo line -> highlight group (top-to-bottom red gradient, like the Cindy banner)
local logo_lines = {
  { " ██████╗ ██╗███╗   ██╗", "DashboardGin1" },
  { "██╔════╝ ██║████╗  ██║", "DashboardGin2" },
  { "██║  ███╗██║██╔██╗ ██║", "DashboardGin2" },
  { "██║   ██║██║██║╚██╗██║", "DashboardGin3" },
  { "╚██████╔╝██║██║ ╚████║", "DashboardGin3" },
  { " ╚═════╝ ╚═╝╚═╝  ╚═══╝", "DashboardGinShadow" },
  { "", nil },
  { "◇ Cindy · Assistant to Gin ◇", "DashboardGinTagline" },
}

local function set_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "DashboardGin1", { fg = cindy.red_light, bold = true })
  hl(0, "DashboardGin2", { fg = cindy.red, bold = true })
  hl(0, "DashboardGin3", { fg = cindy.red_dark, bold = true })
  hl(0, "DashboardGinShadow", { fg = cindy.dim })
  hl(0, "DashboardGinTagline", { fg = cindy.orange, italic = true })
  hl(0, "DashboardHeader", { fg = cindy.red })
  hl(0, "DashboardIcon", { fg = cindy.red })
  hl(0, "DashboardDesc", { fg = cindy.text })
  hl(0, "DashboardKey", { fg = cindy.orange, bold = true })
  hl(0, "DashboardFooter", { fg = cindy.dim, italic = true })
end

-- dashboard-nvim paints the whole header with one group; overlay the per-line gradient.
local function paint_logo(buf)
  local ns = vim.api.nvim_create_namespace("dashboard_gin")
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  local by_text = {}
  for _, l in ipairs(logo_lines) do
    if l[2] then
      by_text[vim.trim(l[1])] = l[2]
    end
  end
  local lines = vim.api.nvim_buf_get_lines(buf, 0, 20, false)
  for i, line in ipairs(lines) do
    local group = by_text[vim.trim(line)]
    if group then
      vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
        end_col = #line,
        hl_group = group,
        priority = 5000,
      })
    end
  end
end

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardLoaded",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].filetype == "dashboard" then
          paint_logo(buf)
        end
      end,
    })
  end,
  opts = function()
    set_highlights()

    local header = { "", "" }
    for _, l in ipairs(logo_lines) do
      table.insert(header, l[1])
    end
    table.insert(header, "")

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = header,
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
          { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "◇ " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms ◇" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
