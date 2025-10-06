vim.cmd("let g:netrw_liststyle = 3")

-- Color
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true

-- Tabs and indentation
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- Set textwidth if this is a markdown document.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "tex" },
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

-- Line numbering, wrapping, and ending
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.colorcolumn = "80"

-- Highight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- List characters
vim.opt.listchars = {
  eol = "↵",
  tab = "▸ ",
  trail = "·",
  precedes = "«",
  extends = "»",
}
-- vim.opt.list = true

-- Search improvements
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"

-- Undo and backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Scrolling
vim.opt.scrolloff = 3
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Fast update time
vim.opt.updatetime = 150
vim.opt.timeoutlen = 300

-- Built-in autocompletion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method("textDocument/completion") then
      -- Enable completion with more aggressive settings for Go
      local completion_opts = { autotrigger = true }
      if vim.bo[ev.buf].filetype == "go" then
        -- More aggressive completion for Go files
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      end
      vim.lsp.completion.enable(true, client.id, ev.buf, completion_opts)
    end
  end,
})

vim.diagnostic.config({ virtual_lines = { current_line = true } })
