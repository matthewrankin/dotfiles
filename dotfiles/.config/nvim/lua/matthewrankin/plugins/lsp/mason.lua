return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "html", -- HTML
        "cssls", -- CSS
        "tailwindcss", -- Tailwind CSS
        "tsserver", -- JavaScript/TypeScript
        "jsonls", -- JSON
        "marksman", -- Markdown
        "golangci_lint_ls", -- Go LSP
        "gopls", -- Gopls
        "texlab", -- LaTeX
        "svelte", -- Svelte
        "lua_ls", -- Lua
        "emmet_ls", -- Emmet HTML/CSS snippets
        "pyright", -- Python
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        "flake8",
        "goimports",
        "golines",
      },
    })
  end,
}
