return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'hrsh7th/cmp-buffer' }, -- Autocompletion from current buffer
    { 'hrsh7th/cmp-cmdline' }, -- Autocompletion from command line
    { 'hrsh7th/cmp-nvim-lsp' }, -- Autocompletion from language server
    { 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- Display function signature
    { 'hrsh7th/cmp-path' }, -- Autocompletion from path
    {
      'saadparwaiz1/cmp_luasnip', -- Autocompletion from LuaSnip
      dependencies = {
        { 'l3mOn4d3/luasnip' },
      },
    },
    {
      'zbirenbaum/copilot-cmp',
      dependencies = {
        { 'zbirenbaum/copilot.lua' },
      },
      config = function(_, opts)
        local copilot_cmp = require('copilot_cmp')

        copilot_cmp.setup(opts)

        -- attach cmp source whenever copilot attaches
        -- fixes lazy-loading issues with the copilot cmp source
        require('gstokkink.utils').on_attach(function(client)
          if client.name == 'copilot' then
            copilot_cmp._on_insert_enter()
          end
        end)
      end,
    },
  },
  opts = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local function has_words_before()
      if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
        return false
      end

      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
    end

    return {
      completion = {
        autocomplete = false,
        completeopt = 'menu,menuone,noinsert',
      },
      formatting = {
        fields = { 'menu', 'abbr', 'kind' },
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
        ['<C-e>'] = cmp.mapping.abort(), -- Cancel autocompleting
        ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-j>'] = cmp.mapping(function(fallback) -- Jump to next placeholder
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function(fallback) -- Jump to previous placeholder
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = 'copilot' },
        { name = 'nvim_lsp', keyword_length = 2 },
        { name = 'nvim_lsp_signature_help', keyword_length = 2 },
        { name = 'luasnip', keyword_length = 2 },
      }, {
        { name = 'buffer', keyword_length = 3 },
      }),
      sorting = {
        priority_weight = 2,
        comparators = {
          require('copilot_cmp.comparators').prioritize,

          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    }
  end,
  config = function(_, opts)
    local cmp = require('cmp')

    cmp.setup(opts)

    -- Use buffer source for `/`
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':'
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
}
