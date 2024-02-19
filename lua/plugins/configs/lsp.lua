local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp

local M = {}

function M.common_on_attach(client, bufnr)
  -- Mappings.
  local map = function(mode, l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.buffer = bufnr
    keymap.set(mode, l, r, opts)
  end

  -- Mappings.
  local opts = { noremap = true, silent = true }
  map("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  map("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  map("n", "gy", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  map("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  map("n", "<space>q", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

  vim.o.updatetime = 250
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

  local lsp_formatting = function(buf)
    vim.lsp.buf.format({
      async = true,
      filter = function(clt)
        -- apply whatever logic you want (in this example, we'll only use null-ls)
        return clt.name == "null-ls"
      end,
      bufnr = buf,
    })
  end
  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    map("n", "<space>f", lsp_formatting, opts)
  end

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

-- TODO: replace deprecated typescript language plugin
-- lspconfig.tsserver.setup({
--   init_options = require("").init_options,
--   on_attach = function(client, bufnr)
--     client.server_capabilities.documentFormattingProvider = false
--     client.server_capabilities.document_range_formatting = false
--     local ts_utils = require("nvim-lsp-ts-utils")
--     ts_utils.setup({
--       eslint_bin = "eslint_d",
--       enable_formatting = true,
--       formatter = "eslint_d",
--       formatter_args = {
--         "--fix-to-stdout",
--         "--stdin",
--         "--stdin-filename",
--         "$FILENAME",
--       },
--       filter_out_diagnostics_by_code = { 80001 },
--     })
--     ts_utils.setup_client(client)

--     custom_attach(client, bufnr)
--   end,
--   flags = {
--     debounce_text_changes = 150,
--   },
--   capabilities = capabilities,
-- })

function M.setup()
  local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  lspconfig.cssls.setup({
    on_attach = M.common_on_attach,
    flags = {
      debounce_text_changes = 200,
    },
    capabilities = M.common_capabilities(),
  })

  lspconfig.pylsp.setup({
    on_attach = M.common_on_attach,
    settings = {
      pylsp = {
        plugins = {
          pylint = { enabled = true, executable = "pylint" },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          jedi_completion = { fuzzy = true },
          pyls_isort = { enabled = true },
          pylsp_mypy = { enabled = true },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
    capabilities = M.common_capabilities(),
  })
  
  lspconfig.clangd.setup({
    on_attach = M.common_on_attach,
    filetypes = { "c", "cpp", "cc" },
    flags = {
      debounce_text_changes = 300,
    },
    capabilities = M.common_capabilities(),
  })
  
  -- set up vim-language-server
  lspconfig.vimls.setup({
    on_attach = M.common_on_attach,
    flags = {
      debounce_text_changes = 300,
    },
    capabilities = M.common_capabilities(),
  })
  
  -- lspconfig.eslint.setup({
  --   on_attach = custom_attach,
  --   flags = {
  --     debounce_text_changes = 200,
  --   },
  --   capabilities = capabilities,
  -- })
  
  if vim.fn.executable("lua-language-server") > 0 then
    lspconfig.lua_ls.setup({
      on_attach = M.common_on_attach,
      -- client.server_capabilities.documentFormattingProvider = false
      -- client.server_capabilities.document_range_formatting = false
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
      capabilities = M.common_capabilities(),
    })
  end
  
  -- Lsp Handlers
  
  -- replace the default lsp diagnostic symbols
  local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end
  
  lspSymbol("Error", "")
  lspSymbol("Warn", "")
  lspSymbol("Info", "")
  lspSymbol("Hint", "")
  
  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = false,
    update_in_insert = false, -- update diagnostics insert mode
  })
  
  -- See https://github.com/neovim/neovim/pull/13998.
  lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
  
  lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  
  require("plugins.configs.null-ls").setup()
end

return M
