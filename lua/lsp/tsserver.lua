-- Update this with the actual path to the TypeScript Language Server
local lsp_path = "/home/lulu/.nvm/versions/node/v22.9.0/bin/typescript-language-server"
lsp_path = vim.fn.expand(lsp_path)

-- Command to start the TypeScript Language Server
local cmd = { lsp_path, "--stdio" }

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"javascript",
		"javascriptreact",
	}, -- Attach to JavaScript and TypeScript file types
	callback = function(args)
		vim.lsp.start({
			name = "typescript-language-server",
			cmd = cmd,
			root_dir = vim.fs.root(args.buf, {
				"package.json",
				"tsconfig.json",
				".git",
			}), -- Define root directory
		})
	end,
})
