return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Add file to Harpoon" })

    -- Note: Overrides the default <C-e> behavior, which is to scroll down one
    -- line.
    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle Harpoon Menu" })

    vim.keymap.set("n", "<leader>f1", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon File #1" })

    vim.keymap.set("n", "<leader>f2", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon File #2" })

    vim.keymap.set("n", "<leader>f3", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon File #3" })

    vim.keymap.set("n", "<leader>f4", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon File #4" })

    vim.keymap.set("n", "<leader>f5", function()
      harpoon:list():select(5)
    end, { desc = "Harpoon File #5" })
  end,
}
