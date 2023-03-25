return {
  'l3mOn4d3/luasnip',
  dependencies = { { 'rafamadriz/friendly-snippets' } },
  config = function()
    local luasnip = require('luasnip')
    local snippets_folder = vim.fn.stdpath('config') .. '/lua/gstokkink/plugins/luasnip/snippets/'

    -- Load default snippets
    require('luasnip.loaders.from_vscode').lazy_load({ exclude = { 'gitcommit' } })

    -- Load Rails snippets for ruby filetype
    luasnip.filetype_extend('ruby', { 'rails' })

    -- Load Ruby snippets for haml filetype
    luasnip.filetype_extend('haml', { 'ruby' })

    -- Load custom snippets
    require('luasnip.loaders.from_lua').lazy_load({ paths = snippets_folder, override_priority = 1 })

    -- Allow snippets to be edited through the LuaSnipEdit command
    vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
  end,
}
