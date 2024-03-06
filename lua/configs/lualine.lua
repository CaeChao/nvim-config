local function lsp_progress()
  return require("lsp-progress").progress({
    format = function(messages)
      local active_clients_count = #vim.lsp.get_active_clients()
      local lsp_icon = active_clients_count > 0 and " LSP" or ""

      local lsp_status = #messages > 0 and table.concat(messages, " ") or ""
      return lsp_icon .. lsp_status
    end,
  })
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local options = {
  options = {
    theme = 'gruvbox-material',
    component_separators = { left = icons.ui.LineLeft, right = icons.ui.LineMiddle },
    section_separators = { left = icons.ui.BoldDividerLeft, right = icons.ui.HalfCircleLeft },
  },
  sections = {
    lualine_a = {
      { "mode", left_padding = 0, right_padding = 1 },
    },
    lualine_b = {
      { "filetype", icon_only = true, separator = "" },
      { "filename", file_status = true },
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        diagnostics_color = {
          error = { fg = "#db4b4b" },
          warn = { fg = "#e0af68" },
          info = { fg = "#0db9d7" },
          hint = { fg = "#10B981" },
        },
        symbols = {
          error = icons.diagnostics.BoldError .. " ",
          warn = icons.diagnostics.BoldWarning .. " ",
          info = icons.diagnostics.BoldInformation .. " ",
          hint = icons.diagnostics.BoldHint .. " ",
        },
        separator = { right = "" },
      },
      lsp_progress,
    },
    lualine_x = {
      {
        "diff",
        symbols = {
          added = icons.git.LineAdded .. " ",
          modified = icons.git.LineModified .. " ",
          removed = icons.git.LineRemoved .. " ",
        },
        source = diff_source,
        separator = "",
      },
      "branch",
    },
    lualine_y = { "progress" },
    lualine_z = {
      { "location", separator = { right = icons.ui.HalfCircleRight }, left_padding = 2 },
    },
  },
}
return options
