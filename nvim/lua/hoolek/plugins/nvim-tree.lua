local setup, nvimtree = pcall(require, "nvim-tree")

if not setup then
  return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvimtree.setup({
  -- change folder arrow icons
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        folder = {
          -- arrow_closed = "", -- arrow when folder is closed
          -- arrow_open = "", -- arrow when folder is open
        },
      },
    },
  },
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  view = {
    width = 40,
    side = "left",
    adaptive_size = true,
    number = false,
    relativenumber = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
    custom = {
      ".cache",
      ".git/",
      ".DS_Store",
      ".vscode",
      "/out",
      "turbo",
    },
  },
})
