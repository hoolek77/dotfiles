if vim.g.vscode then
  require("core.keymaps")
else
  require("hoolek.core.options")
  require("hoolek.core.lazy")
  require("hoolek.core.lsp")
  require("hoolek.core.keymaps")
  require("hoolek.core.commands")
  require("hoolek.core.fugitive")
  require("hoolek.core.highlight_yank")
end
