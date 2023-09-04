return {
  "rmagatti/goto-preview",
  config = function()
    require("goto-preview").setup({
      width = 120, --Width of the floating window
      height = 50, --Height of the floating window
      default_mappings = true, --Bind default mappings
      border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
      -- winblend = 10,
      post_open_hook = nil, --A function taking two arguments, a buffer and a window to be ran as a hook.
      focus_on_open = true,
      -- references = {        -- Configure the telescope UI for slowing the references cycling window.
      --   telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
      -- },
      bufhidden = "wipe",
    })
  end,
}
