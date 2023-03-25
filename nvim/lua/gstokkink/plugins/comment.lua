return {
  'numToStr/Comment.nvim',
  dependencies = {
    { 'JoosepAlviste/nvim-ts-context-commentstring' }, -- Necessary for detection of comments in jsx/tsx files
  },
  opts = {
    ignore = '^$',
  },
  config = function(_, opts)
    local default_opts = {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }

    opts = vim.tbl_deep_extend('force', default_opts, opts)

    require('Comment').setup(opts)
  end,
}
