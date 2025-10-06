return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Collection of snippets for many languages
  },
  config = function()
    local luasnip = require("luasnip")
    
    -- Load snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    
    -- Setup LuaSnip
    luasnip.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      -- Go-specific settings
      ft_func = function()
        return vim.split(vim.bo.filetype, ".", { plain = true, trimempty = true })
      end,
    })
    
    -- Keymaps for jumping in snippets
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = "Expand snippet or jump to next placeholder" })
    
    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "Jump to previous placeholder" })
    
    vim.keymap.set({ "i", "s" }, "<C-e>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true, desc = "Cycle through snippet choices" })
    
    -- Setup snippet expansion for LSP
    vim.snippet.expand = luasnip.lsp_expand
  end,
}