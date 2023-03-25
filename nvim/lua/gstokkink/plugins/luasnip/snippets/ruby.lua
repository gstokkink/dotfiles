local luasnip = require('luasnip')
local s = luasnip.snippet
local t = luasnip.text_node

local snippets = {
  s({
    trig = 'kpry',
    name = '::Kernel.binding.pry',
    dscr = 'Inserts binding.pry from Kernel namespace',
  }, t('::Kernel.binding.pry')),
}

return snippets
