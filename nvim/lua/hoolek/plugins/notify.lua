return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")

      require("notify").setup({
        background_colour = "#000000",
      })
      local filtered_message = {
        "No information available",
        "[typescript-tools] We detected usage of `tsserver_path` to integrate with Mason. This integration is now built-in you can remove unnecessary code from your config.",
      }

      -- Override notify function to filter out messages
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.notify = function(message, level, opts)
        local merged_opts = vim.tbl_extend("force", {
          on_open = function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
          end,
        }, opts or {})

        for _, msg in ipairs(filtered_message) do
          if message == msg then
            return
          end
        end
        return notify(message, level, merged_opts)
      end
    end,
  },
}
