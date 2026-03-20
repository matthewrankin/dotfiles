vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.ai").setup()
require("mini.bufremove").setup()
require("mini.indentscope").setup({
  symbol = "│",
  draw = {
    delay = 50,
    animation = require("mini.indentscope").gen_animation.none(),
  },
})
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
