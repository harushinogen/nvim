name = function() return vim.api.nvim_buf_get_name(0) end
cwd = vim.fn.getcwd

function get_name()
    local escaped_cwd = cwd():gsub("([%^%$%(%)%%%.%[%]%*%+%-%?%)])", "%%%1")
    return name():gsub(escaped_cwd, ""):sub(2)
end

local function highlight(group, fg, bg)
    vim.cmd("highlight " .. group .. " guifg=" .. fg .. " guibg=" .. bg)
end

bg = "#3c3836"
fg = "#ebdbb2"
red = "#fb4934"
yellow = "#fabd2f"
blue = "#83a598"

highlight("Name", fg, bg)
highlight("FileType", yellow, bg)
highlight("Active", blue, bg)

local o = vim.o


local filter = vim.tbl_filter
local fn = vim.fn
local map = vim.tbl_map


local function get_bufers()
    local str = ""
    local buffers = filter(
        function(buffer) return buffer.listed == 1 and buffer.hidden == 1 end,
        fn.getbufinfo()
    )
    for _, buffer in ipairs(buffers) do
        str = str .. " " .. buffer.name:match("^.+/(.+)$")
    end
    return str
end


o.statusline = "%#Active#%{luaeval('get_name()')}%#Name# %m %r %h"
    -- .. " %{luaeval('get_bufers()')} "
    .. "  %=%#plugNumber#%l:%c %y"
