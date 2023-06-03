local M = {}

local function prequire(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

M.autopairs = function()
  local cmp_autopairs = prequire("nvim-autopairs.completion.cmp")
  require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "vim" },
    map_cr = false,
  })

  require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.blankline = function()
  require("indent_blankline").setup({
    char = "▏",
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    -- space_char_blankline = " ",
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

M.gitsigns = function()
  require("gitsigns").setup({
    signs = {
      add = { hl = "GitSignsAdd", text = "", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "", numhl = "GitSignsChangeNr" },
    },
  })
end

M.truezen = function()
  require("true-zen").setup({
    ui = {
      left = {
        number = true,
      },
    },
    misc = {
      ui_elements_commands = true,
    },
  })
end

M.todo = function()
  require("todo-comments").setup({})
end

M.md_preview = function()
  vim.g.mkdp_command_for_global = 1
  vim.g.mkdp_open_to_the_world = 1
  vim.g.mkdp_refresh_slow = 1
  vim.g.mkdp_filetypes = { "markdown", "pandoc", "vimwiki" }
end

M.vista = function()
  vim.g.vista_default_executive = "ctags"
  vim.g.vista_executive_for = {
    javascript = "nvim_lsp",
    typescript = "nvim_lsp",
    javascriptreact = "nvim_lsp",
    typescriptreact = "nvim_lsp",
    tsx = "nvim_lsp",
    vimwiki = "markdown",
    pandoc = "markdown",
    markdown = "toc",
  }
  vim.g.vista_ctags_cmd = {
    vimwiki = "~/.local/share/nvim/site/pack/packer/opt/taskwiki/extra/vwtags.py",
  }
end

return M