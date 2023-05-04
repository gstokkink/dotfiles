-- Test runner
return {
  'vim-test/vim-test',
  config = function()
    vim.api.nvim_exec(
      [[
        let test#strategy = 'vimux'
        let g:test#echo_command = 0
        let g:test#preserve_screen = 1
      ]],
      false
    )
  end,
}
