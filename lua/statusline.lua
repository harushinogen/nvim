name = function() return vim.api.nvim_buf_get_name(0) end
cwd = vim.fn.getcwd

function get_name()
    local escaped_cwd = cwd():gsub("([%^%$%(%)%%%.%[%]%*%+%-%?%)])", "%%%1")
    local filename = name():gsub(escaped_cwd, ""):sub(2)
    if (filename == "") then
        return "[No Name]"
    else
        return filename
    end
end

local o = vim.o


local filter = vim.tbl_filter
local fn = vim.fn
local map = vim.tbl_map

local d = vim.diagnostic

function get_diag_count(key)
    local symbol = {
        ERROR = "│  ",
        WARN = " ",
        INFO = " ",
        HINT = " "
    }
    if (table.getn(vim.lsp.get_active_clients()) == 0) then
        return ""
    else
        return symbol[key] ..
            tostring(table.getn(d.get(0, { severity = d.severity[key] })))
    end
end

function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', '')
    return s
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'BufWritePost' }, {
    pattern = '*',
    callback = function()
        vim.schedule(
            function()
                vim.b.git_status = os.capture("git branch 2>/dev/null | grep '*'", false):gsub("%* ", "│  ")
            end
        )
    end
})

function get_file_type()
    local extension = get_name():gsub("^.*%.(%w*)$", "%1")
    local filename = get_name()
    local icon, color = require 'nvim-web-devicons'.get_icon_color(filename, extension)
    local filetype = vim.filetype.match({ buf = 0 })
    if (color == nil) then
        return filetype == nil and "" or filetype
    else
        vim.cmd("hi TypeIcon guifg=" .. color .. " gui=bold")
        return "│ " .. icon .. " " .. filetype
    end
end

o.statusline = "%#StatusFileName#│ %{luaeval('get_name()')}%m%r%h "
    .. "%#StatusGitBranch#"
    .. [[%{get(b:, "git_status", "")}]]
    .. "%#DiagnosticSignError# "
    .. [[%{luaeval('get_diag_count("ERROR")')} ]]
    .. "%#DiagnosticSignWarn#"
    .. [[%{luaeval('get_diag_count("WARN")')} ]]
    .. "%#DiagnosticSignInfo#"
    .. [[%{luaeval('get_diag_count("INFO")')} ]]
    .. "%#DiagnosticSignHint#"
    .. [[%{luaeval('get_diag_count("HINT")')}]]
    .. "%=%#TypeIcon#%{luaeval('get_file_type()')}"
    .. " %#plugNumber#│ %l:%c "
