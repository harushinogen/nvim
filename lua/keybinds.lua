
local function map(mode, shortcut, command, callback)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, callback = callback })
end

local function nmap(shortcut, command, callback)
	map('n', shortcut, command, callback)
end

local function vmap(shortcut, command, callback)
	map('v', shortcut, command, callback)
end

local function xmap(shortcut, command)
	map('x', shortcut, command)
end

vim.g.mapleader = " " -- Set leader to space

-- LeetCode
nmap("<leader>ll", "<cmd>LeetCodeList<cr>")
nmap("<leader>ls", "<cmd>LeetCodeSubmit<cr>")
nmap("<leader>lt", "<cmd>LeetCodeTest<cr>")

-- Telescope
nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
nmap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Harpoon
nmap("ga",  '', require("harpoon.mark").add_file)
nmap("gu",  '', require("harpoon.ui").toggle_quick_menu)
nmap("g1",  '', function() require("harpoon.ui").nav_file(1) end)
nmap("g2",  '', function() require("harpoon.ui").nav_file(2) end)
nmap("g3",  '', function() require("harpoon.ui").nav_file(3) end)
nmap("g4",  '', function() require("harpoon.ui").nav_file(4) end)
nmap("g5",  '', function() require("harpoon.ui").nav_file(5) end)
nmap("g6",  '', function() require("harpoon.ui").nav_file(6) end)
nmap("g7",  '', function() require("harpoon.ui").nav_file(7) end)
nmap("g8",  '', function() require("harpoon.ui").nav_file(8) end)
nmap("g9",  '', function() require("harpoon.ui").nav_file(9) end)

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
nmap('<leader>==', '', lbuf.format)

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
local ls = require "luasnip"

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

-- DAP
nmap("<F4>", "", require'dapui'.toggle)
nmap("<F5>", "", require'dap'.toggle_breakpoint)
nmap("<F9>", "", require'dap'.continue)

nmap("<F1>", "", require'dap'.step_over)
nmap("<F2>", "", require'dap'.step_into)
nmap("<F2>", "", require'dap'.step_out)

nmap("<F6>", "", require'dap'.terminate)

-- Treesitter
nmap('<leader>th', ':TSHighlightCapturesUnderCursor<cr>')
nmap('<leader>tp', ':TSPlaygroundToggle<cr>')
nmap('<leader>tlk', ':Telescope keymaps<cr>')

-- Theming
nmap('<leader><leader>t', '<cmd>so ~/.config/nvim/lua/colorscheme.lua<cr>')

-- Nvim Tree
nmap('<a-f>', ':NvimTreeFindFileToggle<cr>')
nmap('<c-w>f', ':NvimTreeFocus<cr>')

-- require("telescope").load_extension("refactoring")

-- Yank to clipboard
vmap('<leader>y', '"+y')

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)

-- Rest nvim
nmap('<leader>rr', '<Plug>RestNvim')

-- Autopairs
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
	fast_wrap = {
		map = '<M-e>',
		chars = { '{', '[', '(', '"', "'" },
		pattern = [=[[%'%"%>%]%)%}%,]]=],
		end_key = '$',
		keys = 'qwertyuiopzxcvbnmasdfghjkl',
		check_comma = true,
		highlight = 'Search',
		highlight_grey = 'Comment'
	},
	check_ts = true,
	ts_config = {
		lua = { 'string' }, -- it will not add a pair on that treesitter node
		javascript = { 'template_string' },
		java = false, -- don't check treesitter on java
	}
})

local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
	Rule("%", "%", "lua")
			:with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
	Rule("$", "$", "lua")
			:with_pair(ts_conds.is_not_ts_node({ 'function' }))
})
