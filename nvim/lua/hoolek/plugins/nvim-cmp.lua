return {
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
      "windwp/nvim-ts-autotag",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("nvim-autopairs").setup()

      -- Integrate nvim-autopairs with cmp
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Load snippets
      -- require("luasnip.loaders.from_vscode").lazy_load()

      vim.opt.completeopt = "menu,menuone,noselect"

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-u>"] = cmp.mapping.scroll_docs(4), -- scroll up preview
          ["<C-d>"] = cmp.mapping.scroll_docs(-4), -- scroll down preview
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          -- { name = "copilot", group_index = 2 }, -- copilot
          { name = "nvim_lua" }, -- lua
          { name = "nvim_lsp" }, -- lsp
          -- { name = "copilot" }, -- Copilot suggestions
          { name = "path" }, -- file system paths
          { name = "luasnip" }, -- snippets
          { name = "buffer", max_item_cout = 5 }, -- text within current buffer
        }),
        -- configure lspkind for vs-code like icons
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 80,
            ellipsis_char = "...",
          }),
        },
        experimental = {
          -- ghost_text = true,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      lspkind.init({
        symbol_map = {
          Copilot = "",
        },
      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },
}
