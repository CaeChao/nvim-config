local api = vim.api
local lsp = vim.lsp
local autocmds = require("core.autocmds")
local utils = require("utils")

local M = {}
local lsp_config = require("configs.lsp.config")

function M.common_on_exit(_, _)
  if lsp_config.document_highlight then
    autocmds.clear_augroup("lsp_document_highlight")
  end
  if lsp_config.code_lens_refresh then
    autocmds.clear_augroup("lsp_code_lens_refresh")
  end
end

function M.common_on_attach(client, bufnr)
  vim.o.updatetime = 150
  local buffer_mappings = lsp_config.buffer_mappings
  local lu = require("configs.lsp.utils")
  if lsp_config.document_highlight then
    lu.setup_document_highlight(client, bufnr)
  end
  if lsp_config.code_lens_refresh then
    lu.setup_codelens_refresh(client, bufnr)
  end
  lu.add_lsp_key_mappings(bufnr, buffer_mappings)

  api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local float_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always", -- show source in diagnostic popup window
        prefix = " ",
      }

      if not vim.b.diagnostics_pos then
        vim.b.diagnostics_pos = { nil, nil }
      end

      local cursor_pos = api.nvim_win_get_cursor(0)
      if
        (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
        and #vim.diagnostic.get() > 0
      then
        vim.diagnostic.open_float(nil, float_opts)
      end

      vim.b.diagnostics_pos = cursor_pos
    end,
  })

  if vim.g.logging_level == "debug" then
    local msg = string.format("Language server %s started!", client.name)
    vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
  end
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    capabilities.offsetEncoding = { "utf-16" }
    return capabilities
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

function M.setup()

  if not utils.is_directory(lsp_config.templates_dir) then
    require("configs.lsp.templates").generate_templates(lsp_config.automatic_configuration.ensure_installed)
  end

  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    update_in_insert = false, -- update diagnostics insert mode
    severity_sort = true,
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.BoldHint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.BoldInformation },
      },
    },
  })

  -- replace the default lsp diagnostic symbols
  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- Set Lsp Handlers
  -- See https://github.com/neovim/neovim/pull/13998.
  lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  lsp.handlers["textDocument/signatureHelp"] = lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  lsp.handlers["window/showMessage"] = function(_, method, params)
    local severity = {
      vim.log.levels.ERROR,
      vim.log.levels.WARN,
      vim.log.levels.INFO,
      vim.log.levels.INFO,
    }
    vim.notify(method.message, severity[params.type], { title = "LSP" })
  end

  require("configs.lsp.null-ls").setup()
end

return M
