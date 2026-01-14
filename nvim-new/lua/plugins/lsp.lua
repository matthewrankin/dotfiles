vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()

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
    "zls", -- Zig language server
    "ruff", -- Python linter/formatter
    "pyright", -- Python type checker
    "rust_analyzer", -- Rust LSP
  },
  automatic_installation = true,
})

-- LSP attach autocmd for keymaps and settings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Enable built-in LSP completion
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

    local Snacks = require("snacks")

    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    -- LSP actions
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<leader>cf", vim.lsp.buf.format, "Format")

    -- LSP navigation (using Snacks picker)
    map("gd", function()
      Snacks.picker.lsp_definitions()
    end, "Goto Definition")
    map("gD", function()
      Snacks.picker.lsp_declarations()
    end, "Goto Declaration")
    map("gr", function()
      Snacks.picker.lsp_references()
    end, "References")
    map("gI", function()
      Snacks.picker.lsp_implementations()
    end, "Goto Implementation")
    map("gy", function()
      Snacks.picker.lsp_type_definitions()
    end, "Goto Type Definition")
    map("<leader>ss", function()
      Snacks.picker.lsp_symbols()
    end, "LSP Symbols")
    map("<leader>sS", function()
      Snacks.picker.lsp_workspace_symbols()
    end, "LSP Workspace Symbols")
    map("gai", function()
      Snacks.picker.lsp_incoming_calls()
    end, "Calls Incoming")
    map("gao", function()
      Snacks.picker.lsp_outgoing_calls()
    end, "Calls Outgoing")

    -- Inlay hints
    -- if client:supports_method("textDocument/inlayHint") then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- end
  end,
})

-- Go
vim.lsp.config["gopls"] = {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "rust_analyzer",
  "ts_ls",
})
