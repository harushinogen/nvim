local ts = vim.treesitter

local bufnr = 7

---@class (exact) ImportStatement
---@field default string | nil
---@field named string[]
---@field from string
---@field line_number number
---@field to_string fun(): string | nil
local ImportStatement = {}

function ImportStatement.to_string()
	if ImportStatement.default == nil and ImportStatement.named == nil then
		return nil
	end

	if ImportStatement.default ~= nil and #ImportStatement.named ~= 0 then
		return "import "
			.. ImportStatement.default
			.. ", { "
			.. table.concat(ImportStatement.named, ", ")
			.. " } from "
			.. ImportStatement.from
	elseif ImportStatement.default ~= nil then
		return "import " .. ImportStatement.default .. " from " .. ImportStatement.from
	else
		return "import {" .. table.concat(ImportStatement.named, ", ") .. " } from " .. ImportStatement.from
	end
end

---Get TSNode text
---@param node TSNode
---@return string
local function text(node)
	return ts.get_node_text(node, bufnr)
end

local function p(value)
	print(vim.inspect(value))
end

---Is used to print ts node text
---@param node TSNode TreeSitter Node
local function t(node)
	p(ts.get_node_text(node, bufnr))
end

---@param text string
---@return string
local function trim(texts)
	local _, _, f = string.find(texts, "%s*(.*)%s*")
	return f
end

local parser = ts.get_parser(bufnr)
local trees = parser:parse()
local root = trees[1]:root()
local lang = parser:lang()

local idn = [[
	(import_statement
    (import_clause
      (identifier)? @default
			(named_imports)? @named
    )
    source: (string (string_fragment) @from)
  )
]]

local tsx_query = ts.query.parse(lang, idn)

local found = false
local no = 1

local captures = tsx_query.captures

local imports = {}

for i, matches, metadata in tsx_query:iter_matches(root, bufnr) do
	print("#" .. no)

	local import = {}

	for id, match in pairs(matches) do
		local name = captures[id]
		-- print(name .. ": " .. text(match))
		import[name] = text(match)
	end

	if import["named"] == nil then
		import["named"] = {}
	else
		local _, _, cleaned = string.find(import["named"], "{(.*)}")
		vim.split(cleaned, ",")
		-- map the string using trim
		-- append it to the import[named]
	end

	-- save line number to ImportStatement

	-- construct a import_named(name, `from`) that
	-- find `from`
	-- if found outand append named import into it
	-- >> replace the line with to_string of object
	-- else make a new import statement on the top of the page

	p(import)

	found = true
	no = no + 1
end

p(imports)

if found then
	print("matches found")
else
	print("no matches found")
end
