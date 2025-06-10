return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
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
        "zls", -- Zig
        "ruff", -- Python linter/formatter
        "pyright", -- Python type checker
        "rust_analyzer", -- Rust LSP
      },
      automatic_installation = true,
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d", -- js linter
        "goimports",
        "golines",
        "ruff", -- python linter/formatter
        "tex-fmt", -- LaTeX formatter
      },
    })
  end,
}
