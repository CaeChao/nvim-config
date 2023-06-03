local M = {}

M.load_default_settings = function()
  local default_settings = {
    wrapmargin = 8,
    number = true, -- set Line numbers,
    ignorecase = true,
    smartcase = true,
    smartindent = true,
    fileencoding = "utf-8",
    spelllang = { "en_us", "en", "cjk" },
    -- sessionoptions+=globals,
    expandtab = true,
    splitbelow = true,
    splitright = true,
    hidden = true,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
    formatoptions = "qrn1",
    scrolloff = 4,     -- minimal number of screen lines to keep above and below the cursor.
    sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
    showmode = false,
    autochdir = true,
    undofile = true,
    swapfile = false,
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    laststatus = 2,
    wrap = false,
    linebreak = true,
    mouse = "a",
    showtabline = 0,
    termguicolors = true,
  }

  vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
  vim.g.highlightedyank_highlight_duration = 1000
  vim.g.mapleader = "'"
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  for k, v in pairs(default_settings) do
    vim.opt[k] = v
  end

  vim.filetype.add({
    extension = {
      tex = "tex",
      zir = "zir",
      cr = "crystal",
    },
    pattern = {
      ["[jt]sconfig.*.json"] = "jsonc",
    },
  })
end

M.load_headless_settings = function()
  vim.opt.shortmess = ""   -- try to prevent echom from cutting messages off or prompting
  vim.opt.more = false     -- don't pause listing when screen is filled
  vim.opt.cmdheight = 9999 -- helps avoiding |hit-enter| prompts.
  vim.opt.columns = 9999   -- set the widest screen possible
  vim.opt.swapfile = false -- don't use a swap file
end

M.load_defaults = function()
  if #vim.api.nvim_list_uis() == 0 then
    M.load_headless_settings()
    return
  end
  M.load_default_settings()
end

return M
