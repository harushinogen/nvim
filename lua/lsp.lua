-- nvim_lsp object
require("mason").setup()
require("mason-lspconfig").setup()

-- Add additional capabilities supported by nvim-cmp
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'html', 'intelephense', 'vala_ls', 'dartls', 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'cssls',
  'svelte', "lua_ls", 'prismals', 'zls' }
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

require('mini.completion').setup({
  auto_setup = true
})
