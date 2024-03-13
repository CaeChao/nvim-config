local api = vim.api
local Log = require("core.log")

local M = {}

local function check_git_repo()
  local cmd = "git rev-parse --is-inside-work-tree"
  if vim.fn.system(cmd) == "true\n" then
    api.nvim_exec_autocmds("User", { pattern = "InGitRepo" })
    return true -- removes autocmd after lazy loading git related plugins
  end
end

function M.augroup(name)
  return api.nvim_create_augroup(name, { clear = true })
end

function M.clear_augroup(name)
  -- defer the function in case the autocommand is still in-use
  Log:debug("request to clear autocmds  " .. name)
  vim.schedule(function()
    pcall(function()
      api.nvim_clear_autocmds({ group = name })
    end)
  end)
end

--- Create autocommand groups based on the passed definitions
--- Also creates the augroup automatically if it doesn't exist
---@param definitions table contains a tuple of event, opts, see `:h nvim_create_autocmd`
function M.define_autocmds(definitions)
  for _, entry in ipairs(definitions) do
    local event = entry[1]
    local opts = entry[2]
    if type(opts.group) == "string" and opts.group ~= "" then
      local exists, _ = pcall(api.nvim_get_autocmds, { group = opts.group })
      if not exists then
        api.nvim_create_augroup(opts.group, { clear = true })
      end
    end
    api.nvim_create_autocmd(event, opts)
  end
end

function M.load_defaults()
  local defaults = {
    {
      "BufEnter",
      {
        group = "wrap_spell",
        pattern = { "gitcommit", "markdown" },
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end,
      },
    },

    {
      "BufEnter",
      {
        group = "nvim_tree",
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
      },
    },

    {
      "TextYankPost",
      {
        pattern = "*",
        group = "highlight_yank",
        callback = function()
          vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
        end,
      },
    },

    {
      { "BufRead", "BufNewFile" },
      {
        group = "csv_filetype",
        pattern = { "*.csv", "*.dat" },
        command = "setfiletype csv",
      },
    },

    { "FileType", {
      pattern = "help",
      command = "wincmd L",
    } },

    {
      "User",
      {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      },
    },

    {
      { "VimEnter", "DirChanged" },
      {
        callback = function()
          vim.schedule(check_git_repo)
        end,
      },
    },
  }
  M.define_autocmds(defaults)
end
return M
