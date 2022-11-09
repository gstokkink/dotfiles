local api = vim.api

api.nvim_exec(
  [[
  let test#ruby#rails#executable = 'SKIP_COVERAGE=1 ./bin/rails test'
  let test#strategy = 'vimux'
  let g:test#echo_command = 0
  let g:test#preserve_screen = 1
]],
  false
)
