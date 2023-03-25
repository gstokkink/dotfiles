local luasnip = require('luasnip')
local s = luasnip.snippet
local i = luasnip.insert_node
local f = luasnip.function_node
local fmt = require('luasnip.extras.fmt').fmt

local function parse_issue_number()
  local branch_name = vim.fn.system('git rev-parse --abbrev-ref HEAD')
  local issue_number = string.match(branch_name, '^(%d[%d]*)-')

  return issue_number
end

local snippets = {
  s(
    {
      trig = 'fix',
      name = 'Fixes (short)',
      dscr = 'Fixes issue in commit message without description',
    },
    fmt(
      [[
      {issue_number} {issue_title}

      Fixes bookingexperts/support#{issue_number}
    ]],
      {
        issue_number = f(parse_issue_number, {}),
        issue_title = i(1, 'title'),
      }
    )
  ),
  s(
    {
      trig = 'fixl',
      name = 'Fixes (long)',
      dscr = 'Fixes issue in commit message with description',
    },
    fmt(
      [[
      {issue_number} {issue_title}

      {issue_description}

      Fixes bookingexperts/support#{issue_number}
    ]],
      {
        issue_number = f(parse_issue_number, {}),
        issue_title = i(1, 'title'),
        issue_description = i(2, 'description'),
      }
    )
  ),
  s(
    {
      trig = 'clo',
      name = 'Closes (short)',
      dscr = 'Closes issue in commit message without description',
    },
    fmt(
      [[
      {issue_number} {issue_title}

      Closes bookingexperts/support#{issue_number}
    ]],
      {
        issue_number = f(parse_issue_number, {}),
        issue_title = i(1, 'title'),
      }
    )
  ),
  s(
    {
      trig = 'clol',
      name = 'Closes (long)',
      dscr = 'Closes issue in commit message with description',
    },
    fmt(
      [[
      {issue_number} {issue_title}

      {issue_description}

      Closes bookingexperts/support#{issue_number}
    ]],
      {
        issue_number = f(parse_issue_number, {}),
        issue_title = i(1, 'title'),
        issue_description = i(2, 'description'),
      }
    )
  ),
  s(
    {
      trig = 'ref',
      name = 'References (short)',
      dscr = 'References issue in commit message without description',
    },
    fmt(
      [[
      {issue_number} {issue_title}

      References bookingexperts/support#{issue_number}
    ]],
      {
        issue_number = f(parse_issue_number, {}),
        issue_title = i(1, 'title'),
      }
    )
  ),
  s(
    {
      trig = 'refl',
      name = 'References (long)',
      dscr = 'References issue in commit message with description',
    },
    fmt(
      [[
      {issue_number} {issue_title}

      {issue_description}

      References bookingexperts/support#{issue_number}
    ]],
      {
        issue_number = f(parse_issue_number, {}),
        issue_title = i(1, 'title'),
        issue_description = i(2, 'description'),
      }
    )
  ),
}

return snippets
