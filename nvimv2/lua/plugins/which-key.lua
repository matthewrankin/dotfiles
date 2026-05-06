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
  { "<leader>s", group = "search commands" },
  { "<leader>t", group = "tab commands" },
  { "<leader>u", group = "ui toggles" },
  { "<leader>x", group = "diagnostic commands" },
  { "gr", group = "LSP commands" },
})
