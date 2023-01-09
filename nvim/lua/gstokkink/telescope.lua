local M = {}

local api = vim.api
local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local transform_mod = require('telescope.actions.mt').transform_mod

-- Attempt to fix multiselect without having to rely on the quickfix list
-- Taken from https://github.com/nvim-telescope/telescope.nvim/issues/1048
local function stop_insert(callback)
  return function(prompt_bufnr)
    vim.cmd.stopinsert()

    vim.schedule(function()
      callback(prompt_bufnr)
    end)
  end
end

local function multiopen(prompt_bufnr, method)
  local edit_file_cmd_map = {
    vertical = 'vsplit',
    horizontal = 'split',
    tab = 'tabedit',
    default = 'edit',
  }

  local edit_buf_cmd_map = {
    vertical = 'vert sbuffer',
    horizontal = 'sbuffer',
    tab = 'tab sbuffer',
    default = 'buffer',
  }

  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi_selection = picker:get_multi_selection()

  if #multi_selection > 1 then
    require('telescope.pickers').on_close_prompt(prompt_bufnr)
    pcall(api.nvim_set_current_win, picker.original_win_id)

    for i, entry in ipairs(multi_selection) do
      local filename, row, col

      if entry.path or entry.filename then
        filename = entry.path or entry.filename

        row = entry.row or entry.lnum
        col = vim.F.if_nil(entry.col, 1)
      elseif not entry.bufnr then
        local value = entry.value

        if not value then
          return
        end

        if type(value) == 'table' then
          value = entry.display
        end

        local sections = vim.split(value, ':')

        filename = sections[1]
        row = tonumber(sections[2])
        col = tonumber(sections[3])
      end

      local entry_bufnr = entry.bufnr

      if entry_bufnr then
        if not api.nvim_buf_get_option(entry_bufnr, 'buflisted') then
          api.nvim_buf_set_option(entry_bufnr, 'buflisted', true)
        end

        local command = i == 1 and 'buffer' or edit_buf_cmd_map[method]
        pcall(vim.cmd, string.format('%s %s', command, api.nvim_buf_get_name(entry_bufnr)))
      else
        local command = i == 1 and 'edit' or edit_file_cmd_map[method]

        if api.nvim_buf_get_name(0) ~= filename or command ~= 'edit' then
          filename = require('plenary.path'):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())

          pcall(vim.cmd, string.format('%s %s', command, filename))
        end
      end

      if row and col then
        pcall(api.nvim_win_set_cursor, 0, { row, col - 1 })
      end
    end
  else
    actions['select_' .. method](prompt_bufnr)
  end
end

local custom_actions = transform_mod({
  multi_selection_open_vertical = function(prompt_bufnr)
    multiopen(prompt_bufnr, 'vertical')
  end,
  multi_selection_open_horizontal = function(prompt_bufnr)
    multiopen(prompt_bufnr, 'horizontal')
  end,
  multi_selection_open_tab = function(prompt_bufnr)
    multiopen(prompt_bufnr, 'tab')
  end,
  multi_selection_open = function(prompt_bufnr)
    multiopen(prompt_bufnr, 'default')
  end,
})

local insert_ignore_list = function(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local prompt = picker:_get_prompt()

  prompt = prompt .. "-g '!{db/*,lib/tasks/*}'"

  picker:set_prompt(prompt)
end

function M.setup()
  require('telescope').setup({
    defaults = {
      file_ignore_patterns = {
        'brakeman.ignore',
        '^vendor/',
      },
      mappings = {
        i = {
          ['<ESC>'] = actions.close,
          ['<CR>'] = stop_insert(custom_actions.multi_selection_open),
          ['<C-x>'] = stop_insert(custom_actions.multi_selection_open_horizontal),
          ['<C-v>'] = stop_insert(custom_actions.multi_selection_open_vertical),
          ['<C-t>'] = stop_insert(custom_actions.multi_selection_open_tab),
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-p>'] = actions.cycle_history_prev,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          ['<C-w>'] = actions.send_to_qflist + actions.open_qflist,
        },
      },
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true,
        default_mappings = {},
        mappings = {
          i = {
            ['<C-l>'] = require('telescope-live-grep-args.actions').quote_prompt(),
            ['<C-o>'] = insert_ignore_list,
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
          },
        },
      },
    },
  })

  telescope.load_extension('fzf')
  telescope.load_extension('live_grep_args')
end

-- Some helper functions to facilitate live grepping
-- Taken from https://github.com/nvim-telescope/telescope-live-grep-args.nvim/issues/14
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

  telescope.extensions.live_grep_args.live_grep_args(opts)
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
