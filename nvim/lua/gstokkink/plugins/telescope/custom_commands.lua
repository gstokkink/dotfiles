-- Some helper functions to facilitate live grepping
-- Taken from https://github.com/nvim-telescope/telescope-live-grep-args.nvim/issues/14
local M = {}

local api = vim.api

local function escape_rg_text(text)
  text = text:gsub('%(', '\\%(')
  text = text:gsub('%)', '\\%)')
  text = text:gsub('%[', '\\%[')
  text = text:gsub('%]', '\\%]')
  text = text:gsub('%{', '\\%{')
  text = text:gsub('%}', '\\%}')
  text = text:gsub('"', '\\"')
  text = text:gsub('-', '\\-')
  text = text:gsub('+', '\\-')

  return text
end

local function get_text(mode)
  local current_line = api.nvim_get_current_line()
  local start_pos = 0
  local end_pos = 0

  if mode == 'v' then
    start_pos = api.nvim_buf_get_mark(0, '<')
    end_pos = api.nvim_buf_get_mark(0, '>')
  elseif mode == 'n' then
    start_pos = api.nvim_buf_get_mark(0, '[')
    end_pos = api.nvim_buf_get_mark(0, ']')
  end

  return string.sub(current_line, start_pos[2] + 1, end_pos[2] + 1)
end

local function live_grep_args(opts, mode)
  opts = opts or {}

  if not opts.default_text then
    if mode then
      opts.default_text = '"' .. escape_rg_text(get_text(mode)) .. '"'
    else
      opts.default_text = ''
    end
  end

  require('telescope').extensions.live_grep_args.live_grep_args(opts)
end

function M.live_grep()
  live_grep_args()
end

function M.live_grep_cword()
  live_grep_args({ default_text = vim.fn.expand('<cword>') })
end

function M.live_grep_selection()
  live_grep_args({}, 'v')
end

return M
