return {
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      {
        '<leader>bn',
        '<cmd>BufferLineMoveNext<CR>',
        silent = true,
        desc = 'Move current buffer to right',
      },
      {
        '<leader>bp',
        '<cmd>BufferLineMovePrev<CR>',
        silent = true,
        desc = 'Move current buffer to left',
      },
      {
        '<leader>be',
        '<cmd>BufferLineSortByExtension<CR>',
        silent = true,
        desc = 'Sort buffers by extension',
      },
      {
        '<leader>bd',
        '<cmd>BufferLineSortByDirectory<CR>',
        silent = true,
        desc = 'Sort buffers by directory',
      },
      { '<leader>bb', '<cmd>BufferLinePick<CR>', silent = true, desc = 'Search and jump to buffer' },
      { '<leader>bd', '<cmd>bdelete<CR>', silent = true, desc = 'Close current buffer' },
      {
        '<leader>bc',
        '<cmd>BufferLinePickClose<CR>',
        silent = true,
        desc = 'Find the buffer and close',
      },

      -- Jump to buffer by number
      -- vim.keymap.set('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>9', '<cmd>BufferLineGoToBuffer 9<CR>', { silent = true })
    },
    opts = {
      options = {
        numbers = function(opts)
          return string.format('%s', opts.ordinal, opts.raise(opts.ordinal))
        end,
        show_close_icon = false,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        separator_style = 'thick',
        diagnostics_indicator = function(_, _, diag)
          local icons = require('rwxmad.defaults').icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            highlight = 'Directory',
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
