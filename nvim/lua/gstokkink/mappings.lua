local map = require('gstokkink.utils').map

local default_options = { noremap = true }

-- Quick save
map('n', '<Leader>a', '<CMD>w<CR>', default_options)

-- Quick exit
map('n', '<Leader>q', '<CMD>q<CR>', default_options)
map('n', '<Leader>Q', '<CMD>xa<CR>', default_options)

-- Easier creation of splits and tabs
map('n', '<Leader>v', '<CMD>vsp<CR>', default_options)
map('n', '<Leader>x', '<CMD>sp<CR>', default_options)
map('n', '<Leader>n', '<CMD>tabnew<CR>', default_options)

-- Go to tab by number
map('n', '<Leader>1', '1gt', default_options)
map('n', '<Leader>2', '2gt', default_options)
map('n', '<Leader>3', '3gt', default_options)
map('n', '<Leader>4', '4gt', default_options)
map('n', '<Leader>5', '5gt', default_options)
map('n', '<Leader>6', '6gt', default_options)
map('n', '<Leader>7', '7gt', default_options)
map('n', '<Leader>8', '8gt', default_options)
map('n', '<Leader>9', '9gt', default_options)
map('n', '<Leader>0', ':tablast', default_options)

-- Copy current location
map('n', '<Leader>l', "<CMD>let @* = expand('%')<CR>", default_options)
map('n', '<Leader>L', "<CMD>let @* = join([expand('%'), line('.')], ':')<CR>", default_options)

-- Paste over selected text
map('v', 'p', '"_dP', default_options)

-- Reselect pasted text
map('n', 'gp', "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true })

-- Better indentation
map('v', '<', '<gv', default_options)
map('v', '>', '>gv', default_options)

-- Close quickfix window
map('n', '<Leader>w', '<CMD>cclose<CR>', default_options)

-- Make search direction consistent
map('n', 'n', '/<CR>', { silent = true })
map('n', 'N', '?<CR>', { silent = true })

-- Toggle search highlight
map('n', '<Leader>/', '<CMD>noh<CR>', default_options)

-- PLUGIN SPECIFIC MAPPINGS

-- File find with hidden files included by default, except the git repository
map(
  'n',
  '<C-f>',
  "<CMD>lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })<CR>",
  default_options
)

-- Live grep with prompt
map(
  'n',
  '<Leader>f',
  "<CMD>lua require('gstokkink.plugins.telescope.custom_commands').live_grep()<CR>",
  default_options
)

-- Live grep with current word
map(
  'n',
  '<Leader>]',
  "<CMD>lua require('gstokkink.plugins.telescope.custom_commands').live_grep_cword()<CR>",
  default_options
)

-- Live grep with visual selection
map(
  'v',
  '<Leader>]',
  "<CMD>lua require('gstokkink.plugins.telescope.custom_commands').live_grep_selection()<CR>",
  default_options
)

-- Diagnostics
map('n', '<Leader>de', '<CMD>lua vim.diagnostic.open_float()<CR>', default_options)
map('n', '<Leader>d[', '<CMD>lua vim.diagnostic.goto_prev()<CR>', default_options)
map('n', '<Leader>d]', '<CMD>lua vim.diagnostic.goto_next()<CR>', default_options)
map('n', '<Leader>dq', '<CMD>lua vim.diagnostic.setloclist()<CR>', default_options)

-- Run current test
map('n', '<Leader>t', '<CMD>TestNearest<CR>', default_options)

-- Run whole test file
map('n', '<Leader>T', '<CMD>TestFile<CR>', default_options)

-- Zoom
map('n', '<Leader>z', '<CMD>NeoZoomToggle<CR>', default_options)

-- Open NeoTree
map(
  'n',
  '-',
  "<CMD>lua require('neo-tree.command').execute({ position = 'current', reveal = true, toggle = true })<CR>",
  default_options
)

-- Persistence mappings
map('n', '<Leader>ss', "<CMD>lua require('persistence').load()<CR>", default_options)
map('n', '<Leader>sl', "<CMD>lua require('persistence').load({ last = true })<CR>", default_options)
map('n', '<Leader>sd', "<CMD>lua require('persistence').stop()<CR>", default_options)

-- CodeGPT mappings
map('x', '<C-i>', ':Chat ', default_options)
