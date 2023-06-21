local M = {}

M.gruvbox = function()
  vim.g.gruvbox_material_background = "medium"
  vim.g.gruvbox_material_foreground = "material"
  vim.g.gruvbox_material_visual = "grey background"
  vim.g.gruvbox_material_cursor = "green"
  vim.g.gruvbox_material_sign_column_background = "none"
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_enable_italic = 1
  vim.g.gruvbox_material_disable_italic_comment = 1
end

return M
