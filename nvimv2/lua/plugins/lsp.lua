vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

-- Per-server settings live in nvimv2/lsp/<server>.lua and are auto-loaded
-- from runtimepath (Neovim 0.11+). Add a server by dropping a file there
-- and listing its name below. Servers without an lsp/ file use lspconfig
-- defaults. Install the binaries via your system package manager (brew,
-- npm -g, pyenv/uv, cargo, etc.) — Mason is intentionally not used here.
vim.lsp.enable({
  "cssls",
  "emmet_ls",
  "eslint",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "pyright",
  "ruff",
  "rust_analyzer",
  "svelte",
  "tailwindcss",
  "templ",
  "texlab",
  "ts_ls",
  "ty",
  "zls",
})

local format_augroup =
  vim.api.nvim_create_augroup("user_lsp_format", { clear = false })
local go_fix_augroup =
  vim.api.nvim_create_augroup("user_go_fix", { clear = false })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Autocompletion is provided by blink.cmp (see plugins/blink-cmp.lua).
    -- Capabilities are advertised globally via vim.lsp.config("*", ...).

    -- Inlay hints off by default.
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end

    -- Most LSP keymaps (K, grn, gra, grr, gri, gO, <C-s>) are defaults in
    -- Neovim 0.11+. Only add the ones that aren't.
    local set = vim.keymap.set
    local opts = function(desc)
      return { buffer = bufnr, silent = true, desc = desc }
    end
    set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    -- Mirrors K (hover) — <C-s> is the built-in insert-mode binding.
    set("n", "gK", vim.lsp.buf.signature_help, opts("Signature help"))
    set("n", "<leader>uh", function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
        { bufnr = bufnr }
      )
    end, opts("Toggle inlay hints"))

    -- Formatting on save is handled by conform.nvim (see plugins/conform.lua).
    -- We run gopls's source.organizeImports code action here, because gofumpt
    -- formats but does not add missing imports. Modernize-style rewrites
    -- (rangeint, minmax, slicessort, etc.) are not part of source.fixAll, so
    -- we shell out to `go fix` on BufWritePost instead (see below).
    if client.name == "gopls" then
      vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_augroup,
        buffer = bufnr,
        callback = function()
          if not vim.g.autoformat then
            return
          end
          local params =
            vim.lsp.util.make_range_params(0, client.offset_encoding)
          params.context =
            { only = { "source.organizeImports" }, diagnostics = {} }
          local results = vim.lsp.buf_request_sync(
            bufnr,
            "textDocument/codeAction",
            params,
            3000
          )
          for _, res in pairs(results or {}) do
            for _, action in ipairs(res.result or {}) do
              if action.edit then
                vim.lsp.util.apply_workspace_edit(
                  action.edit,
                  client.offset_encoding
                )
              end
            end
          end
        end,
      })

      -- Apply `go fix` (cmd/fix modernize analyzers) on save, async. Runs
      -- against the saved file's package; reloads the buffer via checktime
      -- if it changed on disk.
      vim.api.nvim_clear_autocmds({ group = go_fix_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = go_fix_augroup,
        buffer = bufnr,
        callback = function(ev)
          if not vim.g.autoformat then
            return
          end
          local dir = vim.fn.fnamemodify(ev.file, ":h")
          vim.system({ "go", "fix", "." }, { cwd = dir }, function(obj)
            if obj.code == 0 then
              vim.schedule(function()
                vim.cmd("checktime")
              end)
            end
          end)
        end,
      })
    end
  end,
})
