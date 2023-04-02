return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { 'dpayne/CodeGPT.nvim' },
  },
  opts = function()
    local codegpt = require('codegpt')

    return {
      options = {
        icons_enabled = false,
        theme = 'auto',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { codegpt.get_status, 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}
