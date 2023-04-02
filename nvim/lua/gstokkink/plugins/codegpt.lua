-- ChatGPT integration
return {
  'dpayne/CodeGPT.nvim',
  config = function()
    require('codegpt.config')

    vim.g['codegpt_commands'] = {
      ['chat'] = {
        callback_type = 'code_popup',
      },
      ['completion'] = {
        callback_type = 'code_popup',
      },
      ['code_edit'] = {
        callback_type = 'code_popup',
      },
      ['explain'] = {
        callback_type = 'code_popup',
      },
      ['doc'] = {
        callback_type = 'code_popup',
      },
      ['opt'] = {
        callback_type = 'code_popup',
      },
      ['tests'] = {
        callback_type = 'code_popup',
        language_instructions = {
          ruby = 'Do not use RSpec.',
        },
      },
    }

    vim.g['codegpt_popup_border'] = {
      padding = { 1, 2 },
      style = 'none',
    }
  end,
}
