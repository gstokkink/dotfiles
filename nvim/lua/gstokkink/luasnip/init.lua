local api = vim.api
local luasnip = require('luasnip')
local snippets_folder = vim.fn.stdpath('config') .. '/lua/gstokkink/luasnip/snippets/'

-- Load default snippets
require('luasnip.loaders.from_vscode').lazy_load({ exclude = { 'gitcommit' } })

-- Load Rails snippets for ruby filetype
luasnip.filetype_extend('ruby', { 'rails' })

-- Load custom snippets
require('luasnip.loaders.from_lua').lazy_load({ paths = snippets_folder, override_priority = 1 })

-- Allow snippets to be edited through the LuaSnipEdit command
api.nvim_command([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
