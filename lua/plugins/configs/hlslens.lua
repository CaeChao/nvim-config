local keymap = vim.keymap

local M = {}
M.load_mappings = function()
  keymap.set("n", "n", [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]])

  keymap.set("n", "N", [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]])

  keymap.set("n", "*", [[*<Cmd>lua require("hlslens").start()<CR>]])
  keymap.set("n", "#", [[#<Cmd>lua require("hlslens").start()<CR>]])
  keymap.set("n", "g*", [[g*<Cmd>lua require("hlslens").start()<CR>]])
  keymap.set("n", "g#", [[g#<Cmd>lua require("hlslens").start()<CR>]])
end
return M
