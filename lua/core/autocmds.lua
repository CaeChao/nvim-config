local api = vim.api

local function augroup(name)
  return api.nvim_create_augroup(name, { clear = true })
end

api.nvim_create_autocmd("BufEnter", {
  group = augroup("wrap_spell"),
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

api.nvim_create_autocmd("User", {
  group = augroup("lualine_augroup"),
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
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
