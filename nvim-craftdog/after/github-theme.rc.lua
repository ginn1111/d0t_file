local status, ghTheme = pcall(require, "github-theme")
if (not status) then return end

ghTheme.setup({
  theme_style = "dark",
    function_style = "italic",
    sidebars = {"qf", "vista_kind", "terminal", "packer"},
    comment_style = "NONE",
    keyword_style = "NONE",
    variable_style = "NONE",
    transparent = true,

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    colors = {hint = "orange", error = "#ff0000"},

    -- Overwrite the highlight groups
    overrides = function(c)
      return {
        htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
        DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
        -- this will remove the highlight groups
        TSField = {},
      }
    end
})

