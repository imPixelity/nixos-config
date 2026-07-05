-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- UI
vim.opt.wrap = false
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cmdheight = 0

-- File
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo//"

-- Completion
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
--vim.opt.shortmess:append("c")

-- Behavior
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.updatetime = 250
