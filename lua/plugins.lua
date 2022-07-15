require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- common

  -- Cokeline
  use 'noib3/nvim-cokeline'
  use 'kyazdani42/nvim-web-devicons' -- If you want devicons

  -- Nvim tree
  use 'kyazdani42/nvim-tree.lua'

  -- Pop ui -- nice pop up for code action
  use 'RishabhRD/popfix'
  use 'hood/popui.nvim'

  -- Rainbow parentheses
  use 'p00f/nvim-ts-rainbow'

  -- Vim Surround
  use 'tpope/vim-surround'

  -- Improve loading time with caching
  use 'lewis6991/impatient.nvim'

  -- Gruvbox
  -- use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/gruvbox-material'
  -- Material
  use 'marko-cerovac/material.nvim'

  -- Oceanic
  use 'mhartington/oceanic-next'

  -- Legit cool stuff
  use 'tjdevries/colorbuddy.nvim'

  -- -- Neorg
  -- use {
  -- 	"nvim-neorg/neorg",
  -- 	config = function()
  -- 		require('neorg').setup {
  -- 			load = {
  -- 				["core.defaults"] = {}
  -- 			}
  -- 		}
  -- 	end,
  -- 	requires = "nvim-lua/plenary.nvim"
  -- }

  -- use 'ray-x/lsp_signature.nvim'

  -- Nightfox
  use { "EdenEast/nightfox.nvim", tag = "v1.0.0" } -- Packer

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }

  -- Comment
  use 'numToStr/Comment.nvim'

  -- Floaterm
  use 'voldikss/vim-floaterm'

  -- Blankline
  use 'lukas-reineke/indent-blankline.nvim'

  -- NNN
  use 'luukvbaal/nnn.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Autocomplete
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lua' -- Neovim API source for nvim-cmp
  use 'hrsh7th/cmp-buffer' -- Buffer words source for nvim-cmp
  use 'hrsh7th/cmp-path' -- Path source for nvim-cmp
  use 'hrsh7th/cmp-cmdline' -- Cmdline source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'onsails/lspkind.nvim' -- Additional information in the completion menu

  -- Snippet
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Emmet
  use 'mattn/emmet-vim' -- Emmet

  -- Autopair
  use 'jiangmiao/auto-pairs'

  -- Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Lualine
  -- use 'nvim-lualine/lualine.nvim'

  -- Polyglot for syntax highlighting
  use 'sheerun/vim-polyglot'
end)
