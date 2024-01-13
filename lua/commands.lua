local qr = [[
  (frontmatter) @front
]]

local function run()
end

vim.api.nvim_create_user_command('Props', run, { nargs = 0 })

vim.api.nvim_create_user_command('Cln', "%s/class/className/g", { nargs = 0 })

vim.api.nvim_create_user_command('RldCmd', "source ~/.config/nvim/lua/commands.lua", { nargs = 0 })

vim.api.nvim_create_user_command('Astro', function() require('langs.astro')() end, { nargs = 0 })
