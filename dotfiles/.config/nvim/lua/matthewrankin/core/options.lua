-- Set leader key
vim.g.mapleader = " "

-- Disable netrw, since I'm using nvim-tree.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Color
vim.opt.termguicolors = true

-- Tabs and indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true

-- Line numbering, wrapping, and ending
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.colorcolumn = "80"

-- List characters
vim.opt.listchars = {
  eol = '↲',
  tab = '▸ ',
  trail = '·',
}
vim.opt.list = true

-- Search improvements
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Undo and backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Scrolling
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Fast update time
vim.opt.updatetime = 50
