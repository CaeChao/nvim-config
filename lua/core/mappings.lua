local keymap = vim.keymap
local api = vim.api

-- Remap
vim.g.mapleader = "'"
keymap.set({ "i", "x" }, "jk", "<Esc>")
keymap.set("c", "jk", "<C-c>")
keymap.set({ "n", "x" }, ";", ":")

-- Leader shortcuts
keymap.set("n", "<leader>f", "<cmd>TZAtaraxis<cr>", { desc = "toggle ZenMode" })
keymap.set("n", "<leader>s", "<cmd>set spell!<cr>", { desc = "toggle spell" })
keymap.set("n", "<leader>D", "<cmd>read !date<cr>")
keymap.set("n", "<leader>t", "<cmd>Vista!!<cr>")
keymap.set("n", "<leader>gq", "<cmd>%!pandoc -f html -t markdown<cr>")
keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr><cmd>wincmd p<cr>")
keymap.set("n", "<leader>q", "<cmd>bprevious <bar> bdelete #<cr>", { silent = true, desc = "delete buffer" })
keymap.set("v", "<leader>gq", "<cmd>!pandoc -f markdown -t html<cr>")

-- Miscellaneous
keymap.set("v", ".", "<cmd>norm.<CR>")

-- Movement/Navigation shortcuts
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set("n", "^", "g^")
keymap.set("n", "0", "g0")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Text Editing
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- bufferline
keymap.set("n", "<C-n>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
keymap.set("n", "<C-p>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
keymap.set("n", ">>", "<cmd>BufferLineMoveNext<CR>", { silent = true })
keymap.set("n", "<<", "<cmd>BufferLineMovePrev<CR>", { silent = true })
keymap.set("n", "<leader>be", "<cmd>BufferLineSortByExtension<CR>")
keymap.set("n", "<leader>bd", "<cmd>BufferLineSortByDirectory<CR>")

-- Clipboard functionality (paste from system)
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>p", '"+p')
keymap.set("v", "<leader>p", '"+p')
keymap.set("n", "<leader>d", '"+d')
keymap.set("v", "<leader>d", '"+d')
keymap.set("n", "<leader>cp", "<cmd>let @+=expand('%:p')<CR>")

-- Telescope
keymap.set("n", "<leader><leader>", "<cmd>lua require('telescope.builtin').find_files()<cr>", { silent = true })
keymap.set("n", "<leader><Enter>", "<cmd>lua require('telescope.builtin').buffers()<cr>", { silent = true })
keymap.set("n", "<C-t>", "<cmd>lua require('telescope.builtin').tags()<cr>", { silent = true })
keymap.set("n", "<leader>a", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
keymap.set("n", "<leader>m", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>")
keymap.set("n", "<leader>gs", "<cmd>lua require('telescope.builtin').grep_string()<cr>")

-- Trouble
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")
keymap.set("n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>")
keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")

-- Markdown-preview
keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", { noremap = true })
keymap.set("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { noremap = true })

-- VimWiki
-- keymap.set("n", "<leader>gl", "<cmd>ZettelGenerateLinks<cr>")
-- keymap.set("n", "<leader>twr", "<cmd>TaskWikiBufferLoad<cr>")
-- keymap.set("n", "<leader>x", "<Plug>VimwikiToggleListItem", { noremap = true })
-- keymap.set("n", "<leader>c", "<cmd>Calendar<CR>")

-- Debugger
keymap.set(
  "n",
  "bp",
  "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
  { noremap = true, silent = true }
)
keymap.set(
  "n",
  "cb",
  "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",
  { noremap = true, silent = true }
)
keymap.set("n", "]d", require("goto-breakpoints").next, {})
keymap.set("n", "[d", require("goto-breakpoints").prev, {})
keymap.set("n", "<leader>db", "<cmd>lua require('dapui').toggle()<cr>", { noremap = true, silent = true })

-- fugitive
keymap.set("n", "<leader>1", "<cmd>diffput //1<CR>", {})
keymap.set("n", "<leader>2", "<cmd>diffget //2<CR>", {})
keymap.set("n", "<leader>3", "<cmd>diffget //3<CR>", {})
