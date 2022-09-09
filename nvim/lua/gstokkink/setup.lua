local g = vim.g

-- Set global leader to space and local leader to \
g.mapleader = ' '
g.maplocalleader = '\\'

-- Disable some builtin vim plugins
local disabled_builtins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'matchparen',
  'tar',
  'tarPlugin',
  'rrhelper',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, builtin in pairs(disabled_builtins) do
  g['loaded_' .. builtin] = 1
end
