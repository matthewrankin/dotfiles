return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Configure the various language servers.
    lspconfig["templ"].setup({ capabilities = capabilities })

    lspconfig.html.setup({
      capabilities = capabilities,
      filetypes = { "html", "templ" },
    })

    lspconfig.cssls.setup({ capabilities = capabilities })

    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      filetypes = { "templ", "astro", "javascript", "typescript", "react" },
      init_options = { userLanguages = { templ = "html" } },
    })

    lspconfig.htmx.setup({
      capabilities = capabilities,
      filetypes = { "html", "temp" },
    })

    lspconfig.ts_ls.setup({ capabilities = capabilities })

    lspconfig.jsonls.setup({ capabilities = capabilities })

    lspconfig.marksman.setup({
      capabilities = capabilities,
    })

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

    lspconfig.texlab.setup({
      capabilities = capabilities,
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

    lspconfig.htmx.setup({
      capabilities = capabilities,
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

    lspconfig.jqls.setup({
      capabilities = capabilities,
    })

    lspconfig.taplo.setup({
      capabilities = capabilities,
    })
  end,
}
