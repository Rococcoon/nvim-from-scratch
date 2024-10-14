-- Update this with the actual path to the HTML language server
local lsp_path =
	"~/.local/share/lsp/vscode-language-server/node_modules/vscode-langservers-extracted/bin/vscode-html-language-server"
lsp_path = vim.fn.expand(lsp_path)

-- Command to start the HTML Language Server
local cmd = { lsp_path, "--stdio" } -- Using --stdio for standard I/O

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "htm" }, -- Include other HTML-like file types if needed
	callback = function(args)
		vim.lsp.start({
			name = "html-language-server",
			cmd = cmd,
			root_dir = vim.fs.root(args.buf, { ".git", "package.json" }), -- Change root_dir as per your project's structure
			settings = {
				html = {
					format = {
						enable = true, -- Enable formatting
					},
					validate = true, -- Enable validation
				},
			},
		})
	end,
})
