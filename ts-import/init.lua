local ts = vim.treesitter

local M = {}

---@class Import
---@field named string[]
---@field default string | nil
---@field from string
---@field position { start_row: number, end_row: number }
local Import = {

  ---@param im Import
  ---@return string
  to_string = function(im)
    if im.default ~= nil and #im.named ~= 0 then
      return "import " .. im.default .. ", { " .. table.concat(im.named, ", ") .. ' } from "' .. im.from .. '"'
    elseif im.default ~= nil then
      return "import " .. im.default .. ' from "' .. im.from .. '"'
    elseif #im.named ~= 0 then
      return "import { " .. table.concat(im.named, ", ") .. ' } from "' .. im.from .. '"'
    else
      return 'import "' .. im.from .. '"'
    end
  end,
}

---@generic K, T, U
---@param tbl table<K, T>
---@param f fun(t: T): U
---@return table<K, U>
M.map = function(tbl, f)
  local t = {}
  for k, v in pairs(tbl) do
    t[k] = f(v)
  end
  return t
end

---Trim whitespaces from both ends of a string
---@param s string
---@return string
M.trim = function(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

---Get named from named string
---Example:
---from: "{ useState, useEffect, type ElementRef }"
---into: ["useState", "useEffect", "type ElementRef"]
---@param s string
---@return string[]
M.get_named_list_from_string = function(s)
  local _, _, capture = string.find(s, "{(.*)}")
  local dirty = vim.split(capture, ",")
  local clean = M.map(dirty, M.trim)
  return clean
end

---@param list string[]
---@param from string
---@return Import
M.new_named_import = function(list, from)
  return {
    named = list,
    from = from,
    position = {
      start_row = 0,
      end_row = -1,
    },
  }
end

---@param default string
---@param from string
---@return Import
M.new_default_import = function(default, from)
  return {
    default = default,
    named = {},
    from = from,
    position = {
      start_row = 0,
      end_row = -1,
    },
  }
end

---@param default string
---@param named string[]
---@param from string
---@return Import
M.new_default_and_named_import = function(default, named, from)
  return {
    default = default,
    named = named,
    from = from,
    position = {
      start_row = 0,
      end_row = -1,
    },
  }
end

---@param from string
---@return Import
M.new_import = function(from)
  return {
    named = {},
    from = from,
    position = {
      start_row = 0,
      end_row = -1,
    },
  }
end

local import_query = [[
	(import_statement
    (import_clause
      (identifier)? @default
			(named_imports)? @named
    )?
    source: (string (string_fragment) @from)
  )
]]


---@param bufn number
---@return Import[]
M.get_imports = function(bufn)
	local parser = ts.get_parser(bufn)
	local trees = parser:parse()
	local root = trees[1]:root()
	local lang = parser:lang()

	local tsx_query = ts.query.parse(lang, import_query)
	local captures = tsx_query.captures

	local imports = {}

	for _, matches, _ in tsx_query:iter_matches(root, bufn, 0, 9999) do

		local import = {}

		for id, match in pairs(matches) do
			local name = captures[id]
			if name == "named" then
				local s = M.text(match)
				local arr = M.get_list(s)
				import[name] = arr
			else
				if name == "from" then
					local start_row, _, end_row = ts.get_node_range(match)
					import.position = { start_row = start_row, end_row = end_row }
				end

				import[name] = M.text(match)
			end
		end

		if import.named == nil then
			import.named = {}
		end

		table.insert(imports, import)
	end

	return imports
end

---@param im Import
---@param bufn number buffer number
M.add_import = function(im, bufn)
	vim.api.nvim_buf_set_lines(bufn, im.position.start_row, im.position.end_row + 1, true, { M.to_string(im) })
end

return M
