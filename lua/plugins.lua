require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- common

  -- Cokeline
  use 'kyazdani42/nvim-web-devicons' -- If you want devicons

  -- Nvim tree
  use 'kyazdani42/nvim-tree.lua'

  use 'stevearc/dressing.nvim'

  -- Rainbow parentheses
  use 'HiPhish/nvim-ts-rainbow2'

  -- Null Ls
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  -- Vim Surround
  -- use 'tpope/vim-surround'
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })


  -- Improve loading time with caching
  use 'lewis6991/impatient.nvim'

  -- Tokyo Night
  -- use 'folke/tokyonight.nvim'

  -- Gruvbox
  -- use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/gruvbox-material'
  -- Material
  -- use 'marko-cerovac/material.nvim'

  -- Oceanic
  -- use 'mhartington/oceanic-next'

  -- Legit cool stuff
  -- use 'tjdevries/colorbuddy.nvim'

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
  -- use { "EdenEast/nightfox.nvim", tag = "v1.0.0" } -- Packer

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }

  -- Comment
  use 'numToStr/Comment.nvim'

  use 'ThePrimeagen/harpoon'

  -- Blankline
  use 'lukas-reineke/indent-blankline.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use { "williamboman/mason.nvim" }
  use "williamboman/mason-lspconfig.nvim"

  -- Autocomplete
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lua' -- Neovim API source for nvim-cmp
  use 'hrsh7th/cmp-buffer' -- Buffer words source for nvim-cmp
  use 'hrsh7th/cmp-path' -- Path source for nvim-cmp
  use 'hrsh7th/cmp-cmdline' -- Cmdline source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'onsails/lspkind.nvim' -- Additional information in the completion menu

  use 'L3MON4D3/LuaSnip'

  -- Emmet
  use 'mattn/emmet-vim' -- Emmet

  -- Autopair
  -- use 'jiangmiao/auto-pairs'
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use "windwp/nvim-ts-autotag"

  -- Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Lualine
  -- use 'nvim-lualine/lualine.nvim'

  -- use {
  --   "ThePrimeagen/refactoring.nvim",
  --   requires = {
  --       {"nvim-lua/plenary.nvim"},
  --       {"nvim-treesitter/nvim-treesitter"}
  --   }
  -- }
  -- Prisma syntax
  -- use 'pantharshit00/vim-prisma'

  use {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to false if you want to disable them
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  }

  use {
    'JellyApple102/flote.nvim'
}

  use { 'echasnovski/mini.nvim', branch = 'stable' }

  use 'ianding1/leetcode.vim'

  -- -- Polyglot for syntax highlighting
  use 'sheerun/vim-polyglot'
  --
  use 'mfussenegger/nvim-dap'
  use "jay-babu/mason-nvim-dap.nvim"
  --
  -- -- DAP
  -- use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  -- use "mfussenegger/nvim-dap-python"
  -- use "nvim-telescope/telescope-dap.nvim"
  --
  -- use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} }
  -- use {
  --   "microsoft/vscode-js-debug",
  --   opt = true,
  --   run = "npm install --legacy-peer-deps && npm run compile"
  -- }
end)
