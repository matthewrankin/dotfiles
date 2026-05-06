local severity = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    spacing = 4,
    prefix = "●",
  },
  virtual_lines = false,
  signs = {
    text = {
      [severity.ERROR] = "E",
      [severity.WARN] = "W",
      [severity.INFO] = "I",
      [severity.HINT] = "H",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    wrap = true,
    max_width = 80,
    border = "rounded",
    source = "if_many",
  },
})

-- [d and ]d (prev/next diagnostic) are Neovim 0.11+ defaults.
local set = vim.keymap.set
set("n", "<leader>xx", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
set("n", "<leader>xq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
set("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })
set("n", "<leader>xt", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
set("n", "<leader>xv", function()
  local cfg = vim.diagnostic.config() or {}
  vim.diagnostic.config({ virtual_lines = not cfg.virtual_lines })
end, { desc = "Toggle virtual_lines" })
