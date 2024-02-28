local options = {
  ensure_installed = { "c", "lua", "vim", "vimdoc" },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = true,
  },
  {
    indent = {
      enable = true,
    },
  },
}

return options
