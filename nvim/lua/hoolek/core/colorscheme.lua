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
