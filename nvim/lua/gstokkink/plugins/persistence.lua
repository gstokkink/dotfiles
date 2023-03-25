return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals' } },
  keys = {
    {
      '<Leader>ss',
      function()
        require('persistence').load()
      end,
      desc = 'Restore session',
    },
    {
      '<Leader>sl',
      function()
        require('persistence').load({ last = true })
      end,
      desc = 'Restore last session',
    },
    {
      '<Leader>sd',
      function()
        require('persistence').stop()
      end,
      desc = "Don't save current session",
    },
  },
}
