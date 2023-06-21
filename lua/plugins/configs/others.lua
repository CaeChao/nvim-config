local M = {}

M.blankline = {
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
}

M.luasnip = function(opts)
  require("luasnip").config.set_config(opts)

  -- vscode format
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

  -- snipmate format
  require("luasnip.loaders.from_snipmate").load()
  require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

  -- lua format
  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
          require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

M.colorizer = {
  "css",
  "javascript",
  "lua",
  html = {
    mode = "foreground",
  },
}

M.gitsigns = {
  signs = {
    add = { hl = "GitSignsAdd", text = "", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "DiffChangeDelete", text = "", numhl = "GitSignsChangeNr" },
  },
}

M.truezen = {
  ui = {
    left = {
      number = true,
    },
  },
  misc = {
    ui_elements_commands = true,
  },
}

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
    vimwiki = "~/.local/share/nvim/site/lazy/taskwiki/extra/vwtags.py",
  }
end

return M
