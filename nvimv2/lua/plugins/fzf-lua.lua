vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")

fzf.setup({
  "default-title",
  files = {
    hidden = true,
    no_ignore = false,
  },
  grep = {
    hidden = true,
  },
})

local set = vim.keymap.set

-- File finders
set("n", "<leader>ff", fzf.files, { desc = "Find files (respect .gitignore)" })
set("n", "<C-p>", fzf.git_files, { desc = "Find git files" })
set("n", "<leader>fr", fzf.oldfiles, { desc = "Fuzzy find recent files" })

-- Search
set("n", "<leader>fs", fzf.live_grep, { desc = "Find string" })
set("n", "<leader>fS", function()
  fzf.live_grep({ rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case" })
end, { desc = "Find string (include hidden)" })
set("n", "<leader>fw", fzf.grep_cword, { desc = "Find word under cursor in cwd" })
set("n", "<leader>fW", fzf.grep_cWORD, { desc = "Find WORD under cursor in cwd" })

-- Buffers, keymaps, help
set("n", "<leader>fb", fzf.buffers, { desc = "List open buffers" })
set("n", "<leader>fk", fzf.keymaps, { desc = "List keymappings" })
set("n", "<leader>fh", fzf.helptags, { desc = "Find help tags" })
