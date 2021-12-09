local M = {}

M.autopairs = function()
  require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "vim" },
  })
end

M.blankline = function()
  require("indent_blankline").setup({
    char = "|",
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    space_char_blankline = " ",
    indentLine_enabled = 1,
    filetype_exclude = {
      "help",
      "terminal",
      "markdown",
      "pandoc",
      "vimwiki",
      "dashboard",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
    },
    buftype_exclude = { "terminal" },
  })
end

M.luasnip = function()
  require("luasnip").config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
  })
  -- require('luasnip/loaders/from_vscode').lazy_load()
  -- require('luasnip/loaders/from_vscode').load { path = { chadrc_config.plugins.options.luasnip.snippet_path } }
end

M.colorizer = function()
  require("colorizer").setup({
    "css",
    "javascript",
    "lua",
    html = {
      mode = "foreground",
    },
  })
end

M.lspcolors = function()
  require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981",
  })
end

M.gitsigns = function()
  require("gitsigns").setup({
    signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
    },
  })
end

return M
