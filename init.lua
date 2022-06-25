require 'impatient'

require 'utilities'
require 'plugins'
require 'keybinds'
require 'lsp'
require 'snippets'
require 'treesitter'
require 'cosmetics'
require 'colorscheme'

local o = vim.opt
o.list = true
o.cursorline = true
o.hidden = true
o.splitright = true
o.splitbelow = true

-- TODO change it to native lua
vim.cmd [[
set number relativenumber

let g:floaterm_keymap_new = '<leader>ft'
let g:floaterm_keymap_prev   = '<leader><leader>h'
let g:floaterm_keymap_next   = '<leader><leader>l'
let g:floaterm_keymap_toggle = '<leader>fc'
let g:floaterm_wintype = 'split'
let g:floaterm_height = 0.4
let g:floaterm_width = 1
let g:gruvbox_material_palette = 'original'
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_enable_bold = 1

" Colorscheme stuff
set termguicolors
colorscheme gruvbox-material
filetype plugin indent on

" Autocomplete stuff
" set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Highlighting


" Indentation
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Open help splitted vertically
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

set background=dark
set bg=dark

syntax enable

hi Search guibg=black guifg=white

]]


-- nnoremap <leader>l :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
-- set termguicolors
-- set shiftwidth=2
-- set tabstop=2
-- set softtabstop=2
-- set hidden

