local M = {}

-- Path to your Prettier executable
local prettier_path = "/home/lulu/.local/bin/prettier"

-- Function to format files using Prettier
function M.format()
    -- Write the file so format works
    vim.cmd("write")

    -- Get the current buffer name (the file you're editing)
    local buf_name = vim.api.nvim_buf_get_name(0)

    -- Execute Prettier formatter
    -- Use `--write` flag to format and overwrite the file
    local result = vim.fn.system(prettier_path .. " --write " .. buf_name)

    -- Check for errors
    if vim.v.shell_error ~= 0 then
        print("Error formatting with Prettier: " .. result)
    else
        -- Reload the buffer after formatting to reflect changes
        vim.cmd("edit")
    end
end

return M
