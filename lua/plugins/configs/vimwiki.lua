local M = {}
local keymap = vim.keymap

M.vimwiki = function()
  vim.g.vimwiki_global_ext = 0
  vim.g.vimwiki_dir_link = "index"
  vim.g.vimwiki_table_mappings = 0
  vim.g.vimwiki_create_link = 0
  vim.g.vimwiki_valid_html_tags = "b,i,s,u,sub,sup,kbd,br,hr, pre, script"
  -- vim.g.vimwiki_filetypes = { "markdown", "pandoc" }
  vim.g.vimwiki_list = {
    {
      path = "~/Documents/vimwiki",
      diary_rel_path = "/",
      path_html = "~/Documents/vimwiki/wiki_html",
      template_path = "~/Documents/vimwiki/templates",
      template_default = "def_template",
      template_ext = ".html",
      syntax = "markdown",
      ext = ".md",
      auto_tags = 1,
      generated_links_caption = 1,
      custom_wiki2html = "~/Documents/vimwiki/wiki2html.sh",
      nested_syntaxes = { python = "python", ["c++"] = "cpp" },
    },
  }
  vim.g.vimwiki_key_mappings = {
    links = 0,
  }

  keymap.set("n", "<leader>x", "<Plug>VimwikiToggleListItem", { noremap = true })
  keymap.set("n", "<leader>c", "<cmd>Calendar<CR>")
  keymap.set("n", "<CR>", "<Plug>VimwikiFollowLink")
  keymap.set("n", "<S-CR>", "<Plug>VimwikiSplitLink")
  keymap.set("n", "<C-CR>", "<Plug>VimwikiVSplitLink")
  keymap.set("n", "+", "<Plug>VimwikiNormalizeLink")
  keymap.set("n", "<D-CR>", "<Plug>VimwikiTabnewLink")
  keymap.set("n", "<C-S-CR>", "<Plug>VimwikiTabnewLink")
  keymap.set("n", "<BS>", "<Plug>VimwikiGoBackLink")
  keymap.set("n", "<TAB>", "<Plug>VimwikiNextLink")
  keymap.set("n", "<S-TAB>", "<Plug>VimwikiPrevLink")
  keymap.set("n", "<leader>wn", "<Plug>VimwikiGoto")
  keymap.set("n", "<leader>wd", "<Plug>VimwikiDeleteFile")
  keymap.set("n", "<leader>wr", "<Plug>VimwikiRenameFile")
  keymap.set("n", "<C-Down>", "<Plug>VimwikiDiaryNextDay")
  keymap.set("n", "<C-Up>", "<Plug>VimwikiDiaryPrevDay")
end

M.zettel = function()
  vim.g.zettel_format = "%title"
  vim.g.zettel_link_format = "[[%link]]"
  vim.g.zettel_default_mappings = 0
  vim.g.zettel_date_format = "%Y-%m-%d"

  keymap.set("n", "<leader>gl", "<cmd>ZettelGenerateLinks<cr>")
  keymap.set("x", "<CR>", "<Plug>ZettelNewSelectedMap")
  keymap.set("x", "+", "<Plug>ZettelNewSelectedMap")
  keymap.set("n", "T", "<Plug>ZettelYankNameMap")
end

M.taskwiki = function()
  vim.g.taskwiki_source_tw_colors = "yes"
  vim.g.taskwiki_maplocalleader = "'tw"

  keymap.set("n", "<leader>twr", "<cmd>TaskWikiBufferLoad<cr>")
end

return M
