-- Test runner
return {
  'vim-test/vim-test',
  config = function()
    vim.api.nvim_exec(
      [[
        let test#strategy = 'neovim'
        let g:test#neovim#start_normal = 1
      ]],
      false
    )
  end,
}
