-- Update this with the actual path to the ESLint language server
local lsp_path =
	"~/.local/share/lsp/vscode-language-server/node_modules/vscode-langservers-extracted/bin/vscode-eslint-language-server"
lsp_path = vim.fn.expand(lsp_path)

-- Command to start the ESLint Language Server
local cmd = { lsp_path, "--stdio" } -- Using --stdio for standard I/O
print("Command to be executed:", table.concat(cmd, " ")) -- Print the command

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" }, -- Attach to JS/TS file types
	callback = function(args)
		vim.lsp.start({
			name = "eslint-language-server",
			cmd = cmd,
			root_dir = vim.fs.root(args.buf, { ".git", "package.json", ".eslintrc", ".eslintrc.js", ".eslintrc.json" }), -- Change root_dir as per your project's structure
			settings = {
				format = { enable = true }, -- Enable formatting with ESLint
				lint = { enable = true }, -- Enable linting with ESLint
			},
		})
	end,
})
