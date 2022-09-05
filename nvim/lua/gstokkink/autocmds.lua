local opt = vim.opt

local augroup = vim.api.nvim_create_augroup('gstokkink', { clear = true })

local function set_cursor_line()
  opt.cursorline = true
end

local function clear_cursor_line()
  opt.cursorline = false
end

vim.api.nvim_create_autocmd({ 'FocusGained', 'WinEnter' }, {
  group = augroup,
  pattern = { '*' },
  callback = set_cursor_line,
})

vim.api.nvim_create_autocmd({ 'FocusLost', 'WinLeave' }, {
  group = augroup,
  pattern = { '*' },
  callback = clear_cursor_line,
})
