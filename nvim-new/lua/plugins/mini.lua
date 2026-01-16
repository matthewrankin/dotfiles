vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.ai").setup()
require("mini.bufremove").setup()
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "▎", change = "▎", delete = "" },
  },
})
vim.keymap.set("n", "<leader>hr", function() MiniDiff.reset_hunk() end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>ho", function() MiniDiff.toggle_overlay() end, { desc = "Toggle diff overlay" })
require("mini.indentscope").setup({
  symbol = "│",
  draw = {
    delay = 50,
    animation = require("mini.indentscope").gen_animation.none(),
  },
})
require("mini.statusline").setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename = "%f%m%r" -- relative path + modified + readonly
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
        "%<",
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
})
require("mini.surround").setup()
require("mini.tabline").setup()
