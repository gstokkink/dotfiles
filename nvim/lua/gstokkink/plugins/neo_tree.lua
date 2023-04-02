return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  cmd = 'Neotree',
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
