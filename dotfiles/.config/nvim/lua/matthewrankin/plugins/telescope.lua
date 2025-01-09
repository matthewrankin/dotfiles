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
    local builtin = require("telescope.builtin")

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
      extensions = {
        fzf = {},
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    -- set keymaps
    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files({ hidden = true, no_ignore = false })
    end, {
      desc = "Find files (respect .gitignore)",
    })

    vim.keymap.set("n", "<C-p>", function()
      builtin.git_files({ show_untracked = true })
    end, {
      desc = "Find tracked & untracked git files (respect .gitignore)",
    })

    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {
      desc = "Fuzzy find recent files",
    })

    vim.keymap.set("n", "<leader>fs", function()
      builtin.live_grep()
    end, {
      desc = "Find string",
    })

    vim.keymap.set("n", "<leader>fS", function()
      builtin.live_grep({ additional_args = { "--hidden" } })
    end, {
      desc = "Find string (include hidden)",
    })

    vim.keymap.set("n", "<leader>fw", builtin.grep_string, {
      desc = "Find word under cursor in cwd",
    })

    vim.keymap.set("n", "<leader>fW", function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end, {
      desc = "Find WORD under cursor in cwd",
    })

    vim.keymap.set("n", "<leader>fb", builtin.buffers, {
      desc = "List open buffers",
    })

    vim.keymap.set(
      "n",
      "<leader>fh",
      builtin.help_tags,
      { desc = "Find help tags" }
    )
  end,
}
