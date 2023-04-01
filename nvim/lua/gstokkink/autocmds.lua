-- Disable indenting on period to 'fix' annoying Treesitter indenting issue for Ruby files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ruby',
  callback = function()
    vim.opt_local.indentkeys:remove('.')
  end,
})

-- Show line numbers in Telescope preview window
vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function()
    vim.opt_local.number = true
  end,
})
