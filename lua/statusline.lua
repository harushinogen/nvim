local name = function() return vim.api.nvim_buf_get_name(0) end
local cwd = vim.fn.getcwd

local function get_name()
    local escaped_cwd = string.gsub(cwd(), "([%^%$%(%)%%%.%[%]%*%+%-%?%)])", "%%%1")
    local filename = string.gsub(name(), escaped_cwd, ""):sub(2)

    if (filename == "" or filename == nil) then
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

function GetDiagCount(key)
    local symbol = {
        ERROR = "│  ",
        WARN = " ",
        INFO = " ",
        HINT = " "
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
                vim.b.filename = get_name()
            end
        )
    end
})

function GetFileType()
    local extension = get_name():gsub("^.*%.(%w*)$", "%1")
    local filename = get_name()
    local icon, color = require 'nvim-web-devicons'.get_icon_color(filename, extension)
    local filetype = vim.filetype.match({ buf = 0 })
    if (color == nil) then
        return filetype == nil and "" or filetype
    else
        vim.cmd("hi TypeIcon guifg=" .. color .. " gui=bold")
        if (filetype == nil) then
            filetype = ""
        end
        return "│ " .. icon .. " " .. filetype
    end
end

function GetPackageStatus()
  local package_info = require("package-info")
  return package_info.get_status()
end

o.statusline = [[%#conditional#│ %{get(b:, "filename", "")}%m%r%h ]]
    .. "%#StatusGitBranch#"
    .. [[%{get(b:, "git_status", "")}]]
    .. "%#DiagnosticSignError# "
    .. [[%{luaeval('GetDiagCount("ERROR")')} ]]
    .. "%#DiagnosticSignWarn#"
    .. [[%{luaeval('GetDiagCount("WARN")')} ]]
    .. "%#DiagnosticSignInfo#"
    .. [[%{luaeval('GetDiagCount("INFO")')} ]]
    .. "%#DiagnosticSignHint#"
    .. [[%{luaeval('GetDiagCount("HINT")')}]]
    .. [[%{luaeval('GetPackageStatus()')}]]
    .. "%=%#TypeIcon#%{luaeval('GetFileType()')}"
    .. " %#string#│ %l:%c "
