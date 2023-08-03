local luasnip = require('luasnip')
local s = luasnip.snippet
local t = luasnip.text_node

local snippets = {
  s({
    trig = 'bb',
    name = '::Kernel.binding.b',
    dscr = 'Inserts binding.b from Kernel namespace',
  }, t('::Kernel.binding.b')),
  s({
    trig = 'bi',
    name = '::Kernel.binding.irb',
    dscr = 'Inserts binding.irb from Kernel namespace',
  }, t('::Kernel.binding.irb')),
}

return snippets
