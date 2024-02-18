return {
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({
        settings = {
          save_on_toggle = true,
          save_on_ui_close = true,
        },
      })
    end,
  },
}
