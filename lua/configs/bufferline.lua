require('bufferline').setup{
   options = {
      offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
      buffer_close_icon = '',
      modified_icon = '',
      close_icon = '',
      show_close_icon = true,
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = 'multiwindow',
      show_buffer_close_icons = true,
      always_show_bufferline = true,
      diagnostics = 'nvim_lsp', -- 'or nvim_lsp'
      separator_style = 'slant',
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'Explorer',
          highlight = 'Directory',
          text_align = 'center'
        }
      },
      custom_filter = function(bufnr)
      -- if the result is false, this buffer will be shown, otherwise, this
      -- buffer will be hidden.

      -- filter out filetypes you don't want to see
      local exclude_ft = { 'qf', 'fugitive', 'git' }
      local cur_ft = vim.bo[bufnr].filetype
      local should_filter = vim.tbl_contains(exclude_ft, cur_ft)

      if should_filter then
        return false
      end

      return true
    end
  }
}
