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

require("nvim-web-devicons").set_icon {
	astro = {
		icon = "",
		color = "#EEEEEE",
		name = "astro"
	},
	gitignore = {
		color = "#e77829",
	},
	-- typescriptreact = {
	-- 	icon = "",
	-- 	color = "#078fb2",
	-- 	name = "tsx"
	-- }
}
