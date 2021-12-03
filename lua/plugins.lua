local fn = vim.fn
local utils = require('utils')
local cmd = vim.cmd

local packer_dir = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local packer_repo = 'https://github.com/wbthomason/packer.nvim'
-- local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_dir)

cmd 'packadd packer.nvim'

if fn.empty(fn.glob(packer_dir)) > 0 then
  vim.api.nvim_echo({ {'Installing packer.nvim', 'Type'} }, true, {})
  -- remove the dir before cloning from github
  fn.delete(packer_dir, 'rf')
  packer_bootstrap = fn.system({'git', 'clone', packer_repo, '--depth', '1', packer_dir})
  -- cmd(install_cmd)

  cmd 'packadd packer.nvim'
  present, packer = pcall(require, 'packer')

  if present then
    print 'Packer Installed successfully'
  else
    error("Couldn't clone packer !\nPacker path: " .. packer_dir .. '\n' .. packer)
  end
end


require('packer').startup({
  function() 

    -- core plugins 
    use { 'wbthomason/packer.nvim', event = 'VimEnter' }
    
    use { 'kyazdani42/nvim-web-devicons', config = [[require('configs.icons')]] }
  
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function() require('configs.lualine') end,
    }

    -- Syntax
    use { 'nvim-treesitter/nvim-treesitter', event = 'BufRead', run = ':TSUpdate', config = [[require('configs.treesitter')]] }
    use 'MaxMEllon/vim-jsx-pretty'
    
    use { 'norcalli/nvim-colorizer.lua', config = [[require('configs.others').colorizer()]] }

    use { 
      'akinsho/bufferline.nvim', 
      event = 'VimEnter',
      after = 'nvim-web-devicons',
      config = [[require('configs.bufferline')]] 
    }
    
    use { 'lukas-reineke/indent-blankline.nvim', event = 'VimEnter', config = [[require('configs.others').blankline()]] }
 
    -- Git Integration
    use { 'tpope/vim-fugitive', event = 'User InGitRepo' }
    use { 'lewis6991/gitsigns.nvim', opt = true, config = [[require('gitsigns')]] }

    -- file managing , picker etc
    use {
      'kyazdani42/nvim-tree.lua',
      cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
      config = [[require('configs.nvimtree')]],
    }

    use {
      'nvim-telescope/telescope.nvim',
      module = 'telescope',
      cmd = 'Telescope',
      requires = {
        {
          'nvim-lua/plenary.nvim'
        },
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make',
        },
      },
      config = [[require('configs.telescope')]],
    }

    -- snippet engine and snippet template
    use {
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      wants = 'friendly-snippets',
      config = [[require('configs.others').luasnip()]]
    }

    use { 'onsails/lspkind-nvim', event = 'BufEnter' } -- vscode style snippet icons

    -- auto-completion engine
    use { 'hrsh7th/nvim-cmp', after = 'lspkind-nvim', config = [[require('configs.cmp')]] }

    -- nvim-cmp completion sources
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua', after = 'cmp_luasnip' }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'f3fora/cmp-spell', after = 'nvim-cmp' }
    
    use { 'rafamadriz/friendly-snippets', event = 'InsertEnter' }
    -- use { 'honza/vim-snippets', event = 'InsertEnter' }
   
    -- LSP 
    

    use { 'neovim/nvim-lspconfig', after = 'cmp-nvim-lsp', config = [[require('configs.lsp')]] }
    use { 'folke/lsp-colors.nvim', config = [[require('configs.others').lspcolors()]] }

    use {
     'folke/trouble.nvim',
     requires = 'kyazdani42/nvim-web-devicons',
     config = function()
       require('trouble').setup {}
     end
    }

    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"

    --
    -- Edit
    -- use {'karb94/neoscroll.nvim'}
    use { 'windwp/nvim-autopairs', after = 'nvim-cmp', config = [[require('configs.others').autopairs()]] }
    use { 'tpope/vim-unimpaired', event='VimEnter' }
    use { 'tpope/vim-repeat', event='VimEnter' }
    use { 'tpope/vim-endwise', event='VimEnter' }
    use { 'tpope/vim-surround', event='VimEnter' }
    use { 'tpope/vim-abolish', event='VimEnter' }
    use { 'tpope/vim-commentary', event='VimEnter' }
    use { 'tpope/vim-sleuth', event='VimEnter' }
    use { 'tpope/vim-dispatch', opt=true }
    use { 'radenling/vim-dispatch-neovim', opt=true }
    -- use {'machakann/vim-highlightedyank', event='VimEnter'}
    use { 'romainl/vim-cool', event = 'VimEnter' } -- Clear highlight search automatically
    use { 'andymass/vim-matchup',  opt = true }


   -- Markdown     
    use { 'vim-pandoc/vim-pandoc', ft = {'markdown'} }
    use { 'vim-pandoc/vim-pandoc-syntax', ft = {'markdown'} }
    use { 'elzr/vim-json', ft = { 'json', 'markdown' } }
    use {
        'iamcco/markdown-preview.nvim',
        run = function()
          fn['mkdp#util#install']()
        end,
        ft = {'markdown', 'pandoc', 'vimwiki','vim-plug'},
      }

     -- Only install these plugins if ctags are installed on the system
    if utils.executable('ctags') then
      -- plugin to manage your tags
      use {'ludovicchabant/vim-gutentags', event = 'VimEnter'}
      -- show file tags in vim window
      use {'liuchengxu/vista.vim', cmd = 'Vista'}
      use {'majutsushi/tagbar', cmd = {'TagbarToggle', 'TagbarOpen'}}
    end

    -- UI
    use { 'sainnhe/gruvbox-material', opt = true }
    use { 'sainnhe/everforest', opt = true }
    -- use ({'eddyekofo94/gruvbox-flat.nvim', opt = true})
    use { 'EdenEast/nightfox.nvim', opt = true }
    use { 'christianchiarulli/nvcode-color-schemes.vim', opt = true }

    -- use {'vim-ctrlspace/vim-ctrlspace'}
    
    -- Note Taking
    use {'caechao/vimwiki', ft = {'vimwiki', 'markdown', 'pandoc'}}
    use {'tools-life/taskwiki', after='vimwiki', ft = {'vimwiki', 'markdown', 'pandoc'}}
    use {'powerman/vim-plugin-AnsiEsc', after='vimwiki'}
    use {'blindFS/vim-taskwarrior', after='vimwiki'}
    use {'mattn/calendar-vim'}

    if packer_bootstrap then
      require('packer').sync()
    end
  end
})