return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      -- Plugin and UI to automatically install LSPs to stdpath
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      "hrsh7th/cmp-nvim-lsp",
      -- Install none-ls for diagnostics, code actions, and formatting
      "nvimtools/none-ls.nvim",

      -- Install neodev for better nvim configuration and plugin authoring via lsp configurations
      "folke/neodev.nvim",

      {
        "glepnir/lspsaga.nvim",
        branch = "main",
        dependencies = {
          "nvim-tree/nvim-web-devicons",
          "nvim-treesitter/nvim-treesitter",
        },
      }, -- enhanced lsp uis

      "jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
      "jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls

      "jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
      "pmizio/typescript-tools.nvim",
      "onsails/lspkind.nvim", -- vs-code like icons for autocompletion

      "neovim/nvim-lspconfig", -- easily configure language servers

      "princejoogie/tailwind-highlight.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      -- Setup mason so it can manage 3rd party LSP servers
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      -- Configure mason to auto install servers
      require("mason-lspconfig").setup({
        -- list of servers for mason to install
        ensure_installed = {
          -- "tsserver",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "emmet_ls",
          "pyright",
          "astro",
          "gopls",
        },
      })

      require("mason-null-ls").setup({
        -- list of formatters & linters for mason to install
        ensure_installed = {
          "prettier", -- ts/js formatter
          "stylua", -- lua formatter
          "eslint", -- ts/js linter
          "eslint_d", -- ts/js linter
        },
        -- auto-install configured formatters & linters (with null-ls)
        automatic_installation = true,
      })

      local keymap = vim.keymap

      local lspconfig = require("lspconfig")
      local typescript = require("typescript-tools")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local tw_highlight = require("tailwind-highlight")

      -- enable keybinds only for when lsp server available
      local on_attach = function(client, bufnr)
        -- keybind options
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- set keybinds
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
        -- keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- got to declaration
        keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
        keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<CR>", opts) -- go to implementation
        keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", opts) -- go to implementation
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions
        -- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
        keymap.set("n", "<leader>rn", function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, { expr = true })
        keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
        keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
        keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
        keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
        keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
        keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
        keymap.set(
          "n",
          "<leader>ht",
          "<cmd>lua vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())<CR>",
          opts
        ) -- see outline on right hand side

        -- typescript specific keymaps (e.g. rename file and update imports)
        if client.name == "typescript-tools" then
          keymap.set("n", "<leader>rf", ":TSToolsRenameFile<CR>") -- rename file and update imports
          keymap.set("n", "<leader>oi", ":TSToolsOrganizeImports<CR>") -- organize imports
          keymap.set("n", "<leader>ru", ":TSToolsRemoveUnusedImports<CR>") -- remove unused variables
          keymap.set("n", "<leader>mi", ":TSToolsAddMissingImports<CR>") -- add missing imports
        end

        if client.name == "tailwindcss" then
          tw_highlight.setup(client, bufnr, {
            single_column = false,
            mode = "background",
            debounce = 200,
          })
        end
      end

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- configure html server
      lspconfig["html"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      local mason_registry = require("mason-registry")
      local tsserver_path = mason_registry.get_package("typescript-language-server"):get_install_path()

      typescript.setup({
        -- capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tsserver_path = tsserver_path .. "/node_modules/typescript/lib/tsserver.js",
          tsserver_file_preferences = {
            includeCompletionsForModuleExports = true,
            importModuleSpecifierPreference = "non-relative",
            importModuleSpecifierEnding = "non-relative",
          },
          tsserver_plugins = {
            -- for TypeScript v4.9+
            "@styled/typescript-styled-plugin",
            -- or for older TypeScript versions
            -- "typescript-styled-plugin",
          },
        },
      })

      -- configure css server
      lspconfig["cssls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure tailwindcss server
      lspconfig["tailwindcss"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              },
            },
          },
        },
      })

      -- configure astro server
      lspconfig["astro"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure golang server
      lspconfig["gopls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure emmet language server
      lspconfig["emmet_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      })

      -- configure lua server (with special settings)
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
            hint = { enable = true },
          },
        },
      })

      -- configure python server
      lspconfig["pyright"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "python" },
      })

      local saga = require("lspsaga")

      saga.setup({
        -- keybinds for navigation in lspsaga window
        scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
        -- use enter to open file with definition preview
        definition = {
          keys = {
            edit = "<CR>",
          },
        },
        ui = {
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      })

      -- for conciseness
      local formatting = null_ls.builtins.formatting -- to setup formatters
      local diagnostics = null_ls.builtins.diagnostics -- to setup linters

      -- to setup format on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- configure null_ls
      null_ls.setup({
        border = "rounded",
        -- setup formatters & linters
        sources = {
          formatting.prettier, -- js/ts formatter
          formatting.stylua, -- lua formatter
          diagnostics.eslint.with({ -- js/ts linter
            diagnostics_format = " [eslint]#{m}\n(#{c})",
          }),
          formatting.eslint_d,
          -- python development
          diagnostics.mypy,
          diagnostics.ruff,
          formatting.black,
        },
        -- configure format on save
        on_attach = function(current_client, bufnr)
          if current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(client)
                    --  only use null-ls for formatting instead of lsp server
                    return client.name == "null-ls"
                  end,
                  bufnr = bufnr,
                })
              end,
            })
          end
        end,
      })
    end,
  },
}
