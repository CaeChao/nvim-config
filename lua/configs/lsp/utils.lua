local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp

local M = {}

function M.get_supported_servers(filter)
  -- force synchronous mode, see: |mason-registry.refresh()|
  require("mason-registry").refresh()
  require("mason-registry").get_all_packages()

  local _, supported_servers = pcall(function()
    return require("mason-lspconfig").get_available_servers(filter)
  end)
  return supported_servers or {}
end

function M.add_lsp_key_mappings(bufnr, buf_mappings)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode in pairs(mappings) do
    for key, remap in pairs(buf_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      keymap.set(mode, key, remap[1], opts)
    end
  end
end

function M.setup_document_highlight(client, bufnr)
  -- The blow command will highlight the current variable and its usages in the buffer.
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
      hi link LspReferenceRead Visual
      hi link LspReferenceText Visual
      hi link LspReferenceWrite Visual
    ]])

    local augroup = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    api.nvim_create_autocmd("CursorHold", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp.buf.document_highlight()
      end,
    })

    api.nvim_create_autocmd("CursorMoved", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp.buf.clear_references()
      end,
    })
  end
end

function M.setup_codelens_refresh(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method "textDocument/codeLens"
  end)
  if not status_ok or not codelens_supported then
    return
  end
  local group = "lsp_code_lens_refresh"
  local cl_events = { "BufEnter", "InsertLeave" }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })

  if ok and #cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_events, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
end

return M
