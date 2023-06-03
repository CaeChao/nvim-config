local M = {}

M.vimwiki = function()
  vim.g.vimwiki_global_ext = 0
  vim.g.vimwiki_dir_link = "index"
  vim.g.vimwiki_table_mappings = 0
  vim.g.vimwiki_create_link = 0
  vim.g.vimwiki_valid_html_tags = "b,i,s,u,sub,sup,kbd,br,hr, pre, script"
  vim.g.vimwiki_filetypes = { "markdown", "pandoc" }
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
  vim.g.vimwiki_key_mappngs = {
    {
      links = 0,
    },
  }
end

M.zettel = function()
  vim.g.zettel_format = "%title"
  vim.g.zettel_link_format = "[[%link]]"
  vim.g.zettel_default_mappings = 0
  vim.g.zettel_date_format = "%Y-%m-%d"
end

M.taskwiki = function()
  vim.g.taskwiki_source_tw_colors = "yes"
end

return M
