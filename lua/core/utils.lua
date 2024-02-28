local M = {}

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

return M
