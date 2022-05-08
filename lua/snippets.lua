local ls = require "luasnip"
local types = require "luasnip.util.types"
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local i = ls.insert_node
local t = ls.text_node
local s = ls.snippet

ls.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "<-", "Error" } },
			},
		},
	},
}

local ternary = s("ternary", {
	-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
	i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
})

ls.add_snippets("js", {
	ternary,
})

ls.add_snippets("typescript", {
	ternary,
})

ls.add_snippets("lua", {

	-- adding snippet
	s("addsnip", fmt([[
	s('{}', {{
	  {}
	}}),
	]], { i(1, 'snippet`s name'), i(2, 'contents') })),

	-- require
	s('req', fmt([[local {} = require '{}']], { i(1, "package name"), rep(1) })),
})

ls.add_snippets("dart", {

		-- StatelessWidget
	s('stl', fmt([[
		class {} extends StatelessWidget {{
			const {}({{Key? key}}) : super(key: key);

			Widget build(BuildContext context) {{
				return {};
			}}
		}}
		]], {
		i(1, "ClassName"),
		rep(1),
		i(0),
	})),

	-- @override
	s('ov', {
	  t("@override"),
	}),
})
