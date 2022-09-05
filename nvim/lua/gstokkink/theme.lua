local api = vim.api

api.nvim_exec(
  [[
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material
]],
  false
)

-- Configure window dimming
api.nvim_command('highlight Normal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE')
api.nvim_command('highlight EndOfBuffer ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE')

-- Fix float backgrounds due to the window dimming
api.nvim_set_hl(0, 'FloatBorder', { bg = '#32302f' })
api.nvim_set_hl(0, 'NormalFloat', { bg = '#32302f', fg = '#d4be98' })
api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#32302f', fg = '#d4be98' })
api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = '#32302f' })
api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = '#32302f' })
api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = '#32302f' })
