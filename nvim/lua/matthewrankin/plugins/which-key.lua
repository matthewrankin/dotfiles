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
    wk.add({
      { "<leader>e", group = "explorer commands" },
      { "<leader>f", group = "find commands" },
      { "<leader>t", group = "tab commands" },
      { "<leader>x", group = "trouble commands" },
      { "gr", group = "LSP commands" },
    })
  end,
}
