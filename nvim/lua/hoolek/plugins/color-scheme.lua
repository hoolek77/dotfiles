return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup({
      transparent = true,
      style = "storm",
      styles = {
        floats = "transparent",
      },
    })

    -- vim.cmd.colorscheme("tokyonight-storm")
  end,
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })

      vim.cmd.colorscheme("gruvbox")
    end,
  },
  -- {
  --   "catppuccin/nvim",
  --   config = function()
  --     require("catppuccin").setup({
  --       transparent_background = true,
  --       integrations = {
  --         cmp = false,
  --         gitsigns = true,
  --         mason = true,
  --         nvimtree = true,
  --         telescope = {
  --           enabled = true,
  --         },
  --         harpoon = true,
  --         -- fidget = true,
  --         dashboard = true,
  --         indent_blankline = {
  --           enabled = true,
  --           scope_color = "lavender",
  --           colored_indent_levels = true,
  --         },
  --         native_lsp = { enabled = true },
  --         treesitter = true,
  --         treesitter_context = true,
  --         neogit = true,
  --         notify = true,
  --         noice = true,
  --       },
  --     })
  --     -- vim.cmd.colorscheme("catppuccin-macchiato")
  --
  --     -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
  --     for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  --       vim.api.nvim_set_hl(0, group, {})
  --     end
  --   end,
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  --
  --     require("kanagawa").setup({
  --       transparent = true,
  --       overrides = function(colors)
  --         local theme = colors.theme
  --         return {
  --           TelescopeTitle = { fg = theme.ui.special, bold = true },
  --           TelescopePromptNormal = { bg = theme.ui.bg_p1 },
  --           TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
  --           TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
  --           TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
  --           TelescopePreviewNormal = { bg = theme.ui.bg_dim },
  --           TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
  --           TelescopeNormal = { bg = "none" },
  --
  --           NormalFloat = { bg = "none" },
  --           FloatBorder = { bg = "none" },
  --           FloatTitle = { bg = "none" },
  --
  --           -- Save an hlgroup with dark background and dimmed foreground
  --           -- so that you can use it where your still want darker windows.
  --           -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
  --           NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
  --
  --           -- Popular plugins that open floats will link to NormalFloat by default;
  --           -- set their background accordingly if you wish to keep them dark and borderless
  --           LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --           MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --         }
  --       end,
  --       colors = {
  --         theme = {
  --           all = {
  --             ui = {
  --               bg_gutter = "none",
  --             },
  --           },
  --         },
  --       },
  --     })
  --
  --     vim.cmd.colorscheme("kanagawa")
  --   end,
  -- },
}
