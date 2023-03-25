return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    { 'MunifTanjim/nui.nvim' },
  },
  cmd = 'Neotree',
  keys = {
    {
      '-',
      function()
        require('neo-tree.command').execute({ position = 'current', reveal = true, toggle = true })
      end,
      desc = 'Open current directory in NeoTree',
    },
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
  end,
  opts = {
    enable_git_status = false,
    enable_diagnostics = false,
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    window = {
      mappings = {
        ['l'] = 'open',
      },
    },
  },
}
