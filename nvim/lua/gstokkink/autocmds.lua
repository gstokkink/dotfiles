local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

local function clear_cursor_line()
  opt.cursorline = false
end

local function reset_cursor_line()
  opt.cursorline = true
end

local function clear_background()
  cmd.highlight('Normal guibg=#e3e3e3')
end

local function reset_background()
  cmd.highlight('Normal guibg=#fafafa')
end

local group = api.nvim_create_augroup('gstokkink', { clear = true })

api.nvim_create_autocmd({ 'FocusGained', 'WinEnter' }, {
  group = group,
  pattern = { '*' },
  callback = reset_cursor_line,
})

api.nvim_create_autocmd({ 'FocusLost', 'WinLeave' }, {
  group = group,
  pattern = { '*' },
  callback = clear_cursor_line,
})

api.nvim_create_autocmd({ 'FocusGained' }, {
  group = group,
  pattern = { '*' },
  callback = reset_background,
})

api.nvim_create_autocmd({ 'FocusLost' }, {
  group = group,
  pattern = { '*' },
  callback = clear_background,
})
