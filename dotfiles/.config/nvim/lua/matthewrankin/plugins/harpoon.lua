return {
  "theprimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    vim.keymap.set("n", "<leader>f1", function()
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<leader>f2", function()
      ui.nav_file(2)
    end)
    vim.keymap.set("n", "<leader>f3", function()
      ui.nav_file(3)
    end)
    vim.keymap.set("n", "<leader>f4", function()
      ui.nav_file(4)
    end)
    vim.keymap.set("n", "<leader>f5", function()
      ui.nav_file(5)
    end)
  end,
}
