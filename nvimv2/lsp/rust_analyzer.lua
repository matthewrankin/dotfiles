return {
  settings = {
    ["rust-analyzer"] = {
      -- checkOnSave is a boolean; the checker itself is configured under
      -- `check`. Passing a table here is rejected at initialization.
      checkOnSave = true,
      check = {
        command = "clippy",
      },
    },
  },
}
