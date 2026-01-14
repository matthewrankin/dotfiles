local set = vim.keymap.set

-- clear search highlights 
-- set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Allow moving lines when visually selected.
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at beginning of line when joining lines.
set("n", "J", "mzJ`z")

-- Keep cursor in middle when half page jumping
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in middle when searching
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Control size of splits (https://youtu.be/kJVqxFnhIuw?t=520)
set("n", "<M-h>", "<c-w>5<")
set("n", "<M-l>", "<c-w>5>")
set("n", "<M-j>", "<C-W>+")
set("n", "<M-k>", "<C-W>-")

-- Greatest remap ever per ThePrimeagen. Delete highlighted word into the void
-- register and then paste, so that we keep our paste the same in the future.
-- No longer needed as of Vim 8.2.4881 and Neovim v0.8.0, as you can paste
-- using P for the same action.
-- set("x", "<leader>p", '"_dP')

-- Instead of ThePrimeagen's greatest remap ever, I'm setting this up to paste
-- from the yank register.
set({ "n", "x" }, "<leader>p", [["0p]], { desc = "Paste from yank register" })

-- Next greatest remap ever. Yank into the system clipboard using <leader>y in
-- either normal or visual mode or in normal mode yank to the end of the line
-- using <leader>Y.
set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
set("n", "<leader>Y", '"+Y', { desc = "Yank line to sys clipboard" })

-- This keymap in normal mode is overwritten in my lspconfig.lua
set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void register" })

-- Never press Q per ThePrimeagen <https://youtu.be/w7i4amO_zaE?t=1692>
set("n", "Q", "<nop>")

-- Quickfix navigation per ThePrimeagen <https://youtu.be/w7i4amO_zaE?t=1717>
-- except I swapped j and k so that j goes down and k up the same as all other
-- vim movements.
set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next in quickfix" })
set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Prev in quickfix" })
set("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Next in location list" })
set("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Prev in location list" })

-- Change the current word and all matches
set(
  "n",
  "<leader>r",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace all current word" }
)

-- Make file executable
-- keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
--   desc = "Make file executable",
--   silent = true,
-- })

-- tab management
set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
set(
  "n",
  "<leader>tf",
  "<cmd>tabnew %<CR>",
  { desc = "Open current buffer in new tab" }
) --  move current buffer to new tab

-- Jump to last edited file.
set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Jump to last edited file." })

-- Completion navigation
set("i", "<C-j>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
end, { expr = true, desc = "Next completion item" })
set("i", "<C-k>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
end, { expr = true, desc = "Prev completion item" })
