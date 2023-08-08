-- require("onedark").setup({
--   style = "darker",
--   transparent = true,
-- })
-- require("onedark").load()
-- vim.cmd.colorscheme("onedark")

require("catppuccin").setup({
  transparent_background = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    mason = true,
    nvimtree = true,
    -- telescope = {
    --   enabled = true,
    -- },
    harpoon = true,
  },
})
vim.cmd.colorscheme("catppuccin")
