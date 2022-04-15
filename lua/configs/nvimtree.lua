local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end

local g = vim.g
g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    deleted = "",
    ignored = "◌",
    renamed = "➜",
    staged = "✓",
    unmerged = "",
    unstaged = "✗",
    untracked = "★",
  },
  folder = {
    default = "",
    empty = "", -- 
    empty_open = "",
    open = "",
    symlink = "",
    symlink_open = "",
  },
}

g.nvim_tree_respect_buf_cwd = 1
g.nvim_tree_root_folder_modifier = ":t"
g.nvim_tree_special_files = { "README.md", "Makefile", "MAKEFILE" } -- List of filenames that gets highlighted with NvimTreeSpecialFile

nvimtree.setup({
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  hijack_netrw = true,
  hijack_cursor = false,
  update_focused_file = {
    enable = true,
  },
})
