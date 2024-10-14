local M = {}

-- Helper function to recursively collect all files from a directory
local function collect_files(dir, files, root_dir_len)
	local handle = vim.loop.fs_scandir(dir)
	if handle then
		while true do
			local name, type = vim.loop.fs_scandir_next(handle)
			if not name then
				break
			end

			local full_path = dir .. "/" .. name

			-- If it's a file, add it to the list
			if type == "file" then
				-- Get the relative path by stripping the root directory
				local relative_path = full_path:sub(root_dir_len + 1)

				-- Remove the leading slash if it exists
				if relative_path:sub(1, 1) == "/" then
					relative_path = relative_path:sub(2)
				end

				table.insert(files, relative_path)
			elseif type == "directory" then
				-- Recursively collect files from subdirectories
				collect_files(full_path, files, root_dir_len)
			end
		end
	end
end

-- Function to create a floating window displaying a list of all files
-- under the root directory
function M.open_file_list()
	-- Create a new buffer for the header
	local header_buf = vim.api.nvim_create_buf(false, true) -- Scratch buffer for header

	-- Get the current buffer's file path and determine the root directory
	local root_dir = vim.fs.dirname(vim.fs.find({ "init.lua", ".git" }, { upward = true })[1])

	-- Prepare an empty table to hold the list of files
	local files = {}

	-- Calculate the length of the root directory for stripping the full path
	local root_dir_len = #root_dir

	-- Collect all files from the root directory and subdirectories
	collect_files(root_dir, files, root_dir_len)

	-- Set the content of the header buffer
	vim.api.nvim_buf_set_lines(header_buf, 0, -1, false, { "File List (Press <Esc> to close)" })

	-- Create a new buffer for the floating window
	local buf = vim.api.nvim_create_buf(false, true) -- Scratch buffer for file list

	-- Set the content of the buffer (file list)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)

	-- Calculate the dimensions of the windows
	local width = math.ceil(vim.o.columns * 0.9) -- 90% of screen width
	local height = math.ceil(vim.o.lines * 0.6) -- 60% of screen height
	local col = math.ceil((vim.o.columns - width) / 2) -- Center horizontally
	local row = math.ceil((vim.o.lines - height) / 2) -- Center vertically

	-- Adjust heights for the floating windows
	local header_height = 1 -- Height for the header
	local content_height = height - header_height -- Remaining height for the content windows

	-- Adjust width distribution for the two windows
	local list_width = math.ceil(width * 0.5) -- Adjusted to 50% of the total width for the file list
	local content_width = width - list_width -- Remaining width for the content window

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

	-- Create a floating window for the file list
	local win_id = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = list_width, -- Adjusted width for the file list
		height = content_height, -- Use the full remaining height below the header
		col = col,
		row = row + header_height, -- Align vertically with the header's bottom
		style = "minimal",
		border = "rounded",
	})

	-- Create the second buffer for the file content
	local buf_content = vim.api.nvim_create_buf(false, true) -- Scratch buffer for file content

	-- Create the second window beside the first one (split horizontally)
	local content_win_id = vim.api.nvim_open_win(buf_content, false, {
		relative = "editor",
		width = content_width, -- Adjusted width for the content window
		height = content_height,
		col = col + list_width, -- Position beside the first window
		row = row + header_height, -- Align vertically with the header's bottom
		style = "minimal",
		border = "rounded",
	})

	-- Set up key mapping for Escape to close all windows
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", {
		noremap = true,
		silent = true,
		callback = function()
			M.close_windows(win_id, content_win_id)
			vim.api.nvim_win_close(header_win_id, true) -- Close the header window
		end,
	})

	-- Set up key mapping for Enter to open the selected file in a new buffer
	vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
		noremap = true,
		silent = true,
		callback = function()
			local cursor_line = vim.api.nvim_win_get_cursor(win_id)[1]
			local selected_file = files[cursor_line]

			if selected_file then
				-- Close the floating windows
				M.close_windows(win_id, content_win_id)
				vim.api.nvim_win_close(header_win_id, true) -- Close the header window
				-- Open the selected file in the original buffer
				vim.cmd("edit " .. root_dir .. "/" .. selected_file)
			end
		end,
	})

	-- Set up an autocommand to display the content of the file when the cursor moves
	vim.api.nvim_create_autocmd("CursorMoved", {
		buffer = buf,
		callback = function()
			-- Get the line under the cursor
			local cursor_line = vim.api.nvim_win_get_cursor(win_id)[1]
			local file = files[cursor_line]

			-- Ensure the file exists and is valid before attempting to read it
			if file and vim.fn.filereadable(root_dir .. "/" .. file) == 1 then
				-- Read the content of the file
				local content_lines = vim.fn.readfile(root_dir .. "/" .. file)

				-- Add left padding to the file content to avoid cutting off the first characters
				for i, line in ipairs(content_lines) do
					content_lines[i] = "  " .. line -- Add two spaces for padding
				end

				-- Set the content of the second buffer (file content)
				vim.api.nvim_buf_set_lines(buf_content, 0, -1, false, content_lines)

				-- Set the filetype for syntax highlighting based on the file extension
				local extension = file:match("^.+(%..+)$") -- Get file extension
				if extension then
					vim.api.nvim_buf_set_option(buf_content, "filetype", extension:sub(2)) -- Set the file type (strip leading dot)
				else
					vim.api.nvim_buf_set_option(buf_content, "filetype", "text") -- Default to text if no extension
				end
			else
				-- Clear the buffer if no valid file is found
				vim.api.nvim_buf_set_lines(buf_content, 0, -1, false, { "No valid file selected" })
			end
		end,
	})
end

-- Function to close all windows (file list, content, and header)
function M.close_windows(win_id, content_win_id)
	-- Close the content window and its buffer
	vim.api.nvim_win_close(content_win_id, true)
	-- Close the file list window and its buffer
	vim.api.nvim_win_close(win_id, true)
end

return M
