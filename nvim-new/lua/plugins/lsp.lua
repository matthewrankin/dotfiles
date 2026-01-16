vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "html",
    "cssls",
    "tailwindcss",
    "templ",
    "ts_ls", -- JavaScript/TypeScript
    "jsonls",
    "marksman", -- Markdown
    "gopls", -- Go language server
    "texlab", -- LaTeX
    "svelte",
    "lua_ls",
    "emmet_ls", -- Emmet HTML/CSS snippets
    "zls", -- Zig language server
    "ruff", -- Python linter/formatter
    "pyright", -- Python type checker
    "rust_analyzer", -- Rust LSP
  },
})
