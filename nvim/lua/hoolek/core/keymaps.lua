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

-- plugin keymaps

-- maximizer
nnoremap("<leader>sm", ":MaximizerToggle<CR>")

-- ntree
nnoremap("<leader>e", ":NvimTreeToggle<CR>")
nnoremap("<leader>tc", ":NvimTreeCollapse<CR>")

-- Map Oil to <leader>e
-- nnoremap("<leader>e", function()
--   require("oil").toggle_float()
-- end)

-- telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
-- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
nnoremap("<leader>fs", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
nnoremap("<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neoinstance
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvideo)
nnoremap("<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
nnoremap("<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
nnoremap("<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
nnoremap("<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvideo)
nnoremap("<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap("S", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)

-- nspectre search
nnoremap("<leader>S", '<cmd>lua require("spectre").open()<CR>', {
  desc = "Open Spectre",
})
nnoremap("<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
nnoremap("<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
nnoremap("<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})

-- trouble window
nnoremap("<leader>tt", "<cmd>TroubleToggle<cr>")
nnoremap("<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>")

-- diffview
nnoremap("<leader>dv", "<cmd>DiffviewOpen<cr>")

local harpoon = require("harpoon")

nnoremap("<leader>a", function()
  harpoon:list():append()
end)

nnoremap("<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

nnoremap("<leader>1", function()
  harpoon:list():select(1)
end)

nnoremap("<leader>2", function()
  harpoon:list():select(2)
end)

nnoremap("<leader>3", function()
  harpoon:list():select(3)
end)

nnoremap("<leader>4", function()
  harpoon:list():select(4)
end)

nnoremap("<leader>5", function()
  harpoon:list():select(5)
end)

nnoremap("<C-s-p>", function()
  harpoon:list():prev()
end)

nnoremap("<C-s-n>", function()
  harpoon:list():next()
end)

xnoremap("<leader>p", '"_dP')
