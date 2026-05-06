vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim._core.ui2 is a private 0.12 nightly API (note the underscore); the new
-- message/cmdline UI. Expect this to move or be renamed before 0.12 stabilizes.
require('vim._core.ui2').enable({
      enable = true,
      msg = {
        targets = 'cmd',
        cmd = { height = 0.5 },
        dialog = { height = 0.5 },
        msg = { height = 0.5, timeout = 4500 },
        pager = { height = 1 },
      },
    })

require("config")
require("plugins")
