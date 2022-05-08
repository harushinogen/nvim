-- Cokeline [bufferline]
local is_picking_focus = require('cokeline/mappings').is_picking_focus
local get_hex = require('cokeline/utils').get_hex

local yellow = vim.g.terminal_color_3

require('cokeline').setup({
	default_hl = {
		fg = function(buffer)
			return
			buffer.is_focused
			and get_hex('ColorColumn', 'bg')
			or get_hex('Normal', 'fg')
		end,
		bg = function(buffer)
			return
			buffer.is_focused
			and get_hex('Normal', 'fg')
			or get_hex('ColorColumn', 'bg')
		end,
	},

	components = {
		{
			text = ' ',
		},
		{
			text = function(buffer)
				return
				(is_picking_focus())
				and buffer.pick_letter .. ' '
				or buffer.devicon.icon
			end,
			fg = function(buffer)
				return
				(is_picking_focus() and yellow)
				or buffer.devicon.color
			end,
			style = function(_)
				return
				(is_picking_focus())
				and 'italic,bold'
				or nil
			end,
		},
		{
			text = function(buffer) return buffer.is_modified and  '*' or ' ' end,
		},
		{
			text = function(buffer) return buffer.filename .. '  ' end,
			style = function(buffer) return buffer.is_focused and 'bold' or nil end,
		},
	},

})

-- lualine

require('lualine').setup({
options = {
	section_separators = { left = '', right = ''}
	},
sections = {
	lualine_b = {'filename'},
	lualine_c = {'branch', 'diff', 'diagnostics'},
	lualine_x = {'encoding', 'fileformat', 'filetype'},
	lualine_y = {'progress'},
	lualine_z = {'location'}
	},
})

