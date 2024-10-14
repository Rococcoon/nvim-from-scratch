local opt = vim.opt

-- Tabs / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = '80'
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 11
opt.completeopt = "menuone,noinsert,noselect"

-- Add transparency where desired
vim.cmd([[
	hi Normal guibg=NONE ctermbg=NONE
	hi NormalNC guibg=NONE ctermbg=NONE
	hi NormalSB guibg=NONE ctermbg=NONE
	hi NormalFloat guibg=NONE ctermbg=NONE
	hi FloatBorder guibg=NONE ctermbg=NONE
	hi SignColumn guibg=NONE ctermbg=NONE
]])

-- Behavior
opt.hidden = true -- Hide buffer when abandoned
opt.errorbells = false
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.clipboard:append("unnamedplus") -- synchronize nvim clipboard with system clipboard
opt.modifiable = true
opt.encoding = "UTF-8"
opt.inccommand = "split" -- add window while using commands
