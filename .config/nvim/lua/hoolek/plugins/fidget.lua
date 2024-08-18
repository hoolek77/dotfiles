return {
  "j-hui/fidget.nvim",
  event = { "BufEnter" },
  config = function()
    -- Turn on LSP, formatting, and linting status and progress information
    require("fidget").setup({
      notification = {
        window = {
          winblend = 0,
          relative = "editor",
        },
      },
    })
  end,
}
