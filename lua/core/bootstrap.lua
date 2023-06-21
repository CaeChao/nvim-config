local M = {}

M.echo = function(str)
  vim.cmd("redraw")
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

M.init = function(install_path)
  if not vim.loop.fs_stat(install_path) then
    --------- lazy.nvim ---------------
    M.echo("  Installing lazy.nvim & plugins ...")
    local lazy_repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo, install_path })
  end
  -- mason packages & show post_boostrap screen
  -- require "nvchad.post_bootstrap"()
end

return M
