-- nvim_lsp object
require("mason").setup()
require("mason-lspconfig").setup()

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'html', 'intelephense', 'vala_ls', 'dartls', 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'cssls',
  'svelte', "lua_ls", 'prismals' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = function (client, bufnr)
    --   require 'lsp_signature'.on_attach();
    -- end,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 1000,
    }
  }
end


-- luasnip setup
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

-- disable virtual text
-- vim.diagnostic.config({ virtual_text = false })


-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format(),
  },
}

-- Autocompletion when typing command
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Autocompletion when searching
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'buffer' }
  })
})

-- Null ls
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
  },
})

-- null_ls.setup({
--   on_attach = function(client, bufnr)
--     if client.resolved_capabilities.document_formatting then
--       vim.cmd("nnoremap <silent><buffer> <Leader>== :lua vim.lsp.buf.formatting({ async = false })<CR>")
--       -- format on save
--       vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting({ async = false })")
--     end
--
--     if client.resolved_capabilities.document_range_formatting then
--       vim.cmd("xnoremap <silent><buffer> <Leader>== :lua vim.lsp.buf.range_formatting({})<CR>")
--     end
--   end,
-- })
