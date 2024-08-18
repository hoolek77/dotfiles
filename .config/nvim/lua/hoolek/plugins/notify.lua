return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require("notify")

    notify.setup({
      render = "compact",
      background_colour = "#000000",
    })

    local banned_messages = {
      "No information available",
      "[typescript-tools] We detected usage of `tsserver_path` to integrate with Mason. This integration is now built-in you can remove unnecessary code from your config.",
    }

    vim.notify = function(msg, ...)
      for _, banned_msg in ipairs(banned_messages) do
        if string.find(msg, banned_msg) then
          return
        end
      end
      require("notify")(msg, ...)
    end
  end,
}
