local ts = vim.treesitter

local function p(value)
	print(vim.inspect(value))
end

local function t(node)
	p(ts.get_node_text(node, 0))
end

local query_string = [[
(frontmatter
  (raw_text) @ts)
]]

return function()
	local parser = ts.get_parser()
	local trees = parser:parse()
	local root = trees[1]:root()
	local lang = parser:lang()

	local astro_query = ts.query.parse(lang, query_string)

	local typescript_query = ts.query.parse("typescript", "(identifier) @name")

	for _, matches, _ in astro_query:iter_matches(root, 0) do
		local typescript_node = matches[1]
		local start_line, start_col, end_line, end_col = ts.get_node_range(typescript_node)

		local ty_trees = parser:language_for_range({ start_line, start_col, end_line, end_col }):parse()
		local ty_root = ty_trees[1]:root()

		for _, matches, _ in typescript_query:iter_matches(ty_root, 0) do
			local tyr = matches[1]
			t(tyr)

			local start_line1, start_col1 = ts.get_node_range(tyr)
			print(start_line1 + 1, start_col1 + 1)
		end
	end
end
