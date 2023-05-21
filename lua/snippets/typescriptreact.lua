local tsx = {}
tsx.init = function(ls)
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

	local function fname()
		return vim.fn.expand("%:t:r")
	end

	local snippet = {
		-- functional component
		s('fc', fmt([[
		{}({}) {}{{
			{} (
				<{}>
					{}
				</{}>
			);
		}}
	]], {
			-- choose between arrow and regular function
			c(1, {
				sn(nil, { t "function ", i(1)}),
				sn(nil, { t "const ", i(1), t " = " })
			}),
			i(2),
			f(function(text)
				return string.match(text[1][1], "=") and "=> " or ""
			end, { 1 }),
			c(3, { sn(nil, { t { "", "\t" }, i(1), t { "", "", "\treturn" } }), t "return" }),
			i(4),
			i(0),
			f(function(text)
				return vim.split(text[1][1], ' ', { plain = true })[1]
			end, { 4 }),
		})),


		-- quick functional component
		s("rfc", {
			f(function ()
				return "function " .. fname() .. "("
				-- return vim.fn.expand("%:t:r")
			end, {}),
			i(1),
			t {") {", "\t", "\treturn (", "\t\t<div>", "\t\t\t"},
			i(2),
			t {"", "\t\t</div>", "\t)", "}"},
		}),

		-- function

		-- useState)
		s({ trig = "st(.*)", regTrig = true}, {
			t "const [",
			f(function(_, snip)
				local text = snip.captures[1]
				local head = string.upper(string.sub(text, 0, 1))
				local tail = string.sub(text, 2)
				return text .. ", set" .. head .. tail
			end, {}),
			t "] = useState",
			i(1),
			t "(",
			i(2),
			t ");",
		})
	}

	ls.add_snippets('typescriptreact', snippet)
	ls.add_snippets('javascript', snippet)

end

return tsx
