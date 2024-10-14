-- CUSTOM MOTION KEYMAPS
-- by: LBRM


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

-- Normal mode remaps for jkl;
vim.keymap.set("n", "j", "h", { noremap = true, silent = true })
vim.keymap.set("n", "k", "j", { noremap = true, silent = true })
vim.keymap.set("n", "l", "k", { noremap = true, silent = true })
vim.keymap.set("n", ";", "l", { noremap = true, silent = true })

-- Visual mode remaps for jkl;
vim.keymap.set("v", "j", "h", { noremap = true, silent = true })
vim.keymap.set("v", "k", "j", { noremap = true, silent = true })
vim.keymap.set("v", "l", "k", { noremap = true, silent = true })
vim.keymap.set("v", ";", "l", { noremap = true, silent = true })
