local nnoremap = require("hoolek.core.keymap_utils").nnoremap
local vnoremap = require("hoolek.core.keymap_utils").vnoremap
local xnoremap = require("hoolek.core.keymap_utils").xnoremap

-- general keymaps
nnoremap("<leader>nh", ":nohl<CR>")

nnoremap("x", '"_x')
vnoremap("x", '"_x')

nnoremap("<leader>+", "<C-a>")
nnoremap("<leader>-", "<C-x>")

nnoremap("<leader>sv", "<C-w>v") -- split window vertically
nnoremap("<leader>sh", "<C-w>s") -- split window horizontally
nnoremap("<leader>se", "<C-w>=") -- make split windows equal width
nnoremap("<leader>sx", ":close<CR>") -- close current split window

nnoremap("<leader>to", ":tabnew<CR>") -- open new tab
nnoremap("<leader>tx", ":tabclose<CR>") -- close current tab
nnoremap("<leader>tn", ":tabn<CR>") -- go to next tab
nnoremap("<leader>tp", ":tabp<CR>") -- go to previous tab

xnoremap("p", '"_dP') -- paste without yanking
xnoremap("<leader>p", "dP") -- default paste behavior

-- Center buffer while navigating
nnoremap("<C-d>", "<C-d>zz") -- center view when going half page down
nnoremap("<C-u>", "<C-u>zz") -- center view when going half page up
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")

vnoremap("J", ":m '>+1<CR>gv=gv") -- move selected lines down
vnoremap("K", ":m '<-2<CR>gv=gv") -- move selected lines up

-- tmux sessionizer
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

nnoremap("<leader>gs", "<cmd>Git<cr>") -- git integration

-- restart lsp server (not on youtube nvideo)
nnoremap("<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- neotest
nnoremap("<leader>tf", ":TestFile<CR>")
nnoremap("<leader>tc", ":TestNearest<CR>")

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap("S", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)

-- Press 'S' in visual mode to replace the selected text
vnoremap("<leader>S", function()
  local cmd = [["hy:%s/<C-r>h/<C-r>h/gI<Left><Left><left>]]
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)
