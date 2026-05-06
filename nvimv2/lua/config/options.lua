local opt = vim.opt

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Color
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true

-- Tabs and indentation
opt.breakindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.expandtab = true
opt.smartindent = true

-- Line numbering, wrapping, columns, and ending
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.colorcolumn = "80"
opt.signcolumn = "yes"

-- Scrolling
opt.scrolloff = 3
opt.sidescrolloff = 5
opt.isfname:append("@-@")

-- Clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Use system clipboard unless SSHing.

-- Split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- List invisible characters
opt.listchars = {
  eol = "↵",
  tab = "▸ ",
  trail = "·",
  precedes = "«",
  extends = "»",
}
opt.list = true

-- Search improvements
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.inccommand = "split"

-- Undo and backups
opt.swapfile = false
opt.backup = false
opt.undofile = true
-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir

-- Performance
opt.updatetime = 150
opt.timeoutlen = 300
opt.redrawtime = 5000
opt.maxmempattern = 5000

-- Built-in autocompletion
opt.completeopt = "menu,menuone,noselect"

-- Hat tip to Duy NG for many of these settings.
-- https://tduyng.com/blog/neovim-basic-setup/

-- Visual settings
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 2 -- How long to show matching bracket
opt.cmdheight = 1 -- Set command line height
opt.showmode = false -- Don't show mode in command line
opt.pumheight = 10 -- Popup menu height
opt.pumblend = 10 -- Popup menu transparency
opt.winblend = 0 -- Floating window transparency
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.concealcursor = "" -- Don't hide cursor line markup
opt.synmaxcol = 300 -- Syntax highlighting limit
opt.ruler = false -- Disable the default ruler
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5 -- Minimum window width

-- Behavior settings
opt.autochdir = false -- Don't auto change directory
opt.iskeyword:append("-") -- Treat dash as part of word
opt.path:append("**") -- include subdirectories in search
opt.selection = "inclusive" -- Selection behavior

-- Folding settings
opt.smoothscroll = true
opt.foldmethod = "expr"
opt.foldlevel = 99 -- Start with all folds open
opt.foldtext = "" -- Use treesitter-rendered fold lines (0.10+)
opt.fillchars = {
  fold = " ",
  foldopen = "▾",
  foldclose = "▸",
  foldsep = " ",
  diff = "╱",
  eob = " ", -- Hide ~ on empty lines past end of buffer
}
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Command-line completion
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
opt.diffopt:append("linematch:60")

vim.g.autoformat = true

opt.jumpoptions = "view"
opt.linebreak = true -- Wrap lines at convenient points
opt.shortmess:append({ W = true, c = true, C = true })

vim.g.markdown_recommended_style = 0
