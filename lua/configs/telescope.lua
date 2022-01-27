local present, telescope = pcall(require, "telescope")

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<c-t>"] = trouble.open_with_trouble,
        ["<Down>"] = require("telescope.actions").cycle_history_next,
        ["<Up>"] = require("telescope.actions").cycle_history_prev,
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["q"] = actions.close,
      },
    },
    vimgrep_arguments = {
      "ag",
      "--nocolor",
      "--noheading",
      "--filename",
      "--numbers",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
  },
  pickers = {
    lsp_definitions = {
      theme = "dropdown",
      layout_config = {
        width = 0.6,
        height = 0.5,
      },
    },
    lsp_references = {
      theme = "dropdown",
      layout_config = {
        width = 0.6,
        height = 0.5,
      },
    },
    find_files = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.6,
        height = 0.80,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 10,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
    },
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg",
    },
  },
})

pcall(function()
  telescope.load_extension({ "fzf", "media_files" })
end)
