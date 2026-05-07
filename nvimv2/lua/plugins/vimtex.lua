vim.pack.add({
  { src = "https://github.com/lervag/vimtex" },
})

-- Treat ambiguous .tex as LaTeX rather than plain TeX.
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_mode = 0
