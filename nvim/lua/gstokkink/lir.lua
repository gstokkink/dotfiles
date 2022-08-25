local api = vim.api

local actions = require('lir.actions')
local mark_actions = require('lir.mark.actions')
local clipboard_actions = require('lir.clipboard.actions')

require('lir').setup({
  mappings = {
    ['l']  = actions.edit,
    ['<C-x>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h'] = actions.up,
    ['q'] = actions.quit,

    ['K'] = actions.mkdir,
    ['N'] = actions.newfile,
    ['R'] = actions.rename,
    ['@'] = actions.cd,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['D'] = actions.delete,
    ['W'] = actions.wipeout,

    ['J'] = function()
      mark_actions.toggle_mark()

      api.nvim_command('normal! j')
    end,

    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste
  }
})

