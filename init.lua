local lazy_dir = vim.fn.stdpath("data") .. "/site/lazy/lazy.nvim"

if not vim.tbl_contains(vim.opt.rtp:get(), lazy_dir) then
  vim.opt.rtp:prepend(lazy_dir)
end

icons = vim.deepcopy(require("icons"))

require("core.settings").load_defaults()

require("bootstrap").init(lazy_dir)

require("plugins").load()

require("core.autocmds").load_defaults()

require("core.mappings")

local commands = require("core.commands")
commands.load(commands.defaults)
