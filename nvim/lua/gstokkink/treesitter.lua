require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  ignore_install = { 'elm', 'embedded_template', 'fortran', 'hack', 'haskell', 'org', 'phpdoc' },
  auto_install = true,
  endwise = {
    enable = true
  },
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  rainbow = {
    enable = true
  }
})
