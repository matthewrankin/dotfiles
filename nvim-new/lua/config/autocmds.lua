-- Helper function to create groups.
local function augroup(name)
  return vim.api.nvim_create_augroup(
    "user_" .. name,
    { clear = true }
  )
end

-- Highight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set textwidth if this is a markdown document.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("set_textwidth_md_txt_tex_files"),
  pattern = { "markdown", "text", "tex" },
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

-- Spell check text files.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("spellcheck_text_files"),
  pattern = { "markdown", "text", "tex", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
