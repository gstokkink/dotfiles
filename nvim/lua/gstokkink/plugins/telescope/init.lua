return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-telescope/telescope-live-grep-args.nvim' }, -- Allows manipulating rg arguments
    {
      'nvim-telescope/telescope-fzf-native.nvim', -- Use native FZF as sorter as it's a lot faster
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
  },
  opts = function()
    local actions = require('telescope.actions')
    local custom_actions = require('gstokkink.plugins.telescope.custom_actions')

    return {
      defaults = {
        file_ignore_patterns = {
          'brakeman.ignore',
          '^vendor/',
        },
        mappings = {
          i = {
            ['<ESC>'] = actions.close,
            ['<CR>'] = custom_actions.multi_selection_open,
            ['<C-x>'] = custom_actions.multi_selection_open_horizontal,
            ['<C-v>'] = custom_actions.multi_selection_open_vertical,
            ['<C-t>'] = custom_actions.multi_selection_open_tab,
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
              ['<C-o>'] = custom_actions.insert_ignore_list,
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require('telescope')

    telescope.setup(opts)

    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')
  end,
}
