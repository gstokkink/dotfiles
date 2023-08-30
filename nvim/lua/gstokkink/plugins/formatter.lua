return {
  'mhartington/formatter.nvim',
  opts = function()
    local util = require('formatter.util')

    return {
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
        terraform = {
          require('formatter.filetypes.terraform').terraformfmt,
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
    }
  end,
  config = function(_, opts)
    require('formatter').setup(opts)

    local api = vim.api

    local function auto_format()
      local view = vim.fn.winsaveview()

      -- :FormatWrite is supplied by the 'formatter' plugin
      api.nvim_command(':FormatWrite')

      vim.fn.winrestview(view)
    end

    -- Enable autoformatting
    api.nvim_create_autocmd('BufWritePost *', {
      callback = function()
        vim.schedule(auto_format)
      end,
    })
  end,
}
