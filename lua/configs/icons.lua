local present, icons = pcall(requirem, "nvim-web-devicons")

 if not present then
   return
 end


icons.setup {
  default = '',
  symlink = '',
  lsp = {
    hint = "",
    info = "",
    warning = "",
    error = "",
   },
}
