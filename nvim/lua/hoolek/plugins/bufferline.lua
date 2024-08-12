return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  enabled = true,
  after = "catppuccin",
  config = function()
    require("bufferline").setup({
      options = {
        separator_style = "thin",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
    })
  end,
}
