return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
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
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d", -- js linter
        "goimports",
        "golines",
        "ruff", -- python linter/formatter
        "tex-fmt", -- LaTeX formatter
      },
      dependencies = {
        "mason-org/mason.nvim",
      },
    },
  },
}
