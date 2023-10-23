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
        "html",
        "cssls",
        "tailwindcss",
        "tsserver",
        "jsonls",
        "marksman",
        "golangci_lint_ls",
        "ltex",
        "svelte",
        "lua_ls",
        "emmet_ls",
        "pyright",
      },
      automatic_installation = true,
    })
  end,
}
