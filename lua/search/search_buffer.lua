local M = {}

-- Helper function to find the project root
local function get_project_root()
	local path = vim.fn.expand("%:p:h") -- Get the current buffer's directory

	while path ~= "/" do
		if vim.fn.isdirectory(path .. "/.git") == 1 then -- Check for Git project
			return path
		end
		path = vim.fn.fnamemodify(path, ":h") -- Move up one directory
	end

	return nil -- No project root found
end

-- Helper function to collect all buffers and their names
local function collect_buffers(buffers)
	local project_root = get_project_root() -- Get the project root directory

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			-- Only add non-empty buffer names
			if name ~= "" and project_root then
				-- Trim the path to start from the project root
				local relative_name = name:sub(#project_root + 2) -- +2 to remove the trailing '/'
				table.insert(buffers, { name = relative_name, buf_id = buf }) -- Store name and buffer ID
			end
		end
	end
end

-- Function to close the floating windows
function M.close_windows(win_id, content_win_id)
	if vim.api.nvim_win_is_valid(win_id) then
		vim.api.nvim_win_close(win_id, true) -- Close the buffer list window
	end
	if vim.api.nvim_win_is_valid(content_win_id) then
		vim.api.nvim_win_close(content_win_id, true) -- Close the content window
	end
end

-- Function to create a floating window displaying a list of all buffers
function M.open_buffer_list()
	-- Create a new buffer for the header
	local header_buf = vim.api.nvim_create_buf(false, true) -- Scratch buffer for header

	-- Prepare an empty table to hold the list of buffers
	local buffers = {}

	-- Collect all buffers
	collect_buffers(buffers)

	-- Set the content of the header buffer
	vim.api.nvim_buf_set_lines(header_buf, 0, -1, false, { "Buffer List (Press <Esc> to close)" })

	-- Create a new buffer for the floating window
	local buf = vim.api.nvim_create_buf(false, true) -- Scratch buffer for buffer list

	-- Set the content of the buffer (buffer list)
	local buffer_names = vim.tbl_map(function(b)
		return b.name
	end, buffers) -- Extract names
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, buffer_names)

	-- Calculate the dimensions of the windows
	local width = math.ceil(vim.o.columns * 0.9) -- 90% of screen width
	local height = math.ceil(vim.o.lines * 0.6) -- 60% of screen height
	local col = math.ceil((vim.o.columns - width) / 2) -- Center horizontally
	local row = math.ceil((vim.o.lines - height) / 2) -- Center vertically

	-- Adjust heights for the floating windows
	local header_height = 1 -- Height for the header
	local content_height = height - header_height -- Remaining height for the content window

	-- Adjust width distribution for the two windows
	local list_width = math.ceil(width * 0.5) - 1 -- Adjusted to 50% of the total width for the file list
	local content_width = width - list_width - 1 -- Remaining width for the content window

	-- Create a floating window for the header
	local header_win_id = vim.api.nvim_open_win(header_buf, true, {
		relative = "editor",
		width = width, -- Full width for the header
		height = header_height,
		col = col,
		row = row - header_height, -- Position above the main windows
		style = "minimal",
		border = "rounded",
	})

	-- Create a floating window for the buffer list
	local win_id = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = list_width, -- Adjusted width for the buffer list
		height = content_height, -- Use the full remaining height below the header
		col = col,
		row = row + header_height, -- Align vertically with the header's bottom
		style = "minimal",
		border = "rounded",
	})

	-- Create a second buffer for the file content
	local buf_content = vim.api.nvim_create_buf(false, true) -- Scratch buffer for file content

	-- Create a floating window for the content
	local content_win_id = vim.api.nvim_open_win(buf_content, false, {
		relative = "editor",
		width = content_width, -- Adjusted width for the content window
		height = content_height,
		col = col + (width * 0.5), -- Position beside the first window
		row = row + header_height, -- Align vertically with the header's bottom
		style = "minimal",
		border = "rounded",
	})

	-- Set up syntax highlighting for the content window
	vim.api.nvim_buf_set_option(buf_content, "buftype", "nofile") -- Mark as nofile buffer
	vim.api.nvim_buf_set_option(buf_content, "buflisted", false) -- Do not list in buffer list

	-- Set up key mapping for Escape to close all windows
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", {
		noremap = true,
		silent = true,
		callback = function()
			M.close_windows(win_id, content_win_id)
			if vim.api.nvim_win_is_valid(header_win_id) then
				vim.api.nvim_win_close(header_win_id, true) -- Close the header window if valid
			end
		end,
	})

	-- Set up key mapping for Enter to switch to the selected buffer
	vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
		noremap = true,
		silent = true,
		callback = function()
			local cursor_line = vim.api.nvim_win_get_cursor(win_id)[1]
			local selected_buffer = buffers[cursor_line]

			if selected_buffer then
				-- Close the floating windows
				M.close_windows(win_id, content_win_id)
				if vim.api.nvim_win_is_valid(header_win_id) then
					vim.api.nvim_win_close(header_win_id, true) -- Close the header window if valid
				end
				-- Switch to the selected buffer using the buffer command
				vim.cmd("buffer " .. selected_buffer.buf_id)
			end
		end,
	})

	-- Add a CursorMoved event to update content on hover
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = vim.api.nvim_create_augroup("BufferListHover", { clear = true }),
		buffer = buf,
		callback = function()
			local cursor_line = vim.api.nvim_win_get_cursor(win_id)[1]
			local selected_buffer = buffers[cursor_line]

			if selected_buffer then
				-- Load content from the selected buffer into the content window
				local selected_buf_id = selected_buffer.buf_id
				if vim.api.nvim_buf_is_loaded(selected_buf_id) then
					local content_lines = vim.api.nvim_buf_get_lines(selected_buf_id, 0, -1, false)
					vim.api.nvim_buf_set_lines(buf_content, 0, -1, false, content_lines)

					-- Set the filetype for syntax highlighting
					local filetype = vim.fn.fnamemodify(selected_buffer.name, ":e") -- Get the file extension
					vim.api.nvim_buf_set_option(buf_content, "filetype", filetype) -- Set the filetype for syntax highlighting
				else
					vim.api.nvim_buf_set_lines(buf_content, 0, -1, false, { "<Buffer not loaded>" })
				end
			end
		end,
	})
end

return M
