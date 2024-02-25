return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.colorcolumn = ""
        end,
      })

      local oil = require("oil")

      local copy_entry_relative_path = function()
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()
        if not entry or not dir then
          return
        end
        local filepath = dir .. entry.name
        local relpath = vim.fn.fnamemodify(filepath, ":.")
        vim.fn.setreg("+", relpath)
      end

      oil.setup({
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-\\>"] = "actions.select_vsplit",
          ["<C-enter>"] = "actions.select_split", -- this is used to navigate left
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["gy"] = "actions.copy_entry_path",
          ["gY"] = copy_entry_relative_path,
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
}
