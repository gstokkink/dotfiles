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

-- Notify helpers
function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

return M
