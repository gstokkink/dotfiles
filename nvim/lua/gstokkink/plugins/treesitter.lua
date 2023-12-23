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
      main = 'ibl',
      config = true
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
      'toml',
      'tsx',
      'typescript',
      'yaml',
    },
    auto_install = true,
    endwise = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    }
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    require('ts_context_commentstring').setup {
      enable = true,
      enable_autocmd = false,
      config = {
        ruby = {
          __default = '# %s',
          __multiline = '=begin %s =end',
        },
      },
    }
  end,
}
