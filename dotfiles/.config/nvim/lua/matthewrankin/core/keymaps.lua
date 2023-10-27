-- Allow moving lines when visually selected.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at beginning of line when joining lines.
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in middle when half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Greatest remap ever. Delete highlighted word into the void register and then
-- paste, so that we keep our paste the same in the future. No longer needed as
-- of Vim 8.2.4881 and Neovim v0.8.0, as you can paste using P for the same
-- action.
vim.keymap.set("x", "<leader>p", '"_dP')

-- Next greatest remap ever. Yank into the system clipboard using <leader>y in
-- either normal or visual mode or in normal mode yank to the end of the line
-- using <leader>Y.
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Never press Q
vim.keymap.set("n", "Q", "<nop>")

-- Need to find a different keymap for this command, as I don't want to
-- overwrite the typical usage of <C-f>.
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>x", "<cmd>lprev<CR>zz")

-- Change the current word and all matches
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
