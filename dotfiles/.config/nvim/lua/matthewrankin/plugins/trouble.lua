return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>TroubleToggle<CR>",
      desc = "Open/close trouble list",
    },
    {
      "<leader>xn",
      function()
        require("trouble").next({ skip_groups = true, jump = true })
      end,
      desc = "Open trouble workspace diagnostics",
    },
    {
      "<leader>xw",
      "<cmd>TroubleToggle workspace_diagnostics<CR>",
      desc = "Open trouble workspace diagnostics",
    },
    {
      "<leader>xd",
      "<cmd>TroubleToggle document_diagnostics<CR>",
      desc = "Open trouble document diagnostics",
    },
    {
      "<leader>xq",
      "<cmd>TroubleToggle quickfix<CR>",
      desc = "Open trouble quickfix list",
    },
    {
      "<leader>xl",
      "<cmd>TroubleToggle loclist<CR>",
      desc = "Open trouble location list",
    },
    { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
  },
}
