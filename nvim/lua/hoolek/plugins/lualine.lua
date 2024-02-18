return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          -- theme = "onedark",
          theme = "catppuccin",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },
}
