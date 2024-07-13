return {
  "f-person/git-blame.nvim",
  config = function()
    require("gitblame").setup({
      enabled = false,
    })
  end,
  keys = {
    {
      "<leader>gb",
      "<cmd>GitBlameToggle<cr>",
      desc = "[g]it [b]lame toggle",
    },
  },
}
