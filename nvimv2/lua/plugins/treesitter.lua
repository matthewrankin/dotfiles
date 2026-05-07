vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
})

require("nvim-treesitter").setup({})
require("nvim-treesitter").install({
  "bash",
  "bibtex",
  "c",
  "comment",
  "css",
  "diff",
  "dockerfile",
  "gitcommit",
  "go",
  "html",
  "javascript",
  "json",
  "latex",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "svelte",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
  "zig",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_treesitter_start", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.bo[bufnr].filetype
    if filetype == "" then
      return
    end
    local lang = vim.treesitter.language.get_lang(filetype) or filetype
    if pcall(vim.treesitter.start, bufnr, lang) then
      vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Treesitter-based folding (foldmethod = "expr" is set in config/options.lua).
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
