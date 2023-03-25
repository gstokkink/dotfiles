local map = require('gstokkink.utils').map

local default_options = { noremap = true, silent = true }

-- Quick save
map('n', '<Leader>a', ':w<CR>', { noremap = true })

-- Quick exit
map('n', '<Leader>q', ':q<CR>', { noremap = true })
map('n', '<Leader>Q', ':xa<CR>', { noremap = true })

-- Easier creation of splits and tabs
map('n', '<Leader>v', ':vsp<CR>', default_options)
map('n', '<Leader>x', ':sp<CR>', default_options)
map('n', '<Leader>n', ':tabnew<CR>', default_options)

-- Go to tab by number
map('n', '<Leader>1', '1gt', { noremap = true })
map('n', '<Leader>2', '2gt', { noremap = true })
map('n', '<Leader>3', '3gt', { noremap = true })
map('n', '<Leader>4', '4gt', { noremap = true })
map('n', '<Leader>5', '5gt', { noremap = true })
map('n', '<Leader>6', '6gt', { noremap = true })
map('n', '<Leader>7', '7gt', { noremap = true })
map('n', '<Leader>8', '8gt', { noremap = true })
map('n', '<Leader>9', '9gt', { noremap = true })
map('n', '<Leader>0', ':tablast', { noremap = true })

-- Copy current location
map('n', '<Leader>l', ":let @* = expand('%')<CR>", default_options)
map('n', '<Leader>L', ":let @* = join([expand('%'), line('.')], ':')<CR>", default_options)

-- Paste over selected text
map('v', 'p', '"_dP', default_options)

-- Reselect pasted text
map('n', 'gp', "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true })

-- Better indentation
map('v', '<', '<gv', default_options)
map('v', '>', '>gv', default_options)

-- Close quickfix window
map('n', '<Leader>w', ':cclose<CR>', default_options)

-- Make search direction consistent
map('n', 'n', '/<CR>', { silent = true })
map('n', 'N', '?<CR>', { silent = true })

-- Toggle search highlight
map('n', '<Leader>/', ':noh<CR>', default_options)

-- PLUGIN SPECIFIC MAPPINGS

-- File find with hidden files included by default, except the git repository
map(
  'n',
  '<C-f>',
  ":lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })<CR>",
  default_options
)

-- Live grep with prompt
map('n', '<Leader>f', ":lua require('gstokkink.plugins.telescope.custom_commands').live_grep()<CR>", default_options)

-- Live grep with current word
map(
  'n',
  '<Leader>]',
  ":lua require('gstokkink.plugins.telescope.custom_commands').live_grep_cword()<CR>",
  default_options
)

-- Live grep with visual selection
map(
  'v',
  '<Leader>]',
  ":lua require('gstokkink.plugins.telescope.custom_commands').live_grep_selection()<CR>",
  default_options
)

-- Diagnostics
map('n', '<Leader>de', ':lua vim.diagnostic.open_float()<CR>', default_options)
map('n', '<Leader>d[', ':lua vim.diagnostic.goto_prev()<CR>', default_options)
map('n', '<Leader>d]', ':lua vim.diagnostic.goto_next()<CR>', default_options)
map('n', '<Leader>dq', ':lua vim.diagnostic.setloclist()<CR>', default_options)

-- Run current test
map('n', '<Leader>t', ':TestNearest<CR>', default_options)

-- Run whole test file
map('n', '<Leader>T', ':TestFile<CR>', default_options)

-- Zoom
map('n', '<Leader>z', ':NeoZoomToggle<CR>', default_options)
