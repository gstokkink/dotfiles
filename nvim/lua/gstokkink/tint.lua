require('tint').setup({
  focus_change_events = {
    focus = { 'FocusGained', 'WinEnter' },
    unfocus = { 'FocusLost', 'WinLeave' },
  },
})
