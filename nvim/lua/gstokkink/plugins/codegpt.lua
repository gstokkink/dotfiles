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
          ruby = 'Write tests using the Minitest framework. The test class should inherit from ActiveSupport::TestCase. Also use FactoryBot to create the objects under test, assume the factories themselves are already defined elsewhere. Do not stub any functionality. Do not add any comments. Use the RSpec it method to define the test cases. Use the RSpec let method to define the objects created with FactoryBot. Use single quotes for strings where possible.',
        },
      },
    }

    vim.g['codegpt_popup_border'] = {
      padding = { 1, 2 },
      style = 'none',
    }

    vim.g['codegpt_popup_window_options'] = {
      wrap = true,
      linebreak = true,
      relativenumber = true,
      number = true,
    }
  end,
}
