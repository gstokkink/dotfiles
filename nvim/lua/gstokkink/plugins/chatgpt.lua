-- ChatGPT
return {
  'jackMort/ChatGPT.nvim',
  enabled = false, -- Fix OpenAI API token first
  dependencies = {
    { 'MunifTanjim/nui.nvim' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = true,
}
