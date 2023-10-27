return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap
		local builtin = require("telescope.builtin")

		keymap.set("n", "<leader>ff", function()
			builtin.find_files({ hidden = true })
		end, {
			desc = "Search for files respecting .gitignore",
		})
		keymap.set("n", "<leader>fr", builtin.oldfiles, {
			desc = "Fuzzy find recent files",
		})
		keymap.set("n", "<C-p>", function()
			builtin.git_files({ show_untracked = true })
		end, {
			desc = "Fuzzy search for files tracked by git respecting .gitignore",
		})
		keymap.set("n", "<leader>fs", builtin.live_grep, {
			desc = "Find string",
		})
		keymap.set("n", "<leader>fc", builtin.grep_string, {
			desc = "Find string under cursor",
		})
		keymap.set("n", "<leader>fb", builtin.buffers, {})
		keymap.set("n", "<leader>fh", builtin.help_tags, {})
	end,
}
