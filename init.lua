require("core.settings").load_defaults()

local lazy_dir = vim.fn.stdpath("data") .. "/site/lazy/lazy.nvim"
require("core.bootstrap").init(lazy_dir)

vim.opt.rtp:prepend(lazy_dir)
require("plugins").load()

require("core.autocmds")

require("core.mappings")
