local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

ls.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "<-- current choice", "Error" } },
			},
		},
	},
}

ls.cleanup()

require('snippets/typescriptreact').init()

local ternary = s("ter", {
	-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
	i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
})

local arrowFunction = s("fn", {
	t "const ",
	i(1, "functionName"),
	t(" = ("),
	i(2),
	t { ") => {", "\t" },
	i(3),
	t { "", "}" }
})

local class = s("cl", {
	t "class ",
	c(1, {
		sn(nil, { i(1), t " extends ", i(2) }),
		sn(nil, { i(1), t " implements ", i(2) }),
		sn(nil, { i(1), t " " }),
	}),
	t { "{", "\t" },
	i(0),
	t { "", "}" },
})

ls.add_snippets("typescriptreact", {
	ternary,
	class,
	arrowFunction,
})

ls.add_snippets("js", {
	ternary,
	class,
	arrowFunction,
})

ls.add_snippets("typescript", {
	ternary,
	class,
	arrowFunction,
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

ls.add_snippets("lua", {
	-- choice node experiment
	s("cn", { c(1, { t "ogey", t "rrat" }) }), -- works well
	-- choice node & insert node
	s("cni", { c(1, { t "ogey", i(1, "rrat") }) }),
	-- insert node inside of choice node will
	-- result in inability to select the next choice once the insert node is reached
	-- it should be possible to choose again once entering insert MODE

	-- choice node & snippet node
	s("cns", { c(1, { t "ogey", sn(nil, { t "maha", t "", t "anjir" }) }) }),
	-- choice node & snippet node with insert node
	s("cnsi", {
		c(1, {
			t "ogey",
			sn(nil, { t({ "maha", "" }), i(1), t "", t "anjir" })
		})
	}),
	s("paren_change", {
		c(1, {
			sn(nil, { t("("), r(1, "user_text"), t(")") }),
			sn(nil, { t("["), r(1, "user_text"), t("]") }),
			sn(nil, { t("{"), r(1, "user_text"), t("}") }),
		}),
	}, {
		stored = {
			user_text = i(1, "default_text")
		}
	})
})
