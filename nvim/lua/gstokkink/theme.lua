-- Use light background
vim.opt.background = 'light'

-- Use One Half theme
vim.cmd.colorscheme('onehalflight')

-- Fix colors
vim.api.nvim_exec(
  [[
  highlight Normal guibg=#fafafa
  highlight NormalNC guibg=#e3e3e3
  highlight Search guibg=#e3e3e3 guifg=#e45649 gui=bold
  highlight IncSearch guibg=#e3e3e3 guifg=#e45649 gui=bold,underline
  highlight EndOfBuffer guibg=none
  highlight LineNr guibg=none
]],
  false
)
