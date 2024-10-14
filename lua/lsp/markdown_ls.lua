-- Update this with the actual path to the Markdown language server
local lsp_path = '~/.local/share/lsp/vscode-language-server/node_modules/vscode-langservers-extracted/bin/vscode-markdown-language-server'
lsp_path = vim.fn.expand(lsp_path)

-- Command to start the Markdown Language Server
local cmd = { lsp_path, '--stdio' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',  -- Attach to Markdown file type
  callback = function(args)
    vim.lsp.start({
      name = 'markdown-language-server',
      cmd = cmd,
      root_dir = vim.fs.root(args.buf, { '.git', 'package.json', '.markdownlint.json' }),  -- Change root_dir as per your project's structure
      settings = {
        markdown = {
          validate = true,  -- Enable validation for Markdown
          lint = {
            enable = true,   -- Enable linting with the Markdown Language Server
          },
        },
      },
    })
  end,
})
