require("nvim-treesitter.configs").setup({
  ensure_installed = { "javascript", "typescript", "python", "lua", "vim" },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = true,
  },
  {
    indent = {
      enable = true
    }
  }
})
