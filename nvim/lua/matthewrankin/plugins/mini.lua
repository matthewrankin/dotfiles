return {
  "nvim-mini/mini.nvim",
  version = false, -- use the main branch
  config = function()
    require("mini.ai").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.surround").setup()
  end,
}
