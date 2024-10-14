-- Update this with the actual path to the JSON language server
local lsp_path = '~/.local/share/lsp/vscode-language-server/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server'
lsp_path = vim.fn.expand(lsp_path)

-- Command to start the JSON Language Server
local cmd = { lsp_path, '--stdio' }  -- Using --stdio for standard I/O

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json' },  -- Match only JSON file types
  callback = function(args)
    vim.lsp.start({
      name = 'json-language-server',
      cmd = cmd,
      root_dir = vim.fs.root(args.buf, { '.git', 'package.json' }),  -- Change root_dir as per your project's structure
      settings = {
        json = {
          schemas = {
            -- Example schema: you can customize or add your own schemas
            {
              fileMatch = { 'package.json' },
              url = 'https://json.schemastore.org/package.json',
            },
            {
              fileMatch = { 'tsconfig.json', 'jsconfig.json' },
              url = 'https://json.schemastore.org/tsconfig',
            },
            -- Add more schemas as needed
          },
        },
      },
    })
  end,
})
