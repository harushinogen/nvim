require 'plugins'
require 'keybinds'
require 'cosmetics'
require 'utilities'
require 'lsp'
require 'snippets'
require 'treesitter'

local o = vim.opt
o.termguicolors = true
o.list = true
o.cursorline = true
o.hidden = true
o.splitright = true
o.splitbelow = true

-- TODO change it to native lua
vim.cmd [[
set number relativenumber

let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_keymap_prev   = '<C-h>'
let g:floaterm_keymap_next   = '<C-l>'
let g:floaterm_keymap_toggle = '<Leader>fc'
let g:floaterm_wintype = 'split'
let g:floaterm_height = 0.4
let g:floaterm_width = 1
" let g:gruvbox_material_palette = 'material'
" let g:gruvbox_material_background = 'dark'

set termguicolors

set completeopt=menuone,noinsert,noselect
set shortmess+=c

syntax enable
colorscheme nightfox

set tabstop=2
set softtabstop=2
set shiftwidth=2
]]

-- nnoremap <leader>l :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
-- set termguicolors
-- set shiftwidth=2
-- set tabstop=2
-- set softtabstop=2
-- set hidden

