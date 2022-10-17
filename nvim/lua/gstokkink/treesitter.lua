require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'comment',
    'css',
    'dockerfile',
    'gitignore',
    'graphql',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'ruby',
    'scss',
    'sql',
    'toml',
    'typescript',
    'yaml',
  },
  auto_install = true,
  endwise = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
  },
})
