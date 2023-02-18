local M = {}

function inspect(item)
  print(vim.inspect(item))
end

-- load plugin after entering vim ui
M.packer_lazy_load = function(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
      end, timer)
   end
end

M.executable = function(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end


M.add_pack = function(name)
  local status, error = pcall(vim.cmd, "packadd " .. name)

  return status
end

return M
