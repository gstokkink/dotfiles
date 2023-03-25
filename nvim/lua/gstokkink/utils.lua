local M = {}

local api = vim.api

-- Create key mapping
function M.map(mode, key, result, opts)
  local map_opts = {
    noremap = true,
    silent = opts.silent or false,
    expr = opts.expr or false,
    script = opts.script or false,
  }

  if not opts.buffer then
    api.nvim_set_keymap(mode, key, result, map_opts)
  else
    local buffer = opts.buffer

    if buffer == true then
      buffer = 0
    end

    api.nvim_buf_set_keymap(buffer, mode, key, result, map_opts)
  end
end

-- Callback when LSP attaches
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

return M
