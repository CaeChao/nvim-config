local M = {}

function M.setup()
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    vim.notify("Missing null-ls dependency", vim.log.levels.ERROR)
    return
  end

  null_ls.setup({
    debug = true,
    on_attach = require("configs.lsp").common_on_attach,
    sources = {
      require("none-ls.code_actions.eslint_d"),
      require("none-ls.diagnostics.eslint_d"),
      null_ls.builtins.formatting.prettier.with({
        prefer_local = "node_modules/.bin",
        filetypes = { "html", "scss", "less", "css", "json", "yaml", "markdown" },
      }),
      null_ls.builtins.code_actions.gitsigns.with({
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "html",
          "scss",
          "css",
          "json",
        },
      }),
      null_ls.builtins.formatting.stylua.with({
        extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
      }),
      null_ls.builtins.completion.luasnip.with({
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "html",
          "scss",
          "css",
          "json",
        },
      }),
      null_ls.builtins.completion.spell.with({
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "html",
          "scss",
          "css",
          "json",
        },
      }),
    },
  })
end
return M
