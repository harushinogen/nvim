local M = {}

local ls = require("luasnip")

local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local singles = {
  "br",
  "img",
}

local el = s({ trig = "el(%w+)", regTrig = true }, {
  t("<"),
  f(function(_, snip)
    local element_name = snip.captures[1]
    return element_name
  end),
  i(1),
  f(function(_, snip)
    local element_name = snip.captures[1]
    if vim.tbl_contains(singles, element_name) then
      return " />"
    else
      return ">"
    end
  end),
  i(0),
  f(function(_, snip)
    local element_name = snip.captures[1]
    if not vim.tbl_contains(singles, element_name) then
      return "</" .. element_name .. ">"
    else
      return ""
    end
  end),
})

local elx = s({ trig = "ex(\\w+)(?::(?:(lg)|(lt-lg)|(cl)))*", trigEngine = "ecma"}, {
  f(function(_, snip)
    local s = ""
    for _, cap in pairs(snip.captures) do
      if cap ~= "" then
        s = s .. " " .. cap
      end
    end
    return s
  end)
})


---@param list string[]
---@param snippets string | string[]
local function add_lists(list, snippets)
  for _, lang in pairs(list) do
    ls.add_snippets(lang, snippets)
  end
end

M.init = function()
  local snippets = {
    el,
    elx
  }

  add_lists({
    "astro",
    "html",
    "javascript",
    "javascriptreact",
    "typescriptreact",
  }, snippets)
end

return M
