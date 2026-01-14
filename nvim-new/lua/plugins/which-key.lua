vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

local wk = require("which-key")
wk.setup({
  preset = "helix",
})
wk.add({
  { "<leader>e", group = "explorer commands" },
  { "<leader>f", group = "find commands" },
  { "<leader>t", group = "tab commands" },
  { "<leader>x", group = "diangostic commands" },
  { "gr", group = "LSP commands" },
})
