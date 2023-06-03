local api = vim.api
local keymap = vim.keymap

local function augroup(name)
  return api.nvim_create_augroup(name, { clear = true })
end

api.nvim_create_autocmd("BufEnter", {
  group = augroup("accurate_syntax_highlight"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

api.nvim_create_autocmd("BufEnter", {
  group = augroup("nvim_tree"),
  pattern = "NvimTree_*",
  callback = function()
    vim.opt_local.statusline = ""
    local layout = api.nvim_call_function("winlayout", {})
    if
        layout[1] == "leaf"
        and api.nvim_buf_get_option(api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
        and layout[3] == nil
    then
      vim.cmd("confirm quit")
    end
  end,
})

api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("csv_filetype"),
  pattern = { "*.csv", "*.dat" },
  command = "setfiletype csv",
})

api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

api.nvim_create_autocmd("FileType", {
  group = augroup("filetype_vimwiki"),
  pattern = "vimwiki",
  callback = function()
    vim.opt_local.syntax = "pandoc"
    keymap.set("n", "<leader>gl", "<cmd>ZettelGenerateLinks<cr>")
    keymap.set("n", "<CR>", "<Plug>VimwikiFollowLink")
    keymap.set("v", "<CR>", "<Plug>ZettelNewSelectedMap")
    keymap.set("n", "<S-CR>", "<Plug>VimwikiSplitLink")
    keymap.set("n", "<C-CR>", "<Plug>VimwikiVSplitLink")
    keymap.set("n", "+", "<Plug>VimwikiNormalizeLink")
    keymap.set("v", "+", "<Plug>ZettelNewSelectedMap")
    keymap.set("n", "<D-CR>", "<Plug>VimwikiTabnewLink")
    keymap.set("n", "<C-S-CR>", "<Plug>VimwikiTabnewLink")
    keymap.set("n", "<BS>", "<Plug>VimwikiGoBackLink")
    keymap.set("n", "<TAB>", "<Plug>VimwikiNextLink")
    keymap.set("n", "<S-TAB>", "<Plug>VimwikiPrevLink")
    keymap.set("n", "<leader>wn", "<Plug>VimwikiGoto")
    keymap.set("n", "<leader>wd", "<Plug>VimwikiDeleteFile")
    keymap.set("n", "<leader>wr", "<Plug>VimwikiRenameFile")
    keymap.set("n", "<C-Down>", "<Plug>VimwikiDiaryNextDay")
    keymap.set("n", "<C-Up>", "<Plug>VimwikiDiaryPrevDay")
    keymap.set("i", "[[", "[[<esc><Plug>ZettelSearchMap", { silent = true })
    keymap.set("n", "T", "<Plug>ZettelYankNameMap")
  end,
})

local function check_git_repo()
  local cmd = "git rev-parse --is-inside-work-tree"
  if vim.fn.system(cmd) == "true\n" then
    api.nvim_exec_autocmds("User", { pattern = "InGitRepo" })
    return true -- removes autocmd after lazy loading git related plugins
  end
end

api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  callback = function()
    vim.schedule(check_git_repo)
  end,
})
