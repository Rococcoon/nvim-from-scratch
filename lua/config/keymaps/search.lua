-- Mapping for searching the current file

-- Mapping to open file search
vim.api.nvim_set_keymap(
	"n",
	"<leader>sf",
	':lua require("search.search_file").open_file_list()<CR>',
	{ noremap = true, silent = true }
)

-- Mapping to open word search
vim.api.nvim_set_keymap(
	"n",
	"<leader>sw",
	':lua require("search.search_word").open_centered_window()<CR>',
	{ noremap = true, silent = true }
)

-- Mapping to open buffer search
vim.api.nvim_set_keymap(
	"n",
	"<leader>sb",
	':lua require("search.search_buffer").open_buffer_list()<CR>',
	{ noremap = true, silent = true }
)
