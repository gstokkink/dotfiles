return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = function()
      local function buildOverrides(flavour)
        local cp = require('catppuccin.palettes').get_palette(flavour)

        return {
          FloatBorder = { bg = cp.base },
          NormalFloat = { bg = cp.base },

          TelescopeBorder = { fg = cp.base, bg = cp.base },
          TelescopeSelectionCaret = { fg = cp.flamingo, bg = cp.surface1 },
          TelescopeMatching = { fg = cp.peach },
          TelescopeNormal = { bg = cp.base },
          TelescopeSelection = { fg = cp.text, bg = cp.surface1 },
          TelescopeMultiSelection = { fg = cp.text, bg = cp.surface2 },

          TelescopeTitle = { fg = cp.surface2, bg = cp.base },
          TelescopePreviewTitle = { fg = cp.surface2, bg = cp.base },
          TelescopePromptTitle = { fg = cp.surface2, bg = cp.base },

          TelescopePromptNormal = { fg = cp.text, bg = cp.base },
          TelescopePromptBorder = { fg = cp.base, bg = cp.base },
        }
      end

      return {
        dim_inactive = {
          enabled = true,
          shade = 'dark',
          percentage = 0,
        },
        highlight_overrides = {
          latte = buildOverrides('latte'),
          frappe = buildOverrides('frappe'),
          macchiato = buildOverrides('macchiato'),
          mocha = buildOverrides('mocha'),
        },
      }
    end,
    config = function(_, opts)
      require('catppuccin').setup(opts)

      vim.cmd.colorscheme('catppuccin-latte')
    end,
  },
}
