-- Git stuff
return {
  'dinhhuy258/git.nvim',
  opts = {
    target_branch = 'staging',
    default_mappings = false,
    keymaps = {
      -- Open blame window
      blame = '<Leader>gb',
      -- Close blame window
      quit_blame = 'q',
      -- Open blame commit
      blame_commit = '<CR>',
      -- Open file/folder in git repository
      browse = '<Leader>gB',
    },
  },
}
