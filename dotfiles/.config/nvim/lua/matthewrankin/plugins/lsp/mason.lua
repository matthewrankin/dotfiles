return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        }
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "html",             -- HTML
        "cssls",            -- CSS
        "tailwindcss",      -- Tailwind CSS
        "tsserver",         -- JavaScript/TypeScript
        "jsonls",           -- JSON
        "marksman",         -- Markdown
        "golangci_lint_ls", -- Go LSP
        "gopls",            -- Gopls
        "ltex",             -- LaTeX
        "svelte",           -- Svelte
        "lua_ls",           -- Lua
        "emmet_ls",         -- Emmet HTML/CSS snippets
        "pyright",          -- Python
      },
      automatic_installation = true,
    })
  end,
}
