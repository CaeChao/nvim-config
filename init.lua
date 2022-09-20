local config_file_list = {
  "settings.vim",
  "plugins.vim",
  "autocmds.vim",
  "ui.vim",
  "mappings.lua"
}

for _, name in ipairs(config_file_list) do
  local path = string.format("%s/core/%s", vim.fn.stdpath("config"), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end
