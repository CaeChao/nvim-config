local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end

local g = vim.g

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
  respect_buf_cwd = true,
  renderer = {
    root_folder_modifier = ":~",
    special_files = { "README.md", "Makefile", "MAKEFILE" }, -- List of filenames that gets highlighted with NvimTreeSpecialFile
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "", -- 
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          deleted = "",
          ignored = "◌",
          renamed = "➜",
          staged = "✓",
          unmerged = "",
          unstaged = "✗",
          untracked = "★",
        },
      },
    },
  },
  update_focused_file = {
    enable = true,
  },
})
