local linter = {}

function linter.luacheck()
	local filename = vim.fn.expand("%:p") -- Get the current file's absolute path
	local command = string.format("luacheck %s", filename) -- Prepare the command

	-- Execute the command and capture the output
	local handle = io.popen(command)

	-- Check if handle is valid
	if not handle then
		vim.notify("Error: Unable to run luacheck. Is it installed?", vim.log.levels.ERROR)
		return
	end

	local result = handle:read("*a") -- Read the output

	-- Close the handle and check for errors
	local success, err = handle:close()
	if not success then
		vim.notify("Error: " .. err, vim.log.levels.ERROR)
	end

	-- Display the output in Neovim's quickfix list if there are results
	if result and #result > 0 then
		vim.fn.setqflist({}, " ", { title = "Luacheck", lines = vim.split(result, "\n") })
		vim.cmd("copen") -- Open the quickfix window
	else
		vim.notify("No linting issues found.", vim.log.levels.INFO)
	end
end

return linter
