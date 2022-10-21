local api = vim.api
local keymap = vim.keymap

local hlslens = require("hlslens")

hlslens.setup {
  calm_down = true,
  nearest_only = true,
}

keymap.set("n", "n", [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]])

keymap.set("n", "N", [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]])

keymap.set("n", "*", [[*<Cmd>lua require("hlslens").start()<CR>]])
keymap.set("n", "#", [[#<Cmd>lua require("hlslens").start()<CR>]])
keymap.set("n", "g*", [[g*<Cmd>lua require("hlslens").start()<CR>]])
keymap.set("n", "g#", [[g#<Cmd>lua require("hlslens").start()<CR>]])
