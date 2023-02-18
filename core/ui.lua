local utils = require("utils")

local M = {}

M.theme2dir = {
  gruvbox_material = "gruvbox-material",
  nvcode_gruvbox = "nvcode-color-schemes.vim",
  everforest = "everforest",
  nightfox = "nightfox.nvim",
}


M.gruvbox_material = function()
  vim.g.gruvbox_material_background = "medium"
  vim.g.gruvbox_material_foreground = "material"
  vim.g.gruvbox_material_visual = "grey background"
  vim.g.gruvbox_material_cursor = "green"
  vim.g.gruvbox_material_sign_column_background = "none"
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_enable_italic = 1
  vim.g.gruvbox_material_disable_italic_comment = 1

  vim.cmd([[colorscheme gruvbox-material]])
end

M.everforest = function()
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_better_performance = 1

  vim.cmd([[colorscheme everforest]])
end

M.nightfox = function()
  vim.cmd([[colorscheme nordfox]])
end

M.nvcode_gruvbox = function()
  vim.g.nvcode_termcolors=256
  vim.cmd([[colorscheme gruvbox]])
end

local colorscheme = "gruvbox_material"
if not vim.tbl_contains(vim.tbl_keys(M), colorscheme) then
  local msg = "Invalid colorscheme: " .. colorscheme
  vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

  return
end

-- Load the colorscheme
local status = utils.add_pack(M.theme2dir[colorscheme])

if not status then
  local msg = string.format("Theme %s is not installed. Run PackerSync to install.", colorscheme)
  vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

  return
end

-- Load the colorscheme and its settings
M[colorscheme]()

if vim.g.logging_level == "debug" then
  local msg = "Loaded theme: " .. colorscheme

  vim.notify(msg, vim.log.levels.INFO, { title = "nvim-config" })
end
