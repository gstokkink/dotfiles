return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'j-hui/fidget.nvim', -- For language server progress information
      config = true,
    },
    { 'hrsh7th/cmp-nvim-lsp' }, -- Autocompletion from language server
    { 'folke/neodev.nvim' }, -- Useful for Lua language server
    { 'b0o/schemastore.nvim' }, -- Useful for JSON and YAML language servers
    { 'jose-elias-alvarez/typescript.nvim' }, -- useful for TypeScript language server
  },
  config = function()
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
      local map = require('gstokkink.utils').map

      local default_options = { noremap = true, silent = true, buffer = bufnr }

      map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', default_options)
      map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', default_options)
      map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', default_options)
      map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', default_options)
      map('n', '<Leader>k', ':lua vim.lsp.buf.signature_help()<CR>', default_options)
      map('n', '<Leader>d', ':lua vim.lsp.buf.type_definition()<CR>', default_options)
      map('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>', default_options)
      map('n', '<Leader>ca', ':lua vim.lsp.buf.code_action()<CR>', default_options)
      map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', default_options)
      -- Disable formatting for language servers, we use the 'formatter' plugin instead
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      -- tagfunc
      if client.server_capabilities.definitionProvider then
        api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
      end
    end

    -- Configure floats
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Setup language servers
    require('gstokkink.plugins.lspconfig.servers').setup({
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
  end,
}
