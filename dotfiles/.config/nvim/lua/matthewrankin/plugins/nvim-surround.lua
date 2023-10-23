return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` for latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end
}
