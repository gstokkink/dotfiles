-- Surround functionality
return {
  'kylechui/nvim-surround',
  version = '*',
  event = 'VeryLazy',
  opts = {
    keymaps = {
      insert = '<C-g>z',
      insert_line = 'gC-ggZ',
      normal = 'gz',
      normal_cur = 'gZ',
      normal_line = 'gzz',
      normal_cur_line = 'gZZ',
      visual = 'gz',
      visual_line = 'gZ',
      delete = 'gzd',
      change = 'gzr',
    },
  },
}
