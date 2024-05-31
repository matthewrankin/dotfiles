return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {},
  config = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>e"] = { name = "+explorer commands" },
      ["<leader>f"] = { name = "+find commands" },
      ["<leader>t"] = { name = "+tab commands" },
    })
  end,
}
