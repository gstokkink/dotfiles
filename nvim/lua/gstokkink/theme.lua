local api = vim.api
local g = vim.g

-- Configure colorscheme
g.background = 'dark'
g.nord_italic = false
api.nvim_command('colorscheme nord')

-- Configure window dimming
api.nvim_exec(
  [[
highlight Normal ctermfg=NONE ctermbg=NONE guifg=#d8dde8 guibg=NONE
highlight NormalNC ctermfg=NONE ctermbg=NONE guifg=#9e9e9e guibg=#303030
]],
  false
)

-- Fix float backgrounds due to the window dimming
api.nvim_set_hl(0, 'FloatBorder', { bg = '#2e333f' })
api.nvim_set_hl(0, 'NormalFloat', { bg = '#2e333f', fg = '#d8dde8' })
api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#2e333f', fg = '#d8dde8' })
api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = '#2e333f' })
api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = '#2e333f' })
api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = '#2e333f' })
