-- Attempt to fix multiselect without having to rely on the quickfix list
-- Taken from https://github.com/nvim-telescope/telescope.nvim/issues/1048
local M = {}

local api = vim.api
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local transform_mod = require('telescope.actions.mt').transform_mod

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

        local sections = vim.split(value, ':', {})

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

local function stop_insert(callback)
  return function(prompt_bufnr)
    vim.cmd.stopinsert()

    vim.schedule(function()
      callback(prompt_bufnr)
    end)
  end
end

M.multi_selection_open = stop_insert(custom_actions.multi_selection_open)

M.multi_selection_open_horizontal = stop_insert(custom_actions.multi_selection_open_horizontal)

M.multi_selection_open_vertical = stop_insert(custom_actions.multi_selection_open_vertical)

M.multi_selection_open_tab = stop_insert(custom_actions.multi_selection_open_tab)

local function insert_ignore_list(prompt_bufnr, ignore_list)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local prompt = picker:_get_prompt()

  prompt = prompt .. " -g '!{" .. ignore_list .. "}'"

  picker:set_prompt(prompt)
end

function M.insert_ignore_migrations_and_tasks(prompt_bufnr)
  insert_ignore_list(prompt_bufnr, 'db/*,lib/tasks/*')
end

function M.insert_ignore_tests(prompt_bufnr)
  insert_ignore_list(prompt_bufnr, 'test/*')
end

return M
