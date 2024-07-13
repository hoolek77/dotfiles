return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local fb_actions = require("telescope").extensions.file_browser.actions

    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.load_extension("live_grep_args")

    -- configure telescope
    telescope.setup({
      -- configure custom mappings
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
          },
          n = {
            ["q"] = actions.close,
          },
        },
        file_ignore_patterns = {
          ".git/",
          "node_modules/",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            -- your custom insert mode mappings
            ["i"] = {
              ["<C-w>"] = function()
                vim.cmd("normal vbd")
              end,
            },
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
            },
          },
        },
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        },
      },
    })

    vim.keymap.set("n", "<leader>sf", function()
      telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40 },
      })
    end)

    telescope.load_extension("fzf")
  end,
  keys = {
    {
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      desc = "[f]ind [f]iles",
    },
    {
      "<leader>fs",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "[f]ind [s]tring",
    },
    {
      "<leader>fc",
      "<cmd>Telescope grep_string<cr>",
      desc = "[f]ind [c]ursor",
    },
    {
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
      desc = "[f]ind [b]uffer",
    },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<cr>",
      desc = "[f]ind [h]elp",
    },
    {
      "<leader>gc",
      "<cmd>Telescope git_commits<cr>",
      desc = "[g]it [c]ommits",
    },
    {
      "<leader>gfc",
      "<cmd>Telescope git_bcommits<cr>",
      desc = "[g]it [f]ile [c]ommits",
    },
  },
}
