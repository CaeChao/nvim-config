
local present, telescope = pcall(require, "telescope")

local actions = require('telescope.actions')
local trouble = require("trouble.providers.telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<c-t>"] = trouble.open_with_trouble
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble
      }
    },
    vimgrep_arguments = {
      "ag",
      "--nocolor",
      "--noheading",
      "--filename",
      "--numbers",
      "--column",
      "--smart-case"
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
    } 
  }
}

pcall(function()
  telescope.load_extension('fzf')
end)
