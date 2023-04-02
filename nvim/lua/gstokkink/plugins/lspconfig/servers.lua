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
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        format = {
          -- We use the formatter gem to perform formatting
          enable = false,
        },
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
        workspace = {
          -- Skip workspace configuration check
          checkThirdParty = false,

          -- Make the server aware of neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
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
  -- neodev must be set up before lspconfig
  require('neodev').setup({})

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
