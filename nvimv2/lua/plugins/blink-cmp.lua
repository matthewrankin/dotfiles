vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    -- Free <C-k> for built-in digraph entry; move signature toggle to <C-s>.
    ["<C-k>"] = {},
    ["<C-s>"] = { "show_signature", "hide_signature" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    list = { selection = { preselect = false, auto_insert = true } },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  -- Tagged releases ship a prebuilt Rust matcher; fall back to Lua and
  -- warn if it isn't available (e.g., installed from main).
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
})

-- Advertise blink.cmp's extended LSP completion capabilities to every
-- server enabled via vim.lsp.enable. Must run before the servers attach;
-- this file is required before plugins/lsp.lua because plugins/init.lua
-- loads files alphabetically.
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
