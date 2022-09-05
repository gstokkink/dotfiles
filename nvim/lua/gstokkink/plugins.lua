local api = vim.api
local fn = vim.fn

-- Bootstrap packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })

  api.nvim_command('packadd packer.nvim')
end

return require('packer').startup(function(use)
  -- Let packer.nvim manage itself
  use({ 'wbthomason/packer.nvim' })

  -- Faster and improved filetype detection
  use({
    'nathom/filetype.nvim',
    config = "require('gstokkink.filetype')",
  })

  -- Theme
  use({ 'sainnhe/gruvbox-material' })

  -- Window dimming
  use({
    'levouh/tint.nvim',
    config = function()
      require('tint').setup()
    end,
  })

  -- Statusline
  use({
    'nvim-lualine/lualine.nvim',
    config = "require('gstokkink.lualine')",
  })

  -- File explorer
  use({
    'tamago324/lir.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = "require('gstokkink.lir')",
  })

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' }, -- Allows manipulating rg arguments
      {
        'nvim-telescope/telescope-fzf-native.nvim', -- Use native FZF as sorter as it's a lot faster
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
    },
    config = function()
      require('gstokkink.telescope').setup()
    end,
  })

  -- FZF

  -- Intelligently show absolute or relative line numbers
  use({
    'sitiom/nvim-numbertoggle',
    config = function()
      require('numbertoggle').setup()
    end,
  })

  -- Adding comments
  use({
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end,
  })

  -- Surround functionality
  use({
    'kylechui/nvim-surround',
    tag = '*', -- Use for stability; omit for the latest features
    config = function()
      require('nvim-surround').setup()
    end,
  })

  -- Variable text objects
  use({
    'julian/vim-textobj-variable-segment',
    requires = { { 'kana/vim-textobj-user' } },
  })

  -- Syntax highlighting
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({
        with_sync = true,
      })
    end,
    config = "require('gstokkink.treesitter')",
    requires = {
      {
        'windwp/nvim-autopairs', -- Autopairs
        config = "require('gstokkink.autopairs')",
      },
      { 'p00f/nvim-ts-rainbow' }, -- Colored parantheses
      { 'rrethy/nvim-treesitter-endwise' }, -- Autoclosing blocks etc. for Ruby
    },
  })

  -- Show indent guides
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = "require('gstokkink.indent-blankline')",
  })

  -- Integrate tmux and neovim
  use({
    'aserowy/tmux.nvim',
    config = "require('gstokkink.tmux')",
  })

  -- Allow neovim to communicate easily with tmux
  -- TODO: replace by Lua plugin
  use({ 'preservim/vimux' })

  -- Sessions
  use({
    'jedrzejboczar/possession.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = "require('gstokkink.possession')",
  })

  -- Better search and replace from the command line, and awesome case changing
  -- TODO: replace by Lua plugin
  use({ 'tpope/vim-abolish' })

  -- Repeat entire macros and complex commands
  -- TODO: replace by Lua plugin
  use({ 'tpope/vim-repeat' })

  -- Useful key bindings
  -- TODO: replace by Lua plugin
  use({ 'tpope/vim-unimpaired' })

  -- Git stuff
  use({
    'dinhhuy258/git.nvim',
    config = "require('gstokkink.git')",
  })

  -- Quicker navigation
  use({ 'ggandor/lightspeed.nvim' })

  -- Illuminate word under cursor
  use({
    'rrethy/vim-illuminate',
    config = "require('gstokkink.illuminate')",
  })

  -- Test runner
  -- TODO: replace by Lua plugin
  use({
    'vim-test/vim-test',
    config = "require('gstokkink.test')",
  })

  -- Formatting
  use({
    'mhartington/formatter.nvim',
    config = function()
      require('gstokkink.formatter').setup()
    end,
  })

  -- Language servers
  use({
    'neovim/nvim-lspconfig',
    requires = {
      {
        'j-hui/fidget.nvim', -- For language server progress information
        config = function()
          require('fidget').setup()
        end,
      },
      { 'folke/lua-dev.nvim' }, -- Useful for Lua language server
      { 'nvim-lua/plenary.nvim' },
      { 'b0o/schemastore.nvim' }, -- Useful for JSON and YAML language servers
      { 'jose-elias-alvarez/typescript.nvim' }, -- useful for TypeScript language server
    },
    config = function()
      require('gstokkink.lsp').setup()
    end,
  })

  -- Snippets
  use({
    'l3mOn4d3/luasnip',
    requires = { { 'rafamadriz/friendly-snippets' } },
    config = "require('gstokkink.luasnip')",
  })

  -- Autocompletion
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-buffer' }, -- Autocompletion from current buffer
      { 'hrsh7th/cmp-cmdline' }, -- Autocompletion from command line
      { 'hrsh7th/cmp-nvim-lsp' }, -- Autocompletion from language server
      { 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- Display function signature
      { 'hrsh7th/cmp-path' }, -- Autocompletion from path
      { 'saadparwaiz1/cmp_luasnip' }, -- Autocompletion from LuaSnip
    },
    config = "require('gstokkink.cmp')",
  })

  -- Zoom
  use({
    'nyngwang/NeoZoom.lua',
    config = "require('gstokkink.zoom')",
  })
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
