require 'nvim-treesitter.configs'.setup {

	ensure_installed = {
		"php", "dart", "python", "javascript", "typescript", "rust", "lua", "c", "json", "markdown", "html"
	},

	highlight = {
		enable = true,

		disable = { "vala", "scss"},
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = {"vala", "scss", "prisma"},
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

	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	},

	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},

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
				["ic"] = "@class.inner"
			}
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer'
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer'
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer'
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer'
			}
		}
	},

	autotag = {
    enable = true,
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.xml = {
	install_info = {
		url ="~/repos/utils/tree-sitter-xml",
		files = {  "src/parser.c" },
		-- optional entries:
		branch = "main",
		require_generate_from_gramar = false,
	}
}
