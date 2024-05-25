return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        layout_strategy = "vertical",
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    -- set keymaps
    local keymap = vim.keymap
    local builtin = require("telescope.builtin")

    keymap.set("n", "<leader>ff", function()
      builtin.find_files({ hidden = true })
    end, {
      desc = "Find files (respect .gitignore)",
    })

    keymap.set("n", "<C-p>", function()
      builtin.git_files({ show_untracked = true })
    end, {
      desc = "Find tracked & untracked git files (respect .gitignore)",
    })

    keymap.set("n", "<leader>fr", builtin.oldfiles, {
      desc = "Fuzzy find recent files",
    })

    keymap.set("n", "<leader>fs", function()
      builtin.live_grep({ additional_args = { "--hidden" } })
    end, {
      desc = "Find string",
    })

    keymap.set("n", "<leader>fc", builtin.grep_string, {
      desc = "Find string under cursor",
    })

    keymap.set("n", "<leader>fb", builtin.buffers, {})

    keymap.set(
      "n",
      "<leader>fh",
      builtin.help_tags,
      { desc = "Find help tags" }
    )
  end,
}
