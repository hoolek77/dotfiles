return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "gruvbox-material",
        icons_enabled = true,
      },
    })
  end,
}
