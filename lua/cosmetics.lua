-- Cokeline [bufferline]
local is_picking_focus = require('cokeline/mappings').is_picking_focus
local get_hex = require('cokeline/utils').get_hex

local yellow = vim.g.terminal_color_4

require('cokeline').setup({
	default_hl = {
		fg = function(buffer)
			return buffer.is_focused
					and get_hex('Statement', 'fg')
					or get_hex('Normal', 'fg')
		end,
		bg = function(buffer)
			return get_hex('ColorColumn', 'bg')
		end,
	},

	components = {
		{
			text = function(buffer) return buffer.is_focused and '│ ' or '  ' end,
		},
		{
			text = function(buffer)
				return (is_picking_focus())
						and buffer.pick_letter .. ' '
						or buffer.devicon.icon
			end,
			fg = function(buffer)
				return (is_picking_focus() and yellow)
						or buffer.devicon.color
			end,
			style = function(_)
				return (is_picking_focus())
						and 'italic,bold'
						or nil
			end,
		},
		{
			text = function(buffer) return buffer.is_modified and '*' or ' ' end,
		},
		{
			text = function(buffer) return buffer.is_focused and  buffer.filename .. ' │' or buffer.filename .. '  ' end,
			style = function(buffer) return buffer.is_focused and 'bold' or nil end,
		},
	},

})

-- Tokyo Night
-- require("tokyonight").setup({
-- 	transparent = true
-- })
-- lualine

--[[ require('lualine').setup({
	options = {
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
		theme = 'gruvbox_dark',
	},
	sections = {
		lualine_b = { 'filename', 'branch', {
			'diagnostics', diagnostics_color = {
				warn = 'Type',
				error = 'Statement',
				info = 'Include',
				hint = 'Special'
			}
		} },
		lualine_c = {},
		lualine_x = { 'filetype' },
		lualine_z = { 'location' }
	},
}) ]]
