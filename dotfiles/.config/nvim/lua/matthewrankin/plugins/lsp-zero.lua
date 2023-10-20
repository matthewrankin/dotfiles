return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},

    -- Snippets
    {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
  },
  config = function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.preset('recommended')
    local cmp = require('cmp')
    local cmp_select = {behavior = cmp.SelectBehavior.Select}
    local cmp_mappings = lsp_zero.defaults.cmp_mappings({
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-space>'] = cmp.mapping.complete(),
    })
    lsp_zero.set_preferences({
      sign_icons = { }
    })

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({buffer = bufnr})
      lsp_zero.buffer_autoformat()
    end)

    lsp_zero.set_sign_icons({
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = '»'
    })

    require('mason').setup({})
    require('mason-lspconfig').setup({
      handlers = {
        lsp_zero.default_setup
      }
    })

    -- lsp_zero.format_on_save({
    --   format_opts = {
    --     async = false,
    --     timeout_ms = 10000,
    --   },
    --   servers = {
    --     ['tsserver'] = {'javascript', 'typescript'},
    --     ['gopls'] = {'go', 'gomod', 'gowork', 'gotmpl'},
    --   }
    -- })
    --
    lsp_zero.setup()

    vim.diagnostic.config({
        virtual_text = true
    })
	end,
}
