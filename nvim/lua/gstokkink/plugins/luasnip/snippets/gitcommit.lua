local luasnip = require('luasnip')
local s = luasnip.snippet
local i = luasnip.insert_node
local d = luasnip.dynamic_node
local t = luasnip.text_node
local sn = luasnip.snippet_node

local function get_branch_name()
  local git_rev = vim.fn.system('git rev-parse --abbrev-ref HEAD')

  return string.gsub(git_rev, '\n', '')
end

local function parse_metadata()
  local branch_name = get_branch_name()

  local issue_number = string.match(branch_name, '^([%d]+)-')

  if issue_number then
    local parts = {}

    for part in string.gmatch(branch_name, '([^-]+)') do
      table.insert(parts, part)
    end

    local title = table.concat(parts, ' ', 2):gsub('^%l', string.upper)

    return { issue_number = issue_number, title = title }
  end
end

local function generate_issue_template(_, _, _, postamble_prefix, include_description)
  include_description = include_description or false

  local nodes = {}
  local metadata = parse_metadata()

  if metadata then
    local jump_index = (include_description and 3) or 2

    table.insert(nodes, i(jump_index, metadata.issue_number))
    table.insert(nodes, t(' '))
    table.insert(nodes, i(1, metadata.title))
  else
    table.insert(nodes, i(1, 'Title'))
  end

  local spacer_node = t({ '', '', '' })

  if include_description then
    table.insert(nodes, spacer_node)
    table.insert(nodes, i(2, 'Description'))
  end

  if metadata then
    table.insert(nodes, spacer_node)
    table.insert(nodes, t(postamble_prefix .. ' bookingexperts/support#'))

    local jump_index = (include_description and 4) or 3

    table.insert(nodes, i(jump_index, metadata.issue_number))
  end

  return sn(nil, nodes)
end

local snippets = {
  s({
    trig = 'fix',
    name = 'Fixes (short)',
    dscr = 'Fixes issue in commit message without description',
  }, d(1, generate_issue_template, {}, { user_args = { 'Fixes' } })),
  s({
    trig = 'fixl',
    name = 'Fixes (long)',
    dscr = 'Fixes issue in commit message with description',
  }, d(1, generate_issue_template, {}, { user_args = { 'Fixes', true } })),
  s({
    trig = 'clo',
    name = 'Closes (short)',
    dscr = 'Closes issue in commit message without description',
  }, d(1, generate_issue_template, {}, { user_args = { 'Closes' } })),
  s({
    trig = 'clol',
    name = 'Closes (long)',
    dscr = 'Closes issue in commit message with description',
  }, d(1, generate_issue_template, {}, { user_args = { 'Closes', true } })),
  s({
    trig = 'ref',
    name = 'References (short)',
    dscr = 'References issue in commit message without description',
  }, d(1, generate_issue_template, {}, { user_args = { 'References' } })),
  s({
    trig = 'refl',
    name = 'References (long)',
    dscr = 'References issue in commit message with description',
  }, d(1, generate_issue_template, {}, { user_args = { 'References', true } })),
}

return snippets
