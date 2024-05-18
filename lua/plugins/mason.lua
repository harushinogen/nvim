local function map(mode, shortcut, command, callback)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, callback = callback })
end

local function nmap(shortcut, command, callback)
  map("n", shortcut, command, callback)
end

local function vmap(shortcut, command, callback)
  map("v", shortcut, command, callback)
end

return {
  {
    "williamboman/mason.nvim",
    init = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    init = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local servers = {
        "html",
        -- "jedi_language_server",
        "intelephense",
        "vala_ls",
        "dartls",
        "clangd",
        "rust_analyzer",
        "tsserver",
        "cssls",
        "gopls",
        "svelte",
        "lua_ls",
        "prismals",
        "zls",
        "eslint",
        "astro",
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          -- on_attach = function (client, bufnr)
          --   require 'lsp_signature'.on_attach();
          -- end,
          -- capabilities = capabilities,
          flags = {
            debounce_text_changes = 1000,
          },
        })
      end

      local root_files = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
      }

      lspconfig.pyright.setup({
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = function(fname)
          return util.root_pattern(unpack(root_files))(fname)
        end,
        single_file_support = true,
        settings = {
          python = {
            analysis = {
              extraPaths = {
                "~/repos/python/odoo17/odoo/",
              },
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      local lbuf = vim.lsp.buf
      local dgn = vim.diagnostic

      nmap("gD", "", lbuf.declaration)
      nmap("gd", "", lbuf.definition)
      nmap("K", "", lbuf.hover)
      nmap("<leader>gi", "", lbuf.implementation)
      nmap("<leader>wa", "", lbuf.add_workspace_folder)
      nmap("<leader>wr", "", lbuf.remove_workspace_folder)
      nmap("<leader>wl", "", function()
        print(vim.inspect(lbuf.list_workspace_folders()))
      end)
      nmap("<leader>D", "", lbuf.type_definition)
      nmap("<leader>rn", "", lbuf.rename)
      nmap("<leader>ca", "", lbuf.code_action)
      vmap("<leader>ca", "", lbuf.code_action)

      nmap("gr", ":Telescope lsp_references<cr>")
      nmap("<leader>e", "", dgn.open_float)
      nmap("[d", "", dgn.goto_prev)
      nmap("]d", "", dgn.goto_next)
      nmap("<leader>q", "", dgn.setloclist)
      nmap("<leader>==", "", lbuf.format)
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local nl = require("null-ls")
      nl.setup({
        sources = {
          nl.builtins.formatting.stylua,
          nl.builtins.formatting.blade_formatter.with({
            extra_args = { "-M", "1", "--wrap", "80", "--wrap-atts", "force-aligned", "-i", "2", "--sort-html-attributes", "code-guide"}
          }),
        },
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    branch = "stable",
    config = function()
      require("mini.completion").setup({
        auto_setup = true,
      })
      require("mini.basics").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
