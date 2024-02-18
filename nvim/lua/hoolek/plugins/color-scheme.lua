return {
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        -- transparent_background = true,
        integrations = {
          cmp = false,
          gitsigns = true,
          mason = true,
          nvimtree = true,
          telescope = {
            enabled = true,
          },
          harpoon = true,
          fidget = true,
          dashboard = true,
          indent_blankline = {
            enabled = true,
            scope_color = "lavender",
            colored_indent_levels = true,
          },
          native_lsp = { enabled = true },
          treesitter = true,
          treesitter_context = true,
        },
        -- transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin-mocha")

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
}
