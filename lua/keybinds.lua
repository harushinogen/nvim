local ls = require "luasnip"

local function map(mode, shortcut, command, callback)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, callback = callback })
end

local function nmap(shortcut, command, callback)
	map('n', shortcut, command, callback)
end

local function xmap(shortcut, command)
	map('x', shortcut, command)
end

vim.g.mapleader = " " -- Set leader to space


-- Telescope
nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
nmap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Easy align
xmap("ga", "<Plug>(EasyAlign)")
nmap("ga", "<Plug>(EasyAlign)")
nmap("<leader>nn", "<cmd>NnnExplorer<CR>")
nmap("<leader>np", "<cmd>NnnPicker<CR>")

-- LSP
local lbuf = vim.lsp.buf
local dgn = vim.diagnostic

nmap('gD', '', lbuf.declaration)
nmap('gd', '', lbuf.definition)
nmap('K', '', lbuf.hover)
nmap('<leader>gi', '', lbuf.implementation)
nmap('<leader>wa', '', lbuf.add_workspace_folder)
nmap('<leader>wr', '', lbuf.remove_workspace_folder)
nmap('<leader>wl', '', function() print(vim.inspect(lbuf.list_workspace_folders())) end)
nmap('<leader>D', '', lbuf.type_definition)
nmap('<leader>rn', '', lbuf.rename)
nmap('<leader>ca', '', lbuf.code_action)
nmap('gr', ':Telescope lsp_references<cr>')
nmap('<leader>e', '', dgn.open_float)
nmap('[d', '', dgn.goto_prev)
nmap(']d', '', dgn.goto_next)
nmap('<leader>q', '', dgn.setloclist)
nmap('<leader>f', '', function() lbuf.format({async = true}) end)

-- Cokeline bindings
nmap("<leader>b", "<Plug>(cokeline-pick-focus)")
nmap("<C-j>", "<Plug>(cokeline-focus-next)")
nmap("<C-k>", "<Plug>(cokeline-focus-prev)")
nmap("X", "<cmd>bd<cr>")
nmap("<C-x>", "<C-x>")

-- Personal mapping
nmap("<leader><leader>i", "<cmd>so ~/.config/nvim/init.lua<cr>")
nmap("<leader><leader>s", "<cmd>so ~/.config/nvim/lua/snippets.lua<cr>")
nmap("<leader>l", ":nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>")
nmap("<a-TAB>", "<c-w>w")
nmap("<a-s>", "<cmd>sp<cr>")
nmap("<a-v>", "<cmd>vsp<cr>")
nmap("<a-x>", "<cmd>close<cr>")

-------------
-- Luasnip --
-------------

-- Expand
vim.keymap.set({ "i", "s" }, "<c-s>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- Jump to previous jump
vim.keymap.set({ "i", "s" }, "<c-h>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- Select between items
vim.keymap.set({ "i", "s" }, "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)



-- Treesitter
nmap('<leader>th', ':TSHighlightCapturesUnderCursor<cr>')
nmap('<leader>tp', ':TSPlaygroundToggle<cr>')

-- Theming
nmap('<leader><leader>t', '<cmd>so ~/.config/nvim/lua/colorscheme.lua<cr>')

-- Nvim Tree
nmap('<a-f>', ':NvimTreeToggle<cr>')
