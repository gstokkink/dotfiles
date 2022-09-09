-- Use light background
vim.opt.background = 'light'

-- Use One Half theme
vim.cmd.colorscheme('onehalflight')

-- Fix colors
vim.api.nvim_exec(
  [[
  highlight EndOfBuffer guifg=NONE guibg=NONE
  highlight LineNr guifg=NONE guibg=NONE
  highlight Normal guifg=#383a42 guibg=#fafafa
  highlight NormalNC guifg=#b3b3b3 guibg=#f3f3f3
]],
  false
)
