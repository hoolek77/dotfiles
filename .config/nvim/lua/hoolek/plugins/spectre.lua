return {
  "nvim-pack/nvim-spectre",
  lazy = true,
  cmd = { "Spectre" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "catppuccin/nvim",
  },
  config = function()
    -- local theme = require("catppuccin.palettes").get_palette("macchiato")
    --
    -- vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.red, fg = theme.base })
    -- vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.green, fg = theme.base })

    require("spectre").setup({
      highlight = {
        search = "SpectreSearch",
        replace = "SpectreReplace",
      },
      mapping = {
        ["send_to_qf"] = {
          map = "<C-q>",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix",
        },
      },
      find_engine = {
        ["rg"] = {
          cmd = "rg",
          args = {
            "--pcre2",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
        },
      },
    })
  end,
  keys = {
    {
      "<leader>S",
      function()
        require("spectre").open()
      end,
      desc = "[S]pectre open",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "[s]pectre [w]ord",
    },
  },
}
