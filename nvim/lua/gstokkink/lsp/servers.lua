local M = {}

-- Currently installed language servers
local servers = {
  dockerls = {},
  graphql = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  },
  solargraph = {
    init_options = {
      formatting = false,
    },
    settings = {
      solargraph = {
        diagnostics = false,
      },
    },
  },
  sumneko_lua = {
    settings = {
      single_file_support = false,
      Lua = {
        completion = { callSnippet = 'Both' },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins' },
        },
        format = {
          enable = false,
        },
        hint = {
          enable = true,
        },
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        telemetry = { enable = false },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
          -- library = vim.api.nvim_get_runtime_file('', true),
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
      },
    },
  },
  terraformls = {},
  tsserver = { disable_formatting = true },
  yamlls = {
    schemastore = {
      enable = true,
    },
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require('schemastore').json.schemas(),
      },
    },
  },
}

function M.setup(server_options)
  -- lua-dev must be set up before lspconfig
  require('lua-dev').setup()

  local lspconfig = require('lspconfig')

  -- Set up language servers
  for server_name, _ in pairs(servers) do
    local opts = vim.tbl_deep_extend('force', server_options, servers[server_name] or {})

    -- For TypeScript language server, setup is handled by the 'typescript' plugin
    if server_name == 'tsserver' then
      require('typescript').setup({
        disable_commands = false,
        debug = false,
        server = opts,
      })
    else
      lspconfig[server_name].setup(opts)
    end
  end
end

return M
