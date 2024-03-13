local M = {}
local uv = vim.loop
local path_sep = uv.os_uname().version:match("Windows") and "\\" or "/"
local Log = require("core.log")

function inspect(item)
  print(vim.inspect(item))
end

M.executable = function(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end

M.add_pack = function(name)
  local status, error = pcall(function()
    vim.cmd(string.format("Lazy load %s", name))
  end)

  return error
end

---Write data to a file
---@param path string can be full or relative to `cwd`
---@param txt string|table text to be written, uses `vim.inspect` internally for tables
---@param flag string used to determine access mode, common flags: "w" for `overwrite` or "a" for `append`
function M.write_file(path, txt, flag)
  local data = type(txt) == "string" and txt or vim.inspect(txt)
  uv.fs_open(path, flag, 438, function(open_err, fd)
    assert(not open_err, open_err)
    uv.fs_write(fd, data, -1, function(write_err)
      assert(not write_err, write_err)
      uv.fs_close(fd, function(close_err)
        assert(not close_err, close_err)
      end)
    end)
  end)
end

function M.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function M.is_directory(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

---Reset lsp cache files
---It also forces regenerating any template ftplugin files
---Tip: Useful for clearing any outdated settings
function M.reset_cache()
  local nvim_modules = {}
  for module, _ in pairs(package.loaded) do
    if module:match("lsp") then
      package.loaded[module] = nil
      table.insert(nvim_modules, module)
    end
  end
  Log:trace(string.format("Cache invalidated for core modules: { %s }", table.concat(nvim_modules, ", ")))
  require("configs.lsp.templates").generate_templates()
end

return M
