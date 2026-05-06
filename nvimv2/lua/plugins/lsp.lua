vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

-- Per-server settings live in nvimv2/lsp/<server>.lua and are auto-loaded
-- from runtimepath (Neovim 0.11+). Add a server by dropping a file there
-- and listing its name below.
vim.lsp.enable({ "lua_ls" })

local format_augroup = vim.api.nvim_create_augroup("user_lsp_format", { clear = false })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Built-in autocompletion (0.11+).
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- Inlay hints on by default.
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Most LSP keymaps (K, grn, gra, grr, gri, gO, <C-s>) are defaults in
    -- Neovim 0.11+. Only add the ones that aren't.
    local set = vim.keymap.set
    local opts = function(desc)
      return { buffer = bufnr, silent = true, desc = desc }
    end
    set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    set("n", "<leader>uh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, opts("Toggle inlay hints"))

    -- Format on save, gated by vim.g.autoformat.
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_augroup,
        buffer = bufnr,
        callback = function()
          if vim.g.autoformat then
            vim.lsp.buf.format({ async = false, bufnr = bufnr })
          end
        end,
      })
    end
  end,
})
