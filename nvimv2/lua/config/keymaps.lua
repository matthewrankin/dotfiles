local set = vim.keymap.set

-- clear search highlights
-- set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Allow moving lines when visually selected.
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor at beginning of line when joining lines.
set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Keep cursor centered when half page jumping and searching
set("n", "<C-d>", "<C-d>zz", { desc = "Move half page down (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Move half page up (centered)" })
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Keep visual selection when indenting
set("v", "<", "<gv", { desc = "Indent left and reselect" })
set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Control pasting and yanking text.
set({ "n", "x" }, "<leader>p", [["0p]], { desc = "Paste from yank register" })
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
