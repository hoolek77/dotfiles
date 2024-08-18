return {
  "ray-x/go.nvim",
  config = function()
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimport()
      end,
      group = format_sync_grp,
    })

    require("go").setup()
  end,
  event = { "CmdlineEnter" },
  build = ':lua require("go.install").update_all_sync()',
}
