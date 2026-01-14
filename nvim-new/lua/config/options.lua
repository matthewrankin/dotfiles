local opt = vim.opt

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
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
opt.smarttab = true

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

-- Backspace
opt.backspace = "indent,eol,start"

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
opt.incsearch = true
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
vim.opt.updatetime = 150
vim.opt.timeoutlen = 300
opt.redrawtime = 5000
opt.maxmempattern = 5000

-- Built-in autocompletion
opt.completeopt = "menu,menuone,noselect"

vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- The following are from Duy NG.
-- https://tduyng.com/blog/neovim-basic-setup/

-- Visual settings
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 2 -- How long to show matching bracket
opt.cmdheight = 1 -- Command line height
opt.showmode = false -- Don't show mode in command line
opt.pumheight = 10 -- Popup menu height
opt.pumblend = 10 -- Popup menu transparency
opt.winblend = 0 -- Floating window transparency
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
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
opt.selection = "exclusive" -- Selection behavior
opt.modifiable = true -- Allow buffer modifications
opt.encoding = "UTF-8" -- Set encoding

-- Folding settings
opt.smoothscroll = true
vim.wo.foldmethod = "expr"
opt.foldlevel = 99 -- Start with all folds open
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Command-line completion
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
opt.diffopt:append("linematch:60")

vim.g.autoformat = true
vim.g.trouble_lualine = true

opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.shortmess:append({ W = true, I = true, c = true, C = true })

vim.g.markdown_recommended_style = 0

vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})

