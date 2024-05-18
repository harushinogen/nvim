local function map(mode, shortcut, command, callback)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, callback = callback })
end

local function nmap(shortcut, command, callback)
  map("n", shortcut, command, callback)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          prompt_prefix = "> ",
          selection_caret = "> ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "descending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              mirror = false,
            },
            vertical = {
              mirror = false,
            },
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,

          file_ignore_patterns = {
            "plugged/.*",
            "backup/.*",
            "pack/.*",
            "plugin/.*",
            "autoload/.*",
            "node_modules/.*",
            "build/.*",
            ".*png",
            ".*jpg",
            ".*webp",
          },
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          color_devicons = true,
          use_less = true,
          path_display = {},
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        },
        extensions = {
          import = {
            -- Add imports to the top of the file keeping the cursor in place
            insert_at_top = true,
            -- Support additional languages
            custom_languages = {
              {
                -- The regex pattern for the import statement
                regex = [[^(?:import(?:[\"'\s]*([\w*{}\n, ]+)from\s*)?[\"'\s](.*?)[\"'\s].*)]],
                -- The Vim filetypes
                filetypes = { "typescript", "typescriptreact", "javascript", "react" },
                -- The filetypes that ripgrep supports (find these via `rg --type-list`)
                extensions = { "js", "ts" },
              },
            },
          },
        },
      })

      -- Telescope
      nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
      nmap("<leader>fg", "<cmd>Telescope live_grep<cr>")
      nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
      nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")
      nmap("<leader>/", "", function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes"))
      end)
    end,
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
  },
}
