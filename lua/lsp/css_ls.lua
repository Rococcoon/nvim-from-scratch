-- Update this with the actual path to the CSS language server
local lsp_path =
	"/home/lulu/.local/share/lsp/vscode-language-server/node_modules/vscode-langservers-extracted/bin/vscode-css-language-server"
lsp_path = vim.fn.expand(lsp_path)

-- Command to start the CSS Language Server
local cmd = { lsp_path, "--stdio" } -- Using --stdio for standard I/O

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "css", "scss", "less" }, -- Include other CSS-like file types if needed
	callback = function(args)
		vim.lsp.start({
			name = "css-language-server",
			cmd = cmd,
			root_dir = vim.fs.root(args.buf, { ".git", "package.json" }), -- Change root_dir as per your project's structure
			settings = {
				css = {
					validate = true, -- Enable validation
					lint = {
						enable = true, -- Enable linting
					},
					format = {
						enable = true, -- Enable formatting
					},
				},
			},
		})
	end,
})
