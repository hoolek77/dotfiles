return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     require("tokyonight").setup({
  --       transparent = true,
  --       style = "storm",
  --       styles = {
  --         floats = "transparent",
  --       },
  --     })
  --
  --     vim.cmd.colorscheme("tokyonight-storm")
  --   end,
  -- },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("gruvbox").setup({
  --       transparent_mode = true,
  --     })
  --
  --     vim.cmd.colorscheme("gruvbox")
  --   end,
  -- },
  {
    "catppuccin/nvim",
    config = function()
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
          lsp_saga = true,
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
          neogit = true,
          notify = true,
          noice = true,
        },
      })
      vim.cmd.colorscheme("catppuccin-macchiato")

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  --
  --     local c = require("kanagawa.lib.color")
  --
  --     require("kanagawa").setup({
  --       transparent = true,
  --       theme = "wave",
  --       cooverrides = function(colors)
  --         local theme = colors.theme
  --
  --         return {
  --           TelescopeTitle = { fg = theme.ui.special, bold = true },
  --           TelescopePromptNormal = { bg = theme.ui.bg_p1 },
  --           TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
  --           TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
  --           TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
  --           TelescopePreviewNormal = { bg = theme.ui.bg_dim },
  --           TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
  --           NormalFloat = { bg = "none" },
  --           FloatTitle = { bg = "none" },
  --           FloatBorder = { bg = "none" },
  --           LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --           MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --           Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
  --           PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
  --           PmenuSbar = { bg = theme.ui.bg_m1 },
  --           PmenuThumb = { bg = theme.ui.bg_p2 },
  --           NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
  --           TroubleNormal = { link = "NormalDark" },
  --           TroubleNormalNC = { link = "TroubleNormal" },
  --           NeoTreeNormal = { link = "NormalDark" },
  --           DiagnosticVirtualTextError = {
  --             fg = theme.diag.error,
  --             bg = c(theme.diag.error):blend(theme.ui.bg, 0.95):to_hex(),
  --           },
  --           DiagnosticVirtualTextWarn = {
  --             fg = theme.diag.warning,
  --             bg = c(theme.diag.warning):blend(theme.ui.bg, 0.95):to_hex(),
  --           },
  --           DiagnosticVirtualTextHint = {
  --             fg = theme.diag.hint,
  --             bg = c(theme.diag.hint):blend(theme.ui.bg, 0.95):to_hex(),
  --           },
  --           DiagnosticVirtualTextInfo = {
  --             fg = theme.diag.info,
  --             bg = c(theme.diag.info):blend(theme.ui.bg, 0.95):to_hex(),
  --           },
  --           DiagnosticVirtualTextOk = {
  --             fg = theme.diag.ok,
  --             bg = c(theme.diag.ok):blend(theme.ui.bg, 0.95):to_hex(),
  --           },
  --           -- LspInlayHint = { fg = theme.ui.special },
  --           -- EndOfBuffer = { link = 'NonText' }
  --         }
  --       end,
  --     })
  --
  --     vim.cmd.colorscheme("kanagawa-wave")
  --   end,
  -- },
}
