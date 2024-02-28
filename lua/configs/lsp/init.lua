local api = vim.api
local lsp = vim.lsp

local M = {}

function M.common_on_attach(client, bufnr)
  local lsp_formatting = function(buf)
    lsp.buf.format({
      async = true,
      filter = function(clt)
        local filetype = vim.bo.filetype
        local n = require("null-ls")
        local s = require("null-ls.sources")
        local method = n.methods.FORMATTING
        local available_formatters = s.get_available(filetype, method)

        if #available_formatters > 0 then
          return clt.name == "null-ls"
        elseif clt.server_capabilities.documentFormattingProvider then
          return true
        else
          return false
        end
      end,
      bufnr = buf,
    })
  end

  local key_mappings = {
    normal_mode = {
      ["gd"] = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "Goto Definition" },
      ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
      ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show Hover" },
      ["gk"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show Signature Help" },
      ["<space>wa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace" },
      ["<space>wr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace" },
      ["<space>wl"] = { "<cmd>lua print(inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "Show Workspace List" },
      ["<space>f"] = { lsp_formatting, "Format Buffer" },
      ["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      ["gr"] = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "Goto References" },
      ["gy"] = { "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", "Goto Type Definitions" },
      ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
      ["ge"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open Float" },
      ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto Prev" },
      ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto Next" },
      ["<space>q"] = { "<cmd>lua vim.diagnostic.setqflist()<CR>", "Quick Fix List" },
      ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    },
    insert_mode = {},
    visual_mode = {},
  }

  local lu = require("configs.lsp.utils")

  vim.o.updatetime = 150

  lu.setup_codelens_refresh(client, bufnr)

  lu.add_lsp_key_mappings(bufnr, key_mappings)

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

  lu.setup_document_highlight(client, bufnr)

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
  local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  -- launch server
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

  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    update_in_insert = false, -- update diagnostics insert mode
    severity_sort = true,
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
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

  require("configs.lsp.null-ls").setup()
end

return M
