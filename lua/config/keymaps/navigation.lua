-- CUSTOM NAVIGATION
-- by: LBRM

-- Close Window
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })

-- Close Buffer
vim.api.nvim_set_keymap("n", "<leader>bd", ":bdelete<CR>", { noremap = true, silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap("n", "<leader>p", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":bnext<CR>", { noremap = true, silent = true })

-- Split pane shortcut
vim.keymap.set("n", "<leader>wh", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { noremap = true, silent = true })

-- Pane navigation
vim.keymap.set("n", "<leader>wj", "<C-w>h", { noremap = true, silent = true }) -- navigate left
vim.keymap.set("n", "<leader>wk", "<C-w>j", { noremap = true, silent = true }) -- navigate down
vim.keymap.set("n", "<leader>wl", "<C-w>k", { noremap = true, silent = true }) -- navigate up
vim.keymap.set("n", "<leader>w;", "<C-w>l", { noremap = true, silent = true }) -- navigate right

-- map keys for numeric navigation between tabs
vim.api.nvim_set_keymap("n", "<Leader>1", ":tabnext 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>2", ":tabnext 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>3", ":tabnext 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>4", ":tabnext 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>5", ":tabnext 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>6", ":tabnext 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>7", ":tabnext 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>8", ":tabnext 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>9", ":tabnext 9<CR>", { noremap = true, silent = true })
