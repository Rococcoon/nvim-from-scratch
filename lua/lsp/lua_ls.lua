-- Update this with the actual path to the Lua language server
local lsp_path = '~/.local/share/lsp/lua-language-server/bin/lua-language-server'
lsp_path = vim.fn.expand(lsp_path)

-- Command to start the Lua Language Server
local cmd = { lsp_path }

vim.api.nvim_create_autocmd('FileType', {
  -- This handler will fire when the buffer's 'filetype' is "python"
  pattern = 'lua',
  callback = function(args)

    vim.lsp.start({
      name = 'lua-language-server',
      cmd = cmd,
      -- Set the "root directory" to the parent directory of the file in the
      -- current buffer (`args.buf`) that contains either a "setup.py" or a
      -- "pyproject.toml" file. Files that share a root directory will reuse
      -- the connection to the same LSP server.
      root_dir = vim.fs.root(args.buf, { 'init.lua', '.git' }),
      -- Lua language-specific settings
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            -- Recognize Neovim's 'vim' global
            globals = { 'vim' },
          },
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
          },
        },
      },
    })
  end,
})
