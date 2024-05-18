local function map(mode, shortcut, command, callback)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, callback = callback })
end

local function nmap(shortcut, command, callback)
  map("n", shortcut, command, callback)
end

return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function(_, opts)
      require("trouble").setup(opts)

      local function con(a)
        return function() require("trouble").toggle(a) end
      end

      nmap("<leader>xx", "", con())
      nmap("<leader>xw", "", con("workspace_diagnostics"))
      nmap("<leader>xd", "", con("document_diagnostics"))
      nmap("<leader>xq", "", con("quickfix"))
      nmap("<leader>xl", "", con("loclist"))
      nmap("gR", "", con("lsp_references"))
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 50,
          number = true,
          float = {
            enable = true,
          }
        },
        diagnostics = {
          enable = true,
        },
      })
      vim.opt.list = true

      nmap("<a-f>", ":NvimTreeFindFileToggle<cr>")
      nmap("<c-w>f", ":NvimTreeFocus<cr>")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      nmap("ga", "", function() harpoon:list():append() end)
      nmap("gu", "", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      -- nmap("g1", "", function()
      -- 	require("harpoon.ui").nav_file(1)
      -- end)
      -- nmap("g2", "", function()
      -- 	require("harpoon.ui").nav_file(2)
      -- end)
      -- nmap("g3", "", function()
      -- 	require("harpoon.ui").nav_file(3)
      -- end)
      -- nmap("g4", "", function()
      -- 	require("harpoon.ui").nav_file(4)
      -- end)
      -- nmap("g5", "", function()
      -- 	require("harpoon.ui").nav_file(5)
      -- end)
      -- nmap("g6", "", function()
      -- 	require("harpoon.ui").nav_file(6)
      -- end)
      -- nmap("g7", "", function()
      -- 	require("harpoon.ui").nav_file(7)
      -- end)
      -- nmap("g8", "", function()
      -- 	require("harpoon.ui").nav_file(8)
      -- end)
      -- nmap("g9", "", function()
      -- 	require("harpoon.ui").nav_file(9)
      -- end)
    end,
  },
}
