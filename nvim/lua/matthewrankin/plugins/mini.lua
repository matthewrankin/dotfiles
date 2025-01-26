return {
  "echasnovski/mini.nvim",
  version = "*", -- use the stable branch
  config = function()
    require("mini.ai").setup()
    require("mini.statusline").setup({ use_icons = true })
    require("mini.surround").setup()
  end,
}
