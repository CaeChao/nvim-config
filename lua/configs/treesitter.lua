local options = {
  ensure_installed = { "lua", "vim", "vimdoc", "regex", "comment" },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      -- Languages that have a single comment style
      typescript = "// %s",
      css = "/* %s */",
      scss = "/* %s */",
      html = "<!-- %s -->",
      svelte = "<!-- %s -->",
      vue = "<!-- %s -->",
      json = "",
    },
  },
  {
    indent = {
      enable = true,
    },
  },
}

return options
