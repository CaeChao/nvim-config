local M = {}
local plugins_list = {

  -- auto-completion engine
  {
    "hrsh7th/nvim-cmp",
    init = function()
      vim.cmd("hi link CmpItemMenu Comment")
    end,
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind-nvim",

      -- snippet engine and snippet template
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("configs.others").luasnip(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          disable_filetype = { "TelescopePrompt", "vim" },
          map_cr = false,
          history = true,
          updateevents = "TextChanged,TextChangedI",
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      -- nvim-cmp completion sources
      { "saadparwaiz1/cmp_luasnip", lazy = true },
      { "hrsh7th/cmp-nvim-lua", lazy = true },
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "hrsh7th/cmp-buffer", lazy = true },
      { "hrsh7th/cmp-path", lazy = true },
      { "f3fora/cmp-spell", lazy = true },
      --  { 'honza/vim-snippets', event = 'InsertEnter' }
    },
    opts = function()
      return require("configs.cmp")
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup({})
    end,
    lazy = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({})
    end,
    lazy = true,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      require("configs.lsp").setup()
    end,
    lazy = true,
  },

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
    lazy = true,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
    lazy = true,
    opts = {},
    config = function()
      require("typescript-tools").setup()
    end,
  },

  {
    "linrongbin16/lsp-progress.nvim",
    opts = function()
      return require("configs.lsp.progress")
    end,
    config = function(_, opts)
      -- vim.cmd([[hi LspProgressMessageCompleted ctermfg=Green guifg=Green]])
      require("lsp-progress").setup(opts)
    end,
    lazy = true,
  },
  -- Syntax
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require("configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  { "MaxMEllon/vim-jsx-pretty", ft = { "javascriptreact", "typescriptreact" } },

  {
    "norcalli/nvim-colorizer.lua",
    opts = function()
      return require("configs.others").colorizer
    end,
    config = function(_, opts)
      require("colorizer").setup(opts)

      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
    lazy = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require("configs.others").blankline
    end,
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },

  { "vim-pandoc/vim-pandoc", ft = { "markdown", "pandoc", "vimwiki" } },
  { "vim-pandoc/vim-pandoc-syntax", ft = { "markdown", "pandoc", "vimwiki" } },
  { "elzr/vim-json", ft = { "json" } },
  { "chrisbra/csv.vim", ft = { "csv" } },

  { "liuchengxu/graphviz.vim", ft = { "gv", "dot" } },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "User InGitRepo" },
    cmd = { "Gitsigns" },
    opts = function()
      return require("configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  { "tpope/vim-fugitive", event = "User InGitRepo", lazy = true, cmd = { "G", "Git" } },

  -- File explorer, picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require("configs.nvimtree")
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  { "Tastyep/structlog.nvim", lazy = true },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "nvim-telescope/telescope-media-files.nvim",
      },
    },
    opts = function()
      return require("configs.telescope")
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- load extensions

      pcall(function()
        telescope.load_extension({ "fzf", "media_files" })
      end)
    end,
    lazy = true,
  },

  -- Icon
  {
    "nvim-tree/nvim-web-devicons",
  },

  -- StatusLine & Bufferline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require("configs.lualine")
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require("configs.bufferline")
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },

  -- notification
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      stages = "fade_in_slide_out",
      timeout = 1500,
      background_colour = "#2E3440",
    },
    config = function(_, opts)
      local nvim_notify = require("notify")
      nvim_notify.setup(opts)
      vim.notify = nvim_notify
    end,
  },
  -- auto-completion for cmdline
  {
    "gelguy/wilder.nvim",
    lazy = true,
  },

  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({})
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  },

  -- Debugger
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      opts = {},
      config = function(_, opts)
        require("configs.dap").setup_ui(opts)
      end,
    },
    lazy = true,
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    config = function()
      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
  },
  { "ofirgall/goto-breakpoints.nvim" },
  -- Edit

  { "tpope/vim-unimpaired", event = "VimEnter" },
  { "tpope/vim-repeat", event = "VimEnter" },
  { "tpope/vim-endwise", event = "VimEnter" },
  { "tpope/vim-surround", event = "VimEnter" },
  { "tpope/vim-abolish", event = "VimEnter" },
  { "tpope/vim-commentary", event = "VimEnter" },
  { "tpope/vim-sleuth", event = "VimEnter" },
  { "tpope/vim-dispatch", lazy = true },
  { "radenling/vim-dispatch-neovim", lazy = true },
  { "andymass/vim-matchup", lazy = true },
  {
    "Pocco81/true-zen.nvim",
    opts = function()
      require("configs.others").truezen()
    end,
    config = function(_, opts)
      require("true-zen").setup(opts)
    end,
  },

  -- Markdown utils

  {
    "iamcco/markdown-preview.nvim",
    init = function()
      require("configs.others").md_preview()
    end,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown", "pandoc", "vimwiki" },
  },

  -- Tags
  -- if utils.executable("ctags") then
  -- show file tags in vim window
  {
    "liuchengxu/vista.vim",
    init = function()
      require("configs.others").vista()
    end,
    cmd = "Vista",
  },
  -- end

  -- Move & Search & Replace
  {
    "karb94/neoscroll.nvim",
    opts = {
      easing_function = "quadratic",
    },
    config = function(_, opts)
      require("neoscroll").setup(opts)
      local t = require("configs.neoscroll")
      require("neoscroll.config").set_mappings(t)
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    event = "VimEnter",
    keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
    opts = {
      calm_down = true,
      nearest_only = true,
    },
    config = function(_, opts)
      require("hlslens").setup(opts)
      require("configs.hlslens").load_mappings()
    end,
  },

  -- UI
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    init = function()
      require("configs.colorscheme").gruvbox()
    end,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },

  -- { "sainnhe/everforest",                          lazy = true },
  -- { "EdenEast/nightfox.nvim",                      lazy = true },
  -- { "christianchiarulli/nvcode-color-schemes.vim", lazy = true },

  --  {'vim-ctrlspace/vim-ctrlspace'}

  -- Note Taking
  {
    "vimwiki/vimwiki",
    init = function()
      require("configs.vimwiki").vimwiki()
    end,
    ft = { "vimwiki", "markdown", "pandoc" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "vimwiki",
        command = "set syntax=pandoc",
      })
    end,
  },
  {
    "CaeChao/vim-zettel",
    init = function()
      require("configs.vimwiki").zettel()
    end,
    ft = { "vimwiki" },
  },
  {
    "tools-life/taskwiki",
    init = function()
      require("configs.vimwiki").taskwiki()
    end,
    ft = { "vimwiki" },
  },
  { "blindFS/vim-taskwarrior", ft = { "vimwiki" } },
  { "powerman/vim-plugin-AnsiEsc", ft = { "vimwiki" } },
  { "mattn/calendar-vim", ft = { "vimwiki" } },
}

function M.load()
  local lazy_available, lazy = pcall(require, "lazy")
  local lazy_nvim = require("configs.lazy_nvim")
  if not lazy_available then
    vim.notify("skipping loading plugins until lazy.nvim is installed", vim.log.levels.ERROR, { title = "lazy.nvim" })
    return
  end

  lazy.setup(plugins_list, lazy_nvim)
end

return M
