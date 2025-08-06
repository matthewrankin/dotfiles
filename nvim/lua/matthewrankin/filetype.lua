vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".*%.go%.tmpl"] = "gotmpl",
    [".*%.go%.html"] = "gotmpl",
  },
})