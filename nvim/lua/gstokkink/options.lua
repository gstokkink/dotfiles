local opt = vim.opt

-- Autoread open buffers
opt.autoread = true

-- Autocompletion
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Use cursor line
opt.cursorline = true

-- Use spaces instead of tabs
opt.expandtab = true

-- Allow hidden buffers with unwritten changes
opt.hidden = true

-- Use special symbols for whitespace
opt.list = true
opt.listchars:append('tab:»·')
opt.listchars:append('trail:·')

-- Use incremental search
opt.incsearch = true

-- Use global status bar
opt.laststatus = 3

-- Use grep regexps
opt.magic = true

-- Fully enable mouse support for positioning
opt.mouse = 'a'

-- Show line numbers
opt.number = true

-- Use 2 spaces to indent
opt.shiftwidth = 2

-- Prevent double mode display
opt.showmode = false

-- Always show sign column
opt.signcolumn = 'yes'

-- Split right for horizontal splits
opt.splitright = true

-- Split below for vertical splits
opt.splitbelow = true

-- Use 2 spaces for tabs
opt.tabstop = 2

-- Use 24 bit colors
opt.termguicolors = true
