return {
	{
		dir = "~/repos/plugins/ts-import.nvim",
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")
			require("snippets/typescriptreact").init()
			require("snippets/blade").init()
			require("snippets/general").init()
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
		end,
	},
}
