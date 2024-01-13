-- nicer input and select overide
-- require('refactoring').setup({})

require("react-extract").setup()

-- nvim tree
require'nvim-tree'.setup {
  view = {
    width = 50,
    number = true,
  },
  diagnostics = {
    enable= true
  }
}

vim.opt.list = true

-- Indent Blankline
require("ibl").setup { }


-- Refactoring 
require('refactoring').setup({})

-- Comment.nvim
require('Comment').setup()


-- Telescope
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,

    file_ignore_patterns = {"plugged/.*","backup/.*","pack/.*", "plugin/.*","autoload/.*","node_modules/.*", "build/.*", ".*png", ".*jpg", ".*webp"},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

require('flote').setup({
  q_to_quit = true,
  window_style = 'minimal',
  window_border = 'solid',
  window_title = true
})
