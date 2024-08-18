return {
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
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "[h]arpoon add entry",
    },
    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")

        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "[h]arpoon toggle quick menu",
    },
    {
      "<leader>1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "[h]arpoon select 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "[h]arpoon select 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "[h]arpoon select 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "[h]arpoon select 4",
    },
    {
      "<leader>5",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "[h]arpoon select 5",
    },
  },
}
