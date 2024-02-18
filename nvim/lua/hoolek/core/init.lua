if vim.g.vscode then
  require("core.keymaps")
else
  require("hoolek.core.options")
  require("hoolek.core.lazy")
  require("hoolek.core.keymaps")
  require("hoolek.core.fugitive")
end
