local M = {}

-- All generic key mappings go here, for LSP specific key mappings see lsp.lua

local map = require('gstokkink.utils').map

-- Common mappings
function M.setup_common()
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

  -- Easier till end of line yanking
  map('n', 'Y', 'yg_', { noremap = true })

  -- Open lir file explorer
  map('n', '-', ":execute 'e ' .. expand('%:p:h')<CR>", default_options)

  -- File find with hidden files included by default, except the git repository
  map(
    'n',
    '<C-f>',
    ":lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })<CR>",
    default_options
  )

  -- Grep with prompt
  map('n', '<Leader>f', ":lua require('gstokkink.telescope').live_grep()<CR>", default_options)

  -- Grep with current word
  map('n', '<Leader>]', ":lua require('gstokkink.telescope').live_grep_cword()<CR>", default_options)

  -- Grep with visual selection
  map('v', '<Leader>]', ":lua require('gstokkink.telescope').live_grep_selection()<CR>", default_options)

  -- Possession mappings
  map('n', '<Leader>ss', ':PossessionSave! session<CR>', default_options)
  map('n', '<Leader>sf', ':PossessionLoad session<CR>', default_options)

  -- Diagnostic mappings
  map('n', '<Leader>de', ':lua vim.diagnostic.open_float()<CR>', default_options)
  map('n', '<Leader>d[', ':lua vim.diagnostic.goto_prev()<CR>', default_options)
  map('n', '<Leader>d]', ':lua vim.diagnostic.goto_next()<CR>', default_options)
  map('n', '<Leader>dq', ':lua vim.diagnostic.setloclist()<CR>', default_options)

  -- Toggle search highlight
  map('n', '<Leader>/', ':noh<CR>', default_options)

  -- Run current test
  map('n', '<Leader>t', ':TestNearest<CR>', default_options)

  -- Run whole test file
  map('n', '<Leader>T', ':TestFile<CR>', default_options)

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

  -- Zoom
  map('n', '<Leader>z', ':NeoZoomToggle<CR>', default_options)

  -- Close quickfix window
  map('n', '<Leader>w', ':cclose<CR>', default_options)
end

-- language server specific mappings
M.lsp_setup = function(bufnr)
  local default_options = { noremap = true, silent = true, buffer = bufnr }

  map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', default_options)
  map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', default_options)
  map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', default_options)
  map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', default_options)
  map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', default_options)
  map('n', '<Leader>D', ':lua vim.lsp.buf.type_definition()<CR>', default_options)
  map('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>', default_options)
  map('n', '<Leader>ca', ':lua vim.lsp.buf.code_action()<CR>', default_options)
  map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', default_options)
end

return M
