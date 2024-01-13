local ts = vim.treesitter

local bufnr = 18

---Get TSNode text
---@param node TSNode
---@return string
local function text(node)
	return ts.get_node_text(node, bufnr)
end

local function trim(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function map(tbl, f)
	local t = {}
	for k, v in pairs(tbl) do
		t[k] = f(v)
	end
	return t
end

local function get_list(s)
	local _, _, capture = string.find(s, "{(.*)}")
	local dirty = vim.split(capture, ",")
	local clean = map(dirty, trim)
	return clean
end

local import = {
	named = { "useState", "useRef", "type ElementRef" },
	from = "react",
}

local importDefault = {
	default = "React",
	named = {},
	from = "react",
}

local justImport = {
	named = {},
	from = "react",
}

local bothImport = {
	default = "React",
	named = { "useState", "useRef", "type ElementRef" },
	from = "react",
	location = {
		start_row = 1,
		end_row = 1,
	},
}

local function to_string(im)
	if im.default == nil and #im.named == 0 then
		return 'import "' .. im.from .. '"'
	elseif im.default ~= nil and #im.named ~= 0 then
		return "import " .. im.default .. ", { " .. table.concat(im.named, ", ") .. ' } from "' .. im.from .. '"'
	elseif im.default ~= nil then
		return "import " .. im.default .. ' from "' .. im.from .. '"'
	elseif #im.named ~= 0 then
		return "import { " .. table.concat(im.named, ", ") .. ' } from "' .. im.from .. '"'
	end
end

local a = (to_string(import))
local b = (to_string(importDefault))
local c = (to_string(justImport))
local d = (to_string(bothImport))

-- Import Test
-- vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, { a })
-- vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, { b })
-- vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, { c })
-- vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, { d })

local function add_import(im, bufn)
	vim.api.nvim_buf_set_lines(bufn, im.position.start_row, im.position.end_row + 1, true, { to_string(im) })
end

-- add_import(bothImport, bufnr)

local import_query = [[
	(import_statement
    (import_clause
      (identifier)? @default
			(named_imports)? @named
    )?
    source: (string (string_fragment) @from)
  )
]]

local function get_imports(bufn)
	local parser = ts.get_parser(bufn)
	local trees = parser:parse()
	local root = trees[1]:root()
	local lang = parser:lang()

	local tsx_query = ts.query.parse(lang, import_query)
	local captures = tsx_query.captures

	local imports = {}

	for i, matches, metadata in tsx_query:iter_matches(root, bufn) do

		local import = {}

		for id, match in pairs(matches) do
			local name = captures[id]
			if name == "named" then
				local s = text(match)
				local arr = get_list(s)
				-- print(name .. ": " .. vim.inspect(arr))
				import[name] = arr
			else
				if name == "from" then
					local start_row, _, end_row = ts.get_node_range(match)
					import["position"] = { start_row = start_row, end_row = end_row }
				end

				import[name] = text(match)
				-- print(name .. ": " .. text(match))
			end
			-- import[name] = text(match)
		end

		if import["named"] == nil then
			import["named"] = {}
		end

		table.insert(imports, import)
	end

	return imports
end

local imports = get_imports(bufnr)

-- for _, im in ipairs(imports) do
-- 	-- print(vim.inspect(imports))
-- 	add_import(im, bufnr)
-- end

local x = imports[4]
-- table.insert(x.named, "useEffect")
x.default = "AIE"

add_import(x, bufnr)

-- print(vim.inspect(imports))

local M = {}
return M
