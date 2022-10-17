local M = {}
local api = vim.api
local lsp = vim.lsp

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.lsp.omnifunc')

  -- Use language server as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.lsp.formatexpr()')

  -- Configure key mappings for language server
  require('gstokkink.mappings').lsp_setup(bufnr)

  -- Disable formatting for language server, we use the 'formatter' plugin instead
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- tagfunc
  if client.server_capabilities.definitionProvider then
    api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
  end
end

-- Configure floats

function M.setup()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Setup language servers
  require('gstokkink.lsp.servers').setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })

  local handler_configuration = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
  }

  -- Hover configuration
  lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, handler_configuration)

  -- Signature help configuration
  lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, handler_configuration)
end

return M
