require("catppuccin").setup({
  transparent_background = true,
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

-- Default options:
-- require("kanagawa").setup({
--   compile = false, -- enable compiling the colorscheme
--   undercurl = true, -- enable undercurls
--   commentStyle = { italic = true },
--   functionStyle = {},
--   keywordStyle = { italic = true },
--   statementStyle = { bold = true },
--   typeStyle = {},
--   transparent = false, -- do not set background color
--   dimInactive = false, -- dim inactive window `:h hl-NormalNC`
--   terminalColors = true, -- define vim.g.terminal_color_{0,17}
--   colors = { -- add/modify theme and palette colors
--     palette = {},
--     theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--   },
--   overrides = function(colors) -- add/modify highlights
--     return {}
--   end,
--   theme = "wave", -- Load "wave" theme when 'background' option is not set
--   background = { -- map the value of 'background' option to a theme
--     dark = "wave", -- try "dragon" !
--     light = "lotus",
--   },
-- })
--
-- vim.cmd("colorscheme kanagawa")
