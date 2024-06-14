return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-jest",
    "nvim-neotest/neotest-vim-test",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "yarn test --",
          jestConfigFile = "jest.config.js",
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        -- require("neotest-vim-test")({}),
      },
    })
  end,
}
