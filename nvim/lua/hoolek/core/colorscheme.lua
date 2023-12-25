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
  },
  transparent_background = true,
})
vim.cmd.colorscheme("catppuccin-mocha")
