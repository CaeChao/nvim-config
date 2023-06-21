local M = {}
local plugins_list = {

  -- Icon
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return require("plugins.configs.icons")
    end,
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },

  -- StatusLine & Bufferline
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require("plugins.configs.lualine")
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VimEnter",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require("plugins.configs.bufferline")
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },

  -- Syntax
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require("plugins.configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  "MaxMEllon/vim-jsx-pretty",

  {
    "norcalli/nvim-colorizer.lua",
    opts = function()
      return require("plugins.configs.others").colorizer
    end,
    config = function(_, opts)
      require("colorizer").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require("plugins.configs.others").blankline
    end,
    config = function(_, opts)
      require("indent_blankline").setup(opts)
    end,
  },

  { "vim-pandoc/vim-pandoc", ft = { "markdown", "vimwiki", "pandoc" } },
  { "vim-pandoc/vim-pandoc-syntax", ft = { "markdown", "pandoc", "vimwiki" } },
  { "elzr/vim-json", ft = { "json" } },
  { "chrisbra/csv.vim", ft = { "csv" } },

  { "liuchengxu/graphviz.vim", ft = { "gv", "dot" } },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  { "tpope/vim-fugitive", lazy = true, cmd = { "G", "Git" } },

  -- File explorer, picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require("plugins.configs.nvimtree")
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

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
      return require("plugins.configs.telescope")
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- load extensions

      pcall(function()
        telescope.load_extension({ "fzf", "media_files" })
      end)
    end,
  },

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
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
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
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "f3fora/cmp-spell",
      },
      --  { 'honza/vim-snippets', event = 'InsertEnter' }
    },
    opts = function()
      return require("plugins.configs.cmp")
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- auto-completion for cmdline
  {
    "gelguy/wilder.nvim",
    lazy = true,
  },

  --   {
  --     "williamboman/mason.nvim",
  --     build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  --   },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.lsp")
    end,
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

  "jose-elias-alvarez/null-ls.nvim",
  "jose-elias-alvarez/nvim-lsp-ts-utils",

  -- Debugger
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      opts = {},
      config = function(_, opts)
        require("plugins.configs.dap").setup_ui(opts)
      end,
    },
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
      require("plugins.configs.others").truezen()
    end,
    config = function(_, opts)
      require("true-zen").setup(opts)
    end,
  },

  -- Markdown utils

  {
    "iamcco/markdown-preview.nvim",
    init = function()
      require("plugins.configs.others").md_preview()
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
      require("plugins.configs.others").vista()
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
      local t = require("plugins.configs.neoscroll")
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
      require("plugins.configs.hlslens").load_mappings()
    end,
  },

  -- notification
  {
    "rcarriga/nvim-notify",
    event = "BufEnter",
    config = function()
      vim.defer_fn(function()
        require("plugins.configs.notify")
      end, 2000)
    end,
  },

  -- UI
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    init = function()
      require("plugins.configs.colorscheme").gruvbox()
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
      require("plugins.configs.vimwiki").vimwiki()
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
      require("plugins.configs.vimwiki").zettel()
    end,
    ft = { "vimwiki" },
  },
  {
    "tools-life/taskwiki",
    init = function()
      require("plugins.configs.vimwiki").taskwiki()
    end,
    ft = { "vimwiki" },
  },
  { "blindFS/vim-taskwarrior", ft = { "vimwiki" } },
  { "powerman/vim-plugin-AnsiEsc", ft = { "vimwiki" } },
  { "mattn/calendar-vim", ft = { "vimwiki" } },
}

function M.load()
  local lazy_available, lazy = pcall(require, "lazy")
  local lazy_nvim = require("plugins.configs.lazy_nvim")
  if not lazy_available then
    vim.notify("skipping loading plugins until lazy.nvim is installed", vim.log.levels.ERROR, { title = "lazy.nvim" })
    return
  end

  lazy.setup(plugins_list, lazy_nvim)
end

return M
