return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    {
      'windwp/nvim-autopairs', -- Autopairs
      opts = {
        check_ts = true,
      },
    },
    {
      'lukas-reineke/indent-blankline.nvim', -- Show indent lines
      opts = {
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter = true,
      },
    },
    { 'rrethy/nvim-treesitter-endwise' }, -- Autoclosing blocks etc. for Ruby
    { 'JoosepAlviste/nvim-ts-context-commentstring' }, -- Autodetecting comments for nested languages
  },
  build = ':TSUpdate',
  opts = {
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
      'tsx',
      'typescript',
      'yaml',
    },
    auto_install = true,
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        ruby = {
          __default = '# %s',
          __multiline = '=begin %s =end',
        },
      },
    },
    endwise = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}