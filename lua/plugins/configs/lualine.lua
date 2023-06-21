function lsp_progress()
  local Lsp = vim.lsp.util.get_progress_messages()[1]
  if Lsp then
    local msg = Lsp.message or ""
    local percentage = Lsp.percentage or 0
    local title = Lsp.title or ""
    local spinners = {
      "🌑 ",
      "🌒 ",
      "🌓 ",
      "🌔 ",
      "🌕 ",
      "🌖 ",
      "🌗 ",
      "🌘 ",
    }

    local success_icon = {
      "",
      "",
      "",
    }

    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    if percentage >= 70 then
      return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
    else
      return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
    end
  end
  return ""
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
    -- theme = 'gruvbox-material',
    component_separators = { left = "|", right = "|" },
    section_separators = { left = " ", right = "" },
  },
  sections = {
    lualine_a = {
      { "mode", left_padding = 0, right_padding = 1 },
    },
    lualine_b = {
      { "filetype", icon_only = true,  separator = "" },
      { "filename", file_status = true },
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic", "coc" },
        diagnostics_color = {
          error = { fg = "#db4b4b" },
          warn = { fg = "#e0af68" },
          info = { fg = "#0db9d7" },
          hint = { fg = "#10B981" },
        },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
        },
      },
      lsp_progress,
    },
    lualine_x = {
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        source = diff_source,
        separator = "",
      },
      "branch",
    },
    lualine_y = { "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  },
}
return options
