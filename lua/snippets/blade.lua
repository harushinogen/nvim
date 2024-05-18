local blade = {}

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

local foreach = s({ trig = "@for" }, {
  t("@foreach("),
  i(1),
  t(" as "),
  i(2),
  t({")", "@endforeach"}),
})

blade.init = function()
  local blade_snippets = {
    foreach,
  }

  ls.add_snippets("blade", blade_snippets)
end

return blade
