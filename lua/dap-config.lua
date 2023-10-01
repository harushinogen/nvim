local function split(s, sep)
    local fields = {}
    
    local sep = sep or " "
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)
    return fields
end

local dap = require("dap")
require("dapui").setup()
require('mason-nvim-dap').setup({
  handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end,
    codelldb = function(config)
      dap.configurations.c = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = function()
            local args = vim.fn.input('Args for the executable: ', "" , 'file')
            return split(args, " ")
          end,

          runInTerminal = true,
        }
      }
    end,
  }
})

dap.adapters.executable = {
  type = 'executable',
  command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
  name = 'lldb1',
  host = '127.0.0.1',
  port = 13000
}

dap.adapters.codelldb = {
  name = "codelldb server",
  type = 'server',
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
    args = { "--port", "${port}" },
  }
}
