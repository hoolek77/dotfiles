return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = true,
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "kanagawa",
      },
    })
  end,
}
