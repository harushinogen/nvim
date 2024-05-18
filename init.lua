local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup("plugins")

require("filetype")
-- require("commands")
require("statusline")

local o = vim.opt
o.list = true
o.cursorline = true
o.hidden = true
o.splitright = true
o.splitbelow = true

vim.cmd([[
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
let g:gruvbox_material_transparent_background = 1

" Leetcode
let g:leetcode_solution_filetype = 'javascript'
let g:leetcode_browser = 'firefox'
let g:leetcode_hide_paid_only = 1

" Colorscheme stuff
set termguicolors
colorscheme gruvbox-material
filetype plugin indent on

" Autocomplete stuff
" set completeopt=menuone,noinsert,noselect
set shortmess+=c

set nowrap

" Highlighting


" Indentation
set expandtab
autocmd BufRead,BufEnter *.astro set filetype=astro
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Open help splitted vertically
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" set background=dark
" set bg=dark

set scrolloff=5

syntax enable

"h i Search guibg=black guifg=white
hi link xmlTagN xmlTagName
hi StatusFileName guifg=#83a598 gui=bold
hi link StatusGitBranch Constant
hi ColorColumn guifg=#fd7d17 gui=bold
hi TSComment guifg=#bdae93
hi scssTSProperty guifg=blue
" hi LineNr guifg=#70ddfc
" hi VertSplit guibg=blue ctermbg=blue

" Diagnostic Virtual text
:hi DiagnosticVirtualTextError guifg=#ea6962
:hi DiagnosticVirtualTextInfo guifg=#7daea3
:hi DiagnosticVirtualTextHint guifg=#89b482
:hi DiagnosticVirtualTextWarn guifg=#d8a657

" set winbar=%t%m
set laststatus=3

" autocmd VeryLazy TSEnable highlight
" autocmd BufRead,BufEnter *.astro TSEnable highlight
" autocmd BufRead,BufEnter *.nu set filetype=nu

]])

-- nnoremap <leader>l :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
-- set termguicolors
-- set shiftwidth=2
-- set tabstop=2
-- set softtabstop=2
-- set hidden
