local function map(mode, shortcut, command, callback)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, callback = callback })
end

local function nmap(shortcut, command, callback)
  map("n", shortcut, command, callback)
end

local function vmap(shortcut, command, callback)
  map("v", shortcut, command, callback)
end

return {
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "hinell/move.nvim",
    config = function()
      nmap("<A-k>", ":MoveLine -1<CR>")
      nmap("<A-j>", ":MoveLine 1<CR>")

      vmap("<A-k>", ":MoveBlock -1<CR>")
      vmap("<A-j>", ":MoveBlock 1<CR>")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
      check_ts = true,
      ts_config = {
        lua = { "string" }, -- it will not add a pair on that treesitter node
        javascript = { "template_string" },
        java = false,   -- don't check treesitter on java
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      local ts_conds = require("nvim-autopairs.ts-conds")

      -- press % => %% only while inside a comment or string
      npairs.add_rules({
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
      })
    end,
  },
  {
    "CRAG666/code_runner.nvim",
    config = true,
    opts = {
      project = {
        ["~/repos/python/odoo17"] = {
          name = "Odoo 17",
          description = "Odoo 17 project",
          command = "sh -c 'source venv/bin/activate && ",
        },
      },
    },
  },
  {
    "chrisbra/vim-xml-runtime",
    config = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "*.xml" },
        command = "set formatexpr=xmlformat#Format()",
      })
    end,
  },
  {
    "mechatroner/rainbow_csv",
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function(_, opts)
      require("package-info").setup(opts)

      nmap("<leader>ns", "<cmd>lua require('package-info').show()<cr>")
      nmap("<leader>nd", "<cmd>lua require('package-info').delete()<cr>")
      nmap("<leader>np", "<cmd>lua require('package-info').change_version()<cr>")
      nmap("<leader>ni", "<cmd>lua require('package-info').install()<cr>")
    end,
  },
  {
    "laytan/cloak.nvim",
    opts = {
      enabled = true,
      cloak_character = "*",
      -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
      highlight_group = "Comment",
      -- Applies the length of the replacement characters for all matched
      -- patterns, defaults to the length of the matched pattern.
      cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
      -- Whether it should try every pattern to find the best fit or stop after the first.
      try_all_patterns = true,
      patterns = {
        {
          -- Match any file starting with '.env'.
          -- This can be a table to match multiple file patterns.
          file_pattern = ".env*",
          -- Match an equals sign and any character after it.
          -- This can also be a table of patterns to cloak,
          -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
          cloak_pattern = "=.+",
          -- A function, table or string to generate the replacement.
          -- The actual replacement will contain the 'cloak_character'
          -- where it doesn't cover the original text.
          -- If left empty the legacy behavior of keeping the first character is retained.
          replace = nil,
        },
      },
    },
  },
  {
    "mattn/emmet-vim",
  },
}
