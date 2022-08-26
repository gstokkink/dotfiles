local api = vim.api
local g = vim.g

--Disable old vi compatibility
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
  highlight ActiveWindow ctermbg=None ctermfg=None guifg=#d8dde8 guibg=#2e333f
  highlight InactiveWindow ctermbg=None ctermfg=None guifg=#9e9e9e guibg=#303030

  set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
]],
  false
)
