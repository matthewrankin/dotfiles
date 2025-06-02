return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { -- optional blink completion source for require statements and module annotations
      "saghen/blink.cmp",
      opts = {
        sources = {
          -- add lazydev to your completion providers
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
          },
        },
      },
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    local my_on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "List LSP references in Telescope"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "List all references in the quickfix window"
      keymap.set("n", "grr", vim.lsp.buf.references, opts)

      opts.desc = "Rename all references to the symbol under the cursor"
      keymap.set("n", "grn", vim.lsp.buf.rename, opts)

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts)

      opts.desc = "List all implementations in the quickfix window"
      keymap.set("n", "gri", "vim.lsp.buf.implementation", opts)

      opts.desc = "List all implementations in Telescope"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Display signature information"
      keymap.set("n", "<C-S>", "vim.lsp.buf.signature_help", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Go or list all definitions in Telescope"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Go or list all type definitions in Telescope"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "Show diagnostics in Telescope for all open buffers"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<cr>", opts)

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Restart LSP"
      keymap.set("n", "grs", "<cmd>LspRestart<CR>", opts)
    end

    -- Configure the various language servers.
    lspconfig.cssls.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })

    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "svelte",
      },
    })

    lspconfig.html.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
      filetypes = { "html", "templ" },
    })

    lspconfig.htmx.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
      filetypes = { "html", "temp" },
    })

    lspconfig.jsonls.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })

    lspconfig.jqls.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })

    lspconfig.golangci_lint_ls.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })

    lspconfig.gopls.setup({
      cmd = { "gopls" },
      capabilities = capabilities,
      on_attach = my_on_attach,
      filetypes = {
        "go",
        "gomod",
        "gowork",
        "gohtml",
        "gotmpl",
        "go.html",
        "go.tmpl",
      },
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          completeUnimported = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        },
      },
      init_options = {
        usePlaceholders = true,
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig.marksman.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            -- Ignore all files for analysis to use Ruff for linting.
            ignore = { "*" },
          },
        },
      },
    })

    lspconfig.ruff.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
      trace = "messages",
      init_options = {
        settings = {
          logLevel = "debug",
        },
      },
    })

    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          formatting = {
            enable = true,
          },
          check = {
            command = "clippy",
          },
        },
      },
    })

    lspconfig.svelte.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        my_on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end
          end,
        })
      end,
    })

    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
      filetypes = { "templ", "astro", "javascript", "typescript", "react" },
      init_options = { userLanguages = { templ = "html" } },
    })

    lspconfig.taplo.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })

    lspconfig.templ.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })

    lspconfig.texlab.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })

    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = my_on_attach,
    })
  end,
}
