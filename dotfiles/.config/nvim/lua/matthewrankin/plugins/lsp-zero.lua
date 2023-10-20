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
      local opts = {buffer = bufnr, remap = false}
      lsp_zero.buffer_autoformat()

      vim.keymap.set("n", "gd",
        function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K",
        function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<leader>vws",
        function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>vd",
        function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "[d",
        function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "]d",
        function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set("n", "<leader>vca",
        function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>vrr",
        function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>vrn",
        function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set("i", "<C-h>",
        function() vim.lsp.buf.signature_help() end, opts)
    end)

    lsp_zero.format_on_save({
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
      servers = {
        ['tsserver'] = {'javascript', 'typescript'},
      }
    })

    lsp_zero.setup()

    vim.diagnostic.config({
        virtual_text = true
    })
	end,
}
