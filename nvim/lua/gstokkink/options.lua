local opt = vim.opt

-- Autoread open buffers
opt.autoread = true

-- Autocompletion
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Confirm to save changes before exiting modified buffer
opt.confirm = true

-- Use cursor line
opt.cursorline = true

-- Use spaces instead of tabs
opt.expandtab = true

-- Do not continue comments after 'o' or 'O'
opt.formatoptions:append({ o = false })

-- Bling cursor
opt.guicursor =
  'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- Use incremental search
opt.incsearch = true

opt.indentkeys:remove('.')

-- Use global status bar
opt.laststatus = 3

-- Use special symbols for whitespace
opt.list = true
opt.listchars:append('tab:»·')
opt.listchars:append('trail:·')

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

-- Do not show intro or match messages
opt.shortmess:append({ I = true, c = true })

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

-- Write undo to a file
opt.undofile = true

-- Maximum amount of undo's
opt.undolevels = 10000
