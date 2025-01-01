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

    -- Configure the various language servers.
    lspconfig.cssls.setup({ capabilities = capabilities })

    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
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
      filetypes = { "html", "templ" },
    })

    lspconfig.htmx.setup({
      capabilities = capabilities,
      filetypes = { "html", "temp" },
    })

    lspconfig.jsonls.setup({ capabilities = capabilities })

    lspconfig.jqls.setup({ capabilities = capabilities })

    lspconfig.golangci_lint_ls.setup({
      capabilities = capabilities,
    })

    lspconfig.gopls.setup({
      cmd = { "gopls" },
      capabilities = capabilities,
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

    lspconfig.marksman.setup({ capabilities = capabilities })

    lspconfig.pyright.setup({
      capabilities = capabilities,
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
      trace = "messages",
      init_options = {
        settings = {
          logLevel = "debug",
        },
      },
    })

    lspconfig.svelte.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
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
      filetypes = { "templ", "astro", "javascript", "typescript", "react" },
      init_options = { userLanguages = { templ = "html" } },
    })

    lspconfig.taplo.setup({ capabilities = capabilities })

    lspconfig.templ.setup({ capabilities = capabilities })

    lspconfig.texlab.setup({ capabilities = capabilities })

    lspconfig.ts_ls.setup({ capabilities = capabilities })
  end,
}
