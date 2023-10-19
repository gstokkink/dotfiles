return {
  'stevearc/conform.nvim',
  opts = function()
    return {
      formatters = {
        rubocop = {
          inherit = false,
          command = 'rb',
          args = {
            '-f',
            'quiet',
            '--fix-layout',
            '--stderr',
            '--stdin',
            '$FILENAME',
          },
          cwd = require('conform.util').root_file({ '.rubocop.yml' }),
          require_cwd = true,
          exit_codes = { 0, 1 },
        },
      },
      formatters_by_ft = {
        css = { 'prettierd' },
        graphql = { 'prettierd' },
        html = { 'prettierd' },
        javascript = { 'prettierd' },
        json = { 'prettierd' },
        lua = { 'stylua' },
        ruby = { 'rubocop' },
        sh = { 'shfmt' },
        terraform = { 'terraform_fmt' },
        toml = { 'taplo' },
        typescript = { 'prettierd' },
        yaml = { 'yamlfmt' },
        ['*'] = { 'trim_whitespace' },
      },
      format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype == 'ruby' then
          return
        end

        return { timeout_ms = 1000, lsp_fallback = false }
      end,
      format_after_save = function(bufnr)
        if vim.bo[bufnr].filetype ~= 'ruby' then
          return
        end

        return { lsp_fallback = false }
      end,
      notify_on_error = false,
    }
  end,
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
