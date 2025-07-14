local M = {}

function M.get_clients(opts)
  local ret = {}
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

function M.on_attach(on_attach)
  return vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(args)
      -- defaults:
      -- https://neovim.io/doc/user/news-0.11.html#_defaults
      vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
      -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = 0 })
      -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
      -- vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { buffer = 0 })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = 0 })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })

      local function client_supports_method(client, method, bufnr)
        if vim.fn.has('nvim-0.11') == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if
        client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, args.buf)
      then
        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

        -- cursor stops moving: highlight all instances of the symbol under the cursor
        -- cursor moves: clear highlighting
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = args.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = args.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        -- LSP detach -> clear highlighting
        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
          end,
        })
      end

      if on_attach then
        on_attach(client, args.buf)
      end
    end,
  })
end

M._supports_method = {}

function M.setup()
  local register_capability = vim.lsp.handlers['client/registerCapability']
  vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
    ---@diagnostic disable-next-line: no-unknown
    local ret = register_capability(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client then
      for buffer in pairs(client.attached_buffers) do
        vim.api.nvim_exec_autocmds('User', {
          pattern = 'LspDynamicCapability',
          data = { client_id = client.id, buffer = buffer },
        })
      end
    end
    return ret
  end
  M.on_attach(M._check_methods)
  M.on_dynamic_capability(M._check_methods)
end

function M._check_methods(client, buffer)
  -- don't trigger on invalid buffers
  if not vim.api.nvim_buf_is_valid(buffer) then
    return
  end
  -- don't trigger on non-listed buffers
  if not vim.bo[buffer].buflisted then
    return
  end
  -- don't trigger on nofile buffers
  if vim.bo[buffer].buftype == 'nofile' then
    return
  end
  for method, clients in pairs(M._supports_method) do
    clients[client] = clients[client] or {}
    if not clients[client][buffer] then
      if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
        clients[client][buffer] = true
        vim.api.nvim_exec_autocmds('User', {
          pattern = 'LspSupportsMethod',
          data = { client_id = client.id, buffer = buffer, method = method },
        })
      end
    end
  end
end

function M.on_dynamic_capability(fn, opts)
  return vim.api.nvim_create_autocmd('User', {
    pattern = 'LspDynamicCapability',
    group = opts and opts.group or nil,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer ---@type number
      if client then
        return fn(client, buffer)
      end
    end,
  })
end

function M.on_supports_method(method, fn)
  M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = 'k' })
  return vim.api.nvim_create_autocmd('User', {
    pattern = 'LspSupportsMethod',
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer
      if client and method == args.data.method then
        return fn(client, buffer)
      end
    end,
  })
end

function M.toggle_inlay_hints(buf, value)
  local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if type(ih) == 'function' then
    ih(buf, value)
  elseif type(ih) == 'table' and ih.enable then
    if value == nil then
      value = not ih.is_enabled({ bufnr = buf or 0 })
    end
    ih.enable(value, { bufnr = buf })
  end
end

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

--- Gets a path to a package in the Mason registry.
---@param pkg string
---@param path? string
---@param opts? { warn?: boolean }
function M.get_pkg_path(pkg, path, opts)
  pcall(require, 'mason') -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ''
  local ret = root .. '/packages/' .. pkg .. '/' .. path
  if opts.warn and not vim.loop.fs_stat(ret) and not require('lazy.core.config').headless() then
    Snacks.notify.warn(
      ('Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package.'):format(pkg, path)
    )
  end
  return ret
end

return M
