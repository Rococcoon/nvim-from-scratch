-- CUSTOM KEYMAPS
-- By: LiBRaM

-- VEX COMMANDS --
-- Create a keybinding to open Vex and resize the window
vim.keymap.set("n", "<leader>e", function()
	vim.cmd("Vex") -- Open Vex (Netrw)
	-- After opening Vex, resize the split
	-- Set the width of the Vex window (adjust size as needed)
	vim.cmd("vertical resize 30")
end, { noremap = true, silent = true })

--NAVIGATION IN TEXT EDITOR COMMANDS --
-- Set goto end of line to gl
vim.keymap.set("n", "g;", "$", { noremap = true, silent = true })
vim.keymap.set("v", "g;", "$h", { noremap = true, silent = true })
-- Set goto start of line to gh
vim.keymap.set("n", "gj", "0", { noremap = true, silent = true })
vim.keymap.set("v", "gj", "0", { noremap = true, silent = true })
-- Set goto top of fie to gl
vim.keymap.set("n", "gl", "gg", { noremap = true, silent = true })
vim.keymap.set("v", "gl", "gg", { noremap = true, silent = true })
-- Set goto bottom of file to gk
vim.keymap.set("n", "gk", "G", { noremap = true, silent = true })
vim.keymap.set("v", "gk", "G", { noremap = true, silent = true })

-- Normal mode remaps
vim.keymap.set("n", "j", "h", { noremap = true, silent = true })
vim.keymap.set("n", "k", "j", { noremap = true, silent = true })
vim.keymap.set("n", "l", "k", { noremap = true, silent = true })
vim.keymap.set("n", ";", "l", { noremap = true, silent = true })

-- Visual mode remaps
vim.keymap.set("v", "j", "h", { noremap = true, silent = true })
vim.keymap.set("v", "k", "j", { noremap = true, silent = true })
vim.keymap.set("v", "l", "k", { noremap = true, silent = true })
vim.keymap.set("v", ";", "l", { noremap = true, silent = true })

-- Close Window
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })

-- Close Buffer
vim.api.nvim_set_keymap("n", "<leader>bd", ":bdelete<CR>", { noremap = true, silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap("n", "<leader>p", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":bnext<CR>", { noremap = true, silent = true })

-- Split pane shortcut
vim.keymap.set("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true })

-- Pane navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- navigate left
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- navigate down
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- navigate up
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- navigate right

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

-- Indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Remap redo to "U"
vim.api.nvim_set_keymap("n", "U", "<C-r>", { noremap = true, silent = true })

-- cut text to new lines at 80, format text
-- vim.keymap.set("v", "<leader>ft", ":'<,'>s/.\\{80}/&\\r/g<CR>",
-- { noremap = true, silent = true })

-- Comment plugin
vim.api.nvim_set_keymap("n", "<leader>ac", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>ac", "gcc", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>bc", "gbc", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>bc", "gbc", { noremap = false })
