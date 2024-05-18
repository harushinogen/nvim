return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- build = "",
    -- priority = 100,
    lazy = false,
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    opts = {
      -- ensure_installed = {
      --   "php",
      --   "dart",
      --   "python",
      --   "javascript",
      --   "typescript",
      --   "rust",
      --   "lua",
      --   "c",
      --   "json",
      --   "markdown",
      --   "html",
      --   "blueprint",
      --   "tsx",
      --   "css",
      --   "astro",
      --   "vim",
      --   "vimdoc"
      -- },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        disable = { "vala", "scss" },
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        -- additional_vim_regex_highlighting = { "vala", "scss", "prisma", "blueprint" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>i",
          node_incremental = "]]",
          scope_incremental = "\\",
          node_decremental = "[[",
        },
      },
      indent = { enable = true },
      -- rainbow = {
      -- 	enable = true,
      -- 	-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      -- 	extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      -- 	max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- 	-- colors = {}, -- table of hex strings
      -- 	-- termcolors = {} -- table of colour name strings
      -- },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
      autotag = {
        enable = true,
      },
    },
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.xml = {
        install_info = {
          url = "~/repos/utils/tree-sitter-xml",
          files = { "src/parser.c" },
          -- optional entries:
          branch = "main",
          require_generate_from_grammar = false,
        },
      }

      parser_config.blueprint = {
        install_info = {
          url = "~/repos/utils/tree-sitter-blueprint",
          files = { "src/parser.c" },
          -- optional entries:
          branch = "main",
          require_generate_from_grammar = false,
        },
      }

      -- parser_config.tsx = {
      --   install_info = {
      --     url = "~/repos/utils/tree-sitter-typescript-0.20.3/tsx",
      --     files = { "src/parser.c" },
      --     -- optional entries:
      --     branch = "main",
      --     require_generate_from_grammar = false,
      --   },
      -- }
      --
      -- parser_config.typescript = {
      --   install_info = {
      --     url = "~/repos/utils/tree-sitter-typescript-0.20.3/typescript",
      --     files = { "src/parser.c" },
      --     -- optional entries:
      --     branch = "main",
      --     require_generate_from_grammar = false,
      --   },
      -- }

      parser_config.nu = {
        install_info = {
          url = "~/repos/utils/tree-sitter-nu",
          files = { "src/parser.c" },
          branch = "main",
          require_generate_from_grammar = false,
        },
        filetype = "nu",
      }

      parser_config.blade = {
        install_info = {
          url = "~/repos/utils/tree-sitter-blade-0.10.0",
          files = { "src/parser.c" },
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
