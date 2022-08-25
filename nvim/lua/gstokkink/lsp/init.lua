local M = {}

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Use language server as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  -- Configure key mappings for language server
  require('gstokkink.mappings').lsp_setup(bufnr)

  -- Disable formatting for language server, we use the 'formatter' plugin instead
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- tagfunc
  if client.server_capabilities.definitionProvider then
    vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Add completion support for the language servers
local server_options = {
  capabilities = capabilities,
  on_attach = M.on_attach,
  flags = {
    debounce_text_changes = 150,
  },
}

function M.setup()
  -- Setup language servers
  require('gstokkink.lsp.servers').setup(server_options)
end

return M
