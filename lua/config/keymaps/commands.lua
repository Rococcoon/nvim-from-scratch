-- CUSTOM COMMANDS
-- By: LBRM

-- Indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Remap redo to "U"
vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true, silent = true })

-- Add and Remove Comments
vim.api.nvim_set_keymap("n", "<leader>ac", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>ac", "gcc", { noremap = false })

-- VEX COMMANDS --
-- Create a keybinding to open Vex and resize the window
vim.keymap.set("n", "<leader>e", function()
  vim.cmd('Vex')  -- Open Vex (Netrw)
  -- After opening Vex, resize the split
  -- Set the width of the Vex window (adjust size as needed)
  vim.cmd('vertical resize 30')
end, { noremap = true, silent = true })
