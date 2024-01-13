local tsx = {}

local ls = require("luasnip")

local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")

---@param name string
---@param from string
local function insert_import_tsx(name, from)
	local text = "import " .. name .. " from " .. '"' .. from .. '"'
	-- find useState from react
	-- > found => don't do anything
	-- find react
	-- > found => append useState to the items
	-- > not found => add new import
	vim.api.nvim_buf_set_lines(0, 0, 0, true, { text })
end

local useState = s({ trig = "st(.*)", regTrig = true }, {
	t("const ["),
	f(function(_, snip)
		insert_import_tsx("{ useState }", "react")

		local text = snip.captures[1]
		local head = string.upper(string.sub(text, 0, 1))
		local tail = string.sub(text, 2)
		return text .. ", set" .. head .. tail
	end, {}),
	t("] = useState"),
	i(1),
	t("("),
	i(2),
	t(");"),
})

local function fname()
	return vim.fn.expand("%:t:r")
end

local rfc = s("rfc", {
	f(function()
		return "function " .. fname() .. "("
		-- return vim.fn.expand("%:t:r")
	end, {}),
	i(1),
	t({ ") {", "\t", "\treturn (", "\t\t\t" }),
	i(2),
	t({ "", "\t)", "}" }),
})

local erfc = s("erfc", {
	f(function()
		return "export default function " .. fname() .. "("
		-- return vim.fn.expand("%:t:r")
	end, {}),
	i(1),
	t({ ") {", "\t", "\treturn (", "\t\t\t" }),
	i(2),
	t({ "", "\t)", "}" }),
})

local ref = s("ref", { 
	f(function() 
		insert_import_tsx("{ useRef, type ElementRef }", "react")
		-- insert_import_tsx("{ useIntersectionObserver }", "@utils/hooks")
	end),
	t("const "),
	i(1, "ref"), 
	t(' = useRef<ElementRef<"'), i(2, "div"), t('">>(null);'),
	-- t({"","const "}),
	-- i(3, "entry"), 
	-- t(' = useIntersectionObserver('),
	-- f(function(_, snip) return snip.captures[1] end),
	-- t(', {'),
	-- i(4),
	-- t('})'),
	-- t({"","const isVisible = !!"}),
	-- f(function(_, snip) return snip.captures[3] end),
	-- t('.isVisible')
})

local clsx = s("clsx", { t('import clsx from "clsx"') })

tsx.init = function()
	local ts_snippets = {
		erfc,
		ref,
		clsx,
		erfc,
		useState
	}

	local js_snippets = {
		erfc,
		clsx,
		rfc,
		useState
	}

	ls.add_snippets("typescriptreact", ts_snippets)
	ls.add_snippets("javascript", js_snippets)
end

return tsx
