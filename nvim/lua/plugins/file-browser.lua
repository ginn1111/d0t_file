return {
  "nvim-telescope/telescope-file-browser.nvim",
  keys = {
    {
      "<C-p>",
      ":Telescope file_browser path=%:p:h=%:p:h<cr>",
      desc = "Browser file",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
