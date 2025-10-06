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
  },
  config = function()
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    local my_on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "List LSP references in Telescope"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "List all symbols in current buffer"
      keymap.set("n", "gO", vim.lsp.buf.document_symbol, opts)

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
    vim.lsp.config.cssls = {}
    vim.lsp.enable("cssls")

    vim.lsp.config("emmet_ls", {
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
    vim.lsp.enable("emmet_ls")

    vim.lsp.config("html", {
      on_attach = my_on_attach,
      filetypes = { "html", "templ" },
    })
    vim.lsp.enable("html")

    vim.lsp.config("htmx", {
      on_attach = my_on_attach,
      filetypes = { "html", "temp" },
    })
    vim.lsp.enable("htmx")

    vim.lsp.config.jsonls = {}
    vim.lsp.enable("jsonls")

    vim.lsp.config("jqls", {
      on_attach = my_on_attach,
    })
    vim.lsp.enable("jqls")

    vim.lsp.config("gopls", {
      cmd = { "gopls" },
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
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
          semanticTokens = false,  -- Disable to avoid conflicts with treesitter highlighting
          hints = {
            assignVariableTypes = false,
            compositeLiteralFields = false,
            compositeLiteralTypes = false,
            constantValues = false,
            functionTypeParameters = false,
            parameterNames = false,
            rangeVariableTypes = false,
          },
          -- Ensure completion includes all symbols
          symbolMatcher = "CaseInsensitive",
          symbolStyle = "Dynamic",
          -- Better completion settings
          completeFunctionCalls = true,
          matcher = "CaseInsensitive",
        },
      },
      init_options = {
        usePlaceholders = true,
      },
      capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
              resolveSupport = {
                properties = {
                  "documentation",
                  "detail",
                  "additionalTextEdits",
                },
              },
            },
            contextSupport = true,
            dynamicRegistration = true,
          },
        },
      },
    })
    vim.lsp.enable("gopls")

    vim.lsp.config("lua_ls", {
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
    vim.lsp.enable("lua_ls")

    vim.lsp.config.marksman = {}
    vim.lsp.enable("marksman")

    vim.lsp.config("pyright", {
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
    vim.lsp.enable("pyright")

    vim.lsp.config("ruff", {
      on_attach = my_on_attach,
      trace = "messages",
      init_options = {
        settings = {
          logLevel = "debug",
        },
      },
    })
    vim.lsp.enable("ruff")

    vim.lsp.config("rust_analyzer", {
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
    vim.lsp.enable("rust_analyzer")

    vim.lsp.config("svelte", {
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
    vim.lsp.enable("svelte")

    vim.lsp.config("tailwindcss", {
      on_attach = my_on_attach,
      filetypes = { "templ", "astro", "javascript", "typescript", "react" },
      init_options = { userLanguages = { templ = "html" } },
    })
    vim.lsp.enable("tailwindcss")

    vim.lsp.config.taplo = {}
    vim.lsp.enable("taplo")

    vim.lsp.config.templ = {}
    vim.lsp.enable("templ")

    vim.lsp.config.texlab = {}
    vim.lsp.enable("texlab")

    vim.lsp.config.ts_ls = {}
    vim.lsp.enable("ts_ls")

    vim.lsp.config.zls = {}
    vim.lsp.enable("zls")
  end,
}
