local api = vim.api

-- Set theme
vim.cmd.colorscheme('onehalflight')

-- Configure window dimming to work correctly with tmux
api.nvim_exec(
  [[
highlight EndOfBuffer ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
highlight LineNr ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
highlight Normal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
highlight NormalNC ctermfg=NONE ctermbg=NONE guifg=#b3b3b3 guibg=#e3e3e3
]],
  false
)

-- Fix float backgrounds due to the window dimming
api.nvim_set_hl(0, 'FloatBorder', { bg = '#fafafa' })
api.nvim_set_hl(0, 'NormalFloat', { bg = '#fafafa', fg = '#383a42' })
api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#fafafa', fg = '#383a42' })
api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = '#fafafa' })
api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = '#fafafa' })
api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = '#fafafa' })
