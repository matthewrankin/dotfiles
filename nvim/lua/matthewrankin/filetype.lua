vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".*%.go%.tmpl"] = "gotmpl",
    [".*%.go%.html"] = "gotmpl",
  },
})

-- Better Go indentation settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false  -- Go uses tabs, not spaces
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.smartindent = true
    vim.opt_local.cindent = true  -- C-style indenting works well for Go
    vim.opt_local.cinkeys = vim.opt_local.cinkeys - "0#"  -- Don't deindent # directives
  end,
})