function lsp_progress()
  local Lsp = vim.lsp.util.get_progress_messages()[1]
  if Lsp then
    local msg = Lsp.message or ""
    local percentage = Lsp.percentage or 0
    local title = Lsp.title or ""
    local spinners = {
      "",
      "",
      "",
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

require("lualine").setup({
  options = {
    -- theme = 'gruvbox-material',
    component_separators = "|",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = "" }, right_padding = 2 },
    },
    lualine_b = {
      "branch",
      { "diff", source = diff_source },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_lsp", "coc" } },
      "filename",
      lsp_progress,
    },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  },
})
