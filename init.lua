local config_file_list = {
  "bootstrap.lua",
  "mappings.lua",
  "ui.lua",
  "autocmds.lua",
}

for _, name in ipairs(config_file_list) do
  local path = string.format("%s/lua/core/%s", vim.fn.stdpath("config"), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end
