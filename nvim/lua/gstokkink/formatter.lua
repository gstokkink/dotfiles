local M = {}
local api = vim.api
local util = require('formatter.util')

local function auto_format()
  local view = vim.fn.winsaveview()

  -- :FormatWrite is supplied by the 'formatter' plugin
  api.nvim_command(':FormatWrite')

  vim.fn.winrestview(view)
end

function M.setup()
  require('formatter').setup({
    logging = false,
    log_level = vim.log.levels.WARN,

    filetype = {
      css = {
        require('formatter.filetypes.css').prettierd,
      },
      graphql = {
        require('formatter.filetypes.graphql').prettierd,
      },
      html = {
        require('formatter.filetypes.html').prettierd,
      },
      javascript = {
        require('formatter.filetypes.javascript').prettierd,
      },
      json = {
        require('formatter.filetypes.json').prettierd,
      },
      lua = {
        require('formatter.filetypes.lua').stylua,
      },
      ruby = {
        function()
          return {
            exe = 'bundle exec rubocop',
            args = {
              '--fix-layout',
              '--stdin',
              util.escape_path(util.get_current_buffer_file_name()),
              '--format',
              'files',
              '|',
              "awk 'f; /^====================$/{f=1}'",
            },
            stdin = true,
          }
        end,
      },
      sh = {
        require('formatter.filetypes.sh').shfmt,
      },
      toml = {
        require('formatter.filetypes.toml').taplo,
      },
      typescript = {
        require('formatter.filetypes.typescript').prettierd,
      },
      ['*'] = {
        require('formatter.filetypes.any').remove_trailing_whitespace,
      },
    },
  })

  -- Enable autoformatting
  local auto_format_group = api.nvim_create_augroup('AutoFormat', { clear = true })

  api.nvim_create_autocmd('BufWritePost *', {
    group = auto_format_group,
    callback = function()
      vim.schedule(auto_format)
    end,
  })
end

return M
