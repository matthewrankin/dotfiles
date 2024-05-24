-- Set leader key
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Allow moving lines when visually selected.
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at beginning of line when joining lines.
keymap.set("n", "J", "mzJ`z")

-- Keep cursor in middle when half page jumping
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in middle when searching
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Greatest remap ever. Delete highlighted word into the void register and then
-- paste, so that we keep our paste the same in the future. No longer needed as
-- of Vim 8.2.4881 and Neovim v0.8.0, as you can paste using P for the same
-- action.
-- keymap.set("x", "<leader>p", '"_dP')

-- Next greatest remap ever. Yank into the system clipboard using <leader>y in
-- either normal or visual mode or in normal mode yank to the end of the line
-- using <leader>Y.
keymap.set({ "n", "v" }, "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Never press Q
keymap.set("n", "Q", "<nop>")

-- Quickfix navigation
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Change the current word and all matches
keymap.set(
  "n",
  "<leader>r",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace all current word" }
)

-- Make file executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
  desc = "Make file executable",
  silent = true,
})

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set(
  "n",
  "<leader>tx",
  "<cmd>tabclose<CR>",
  { desc = "Close current tab" }
) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set(
  "n",
  "<leader>tf",
  "<cmd>tabnew %<CR>",
  { desc = "Open current buffer in new tab" }
) --  move current buffer to new tab
