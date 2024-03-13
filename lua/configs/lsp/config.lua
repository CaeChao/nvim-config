local ensure_installed = {
  "lua_ls",
  "pylsp",
  "vimls",
}

local skipped_servers = {
  "angularls",
  "ansiblels",
  "antlersls",
  "ast_grep",
  "azure_pipelines_ls",
  "biome",
  "ccls",
  "cssmodules_ls",
  "custom_elements_ls",
  "denols",
  "docker_compose_language_service",
  "elp",
  "ember",
  "emmet_language_server",
  "emmet_ls",
  "eslint",
  "eslintls",
  "glint",
  "golangci_lint_ls",
  "gradle_ls",
  "graphql",
  "htmx",
  "java_language_server",
  "jedi_language_server",
  "ltex",
  "mdx_analyzer",
  "neocmake",
  "nim_langserver",
  "ocamlls",
  "omnisharp",
  "phpactor",
  "psalm",
  "pyright",
  "pylyzer",
  "pyre",
  "quick_lint_js",
  "reason_ls",
  "rnix",
  "rome",
  "rubocop",
  "ruby_ls",
  "ruff_lsp",
  "scry",
  "solang",
  "solc",
  "solidity_ls",
  "solidity_ls_nomicfoundation",
  "sorbet",
  "sourcekit",
  "sourcery",
  "spectral",
  "sqlls",
  "sqls",
  "standardrb",
  "stimulus_ls",
  "stylelint_lsp",
  "svlangserver",
  "tflint",
  "tsserver",
  "unocss",
  "verible",
  "v_analyzer",
  "vtsls",
  "vuels",
}

local skipped_filetypes = { "markdown", "plaintext", "toml", "proto" }

local join_paths = require("utils").join_paths

local lsp_formatting = function(buf)
  vim.lsp.buf.format({
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

return {
  templates_dir = join_paths(vim.call("stdpath", "config"), "after", "ftplugin"),
  document_highlight = true,
  code_lens_refresh = true,
  automatic_configuration = {
    ---@usage list of servers that the automatic installer will install
    ensure_installed = ensure_installed,
    ---@usage list of servers that the automatic installer will skip
    skipped_servers = skipped_servers,
    ---@usage list of filetypes that the automatic installer will skip
    skipped_filetypes = skipped_filetypes,
  },
  buffer_mappings = {
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
  },

  buffer_options = {
    --- enable completion triggered by <c-x><c-o>
    omnifunc = "v:lua.vim.lsp.omnifunc",
    --- use gq for formatting
    formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})",
  },
  null_ls = {
    setup = {
      debug = false,
    },
    config = {},
  },
}
