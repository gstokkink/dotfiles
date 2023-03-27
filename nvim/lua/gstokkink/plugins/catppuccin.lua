return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        dim_inactive = {
          enabled = true,
          shade = 'dark',
          percentage = 0.05,
        },
      })

      vim.cmd.colorscheme('catppuccin-latte')
    end,
  },
}
