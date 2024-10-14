-- nvim/lua/formatter/stylua.lua
local M = {}

-- Path to your stylua executable
local stylua_path = "/home/lulu/.cargo/bin/stylua"

-- Function to format Lua files using stylua
function M.format()
	-- Write file so format works
	vim.cmd("write")

	-- Get the current buffer name (the Lua file you're editing)
	local buf_name = vim.api.nvim_buf_get_name(0)

	-- Execute the stylua formatter
	vim.fn.system(stylua_path .. " " .. buf_name)

	-- Reload the buffer after formatting to reflect changes
	vim.cmd("edit")
end

return M
