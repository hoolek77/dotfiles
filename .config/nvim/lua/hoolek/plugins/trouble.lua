return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble<cr>",
      desc = "[t]rouble [t]oggle",
    },
    {
      "<leader>tw",
      "<cmd>Trouble diagnostics<cr>",
      desc = "[t]rouble diagnostics",
    },
    {
      "<leader>td",
      "<cmd>Trouble document_diagnostics<cr>",
      desc = "[t]rouble [d]ocument",
    },
    {
      "<leader>tq",
      "<cmd>Trouble quickfix<cr>",
      desc = "[t]rouble [q]uickfix",
    },
    {
      "<leader>qn",
      "<cmd>cn<cr>",
      desc = "[q]uickfix [n]ext",
    },
    {
      "<leader>qp",
      "<cmd>cp<cr>",
      desc = "[q]uickfix [p]revious",
    },
  },
}
