local api = vim.api
local g = vim.g

-- Disable old vi compatibility
api.nvim_command('set nocompatible')

-- Set global leader to space and local leader to \
g.mapleader = ' '
g.maplocalleader = '\\'

-- Disable netrw
g.loaded_netrwPlugin = 1

-- Load modules
require('gstokkink.options')
require('gstokkink.mappings').setup_common()
require('gstokkink.plugins')
require('gstokkink.lsp')

-- Test config
api.nvim_exec(
  [[
  let test#strategy = 'vimux'
  let g:test#echo_command = 0
  let g:test#preserve_screen = 1
]],
  false
)

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
