return {
  -- comments
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
    enabled = vim.fn.has('nvim-0.10') == 1,
  },

  -- Incremental rename
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    keys = {
      {
        '<leader>rn',
        function()
          return ':IncRename '
        end,
        mode = 'n',
        noremap = true,
        silent = true,
        expr = true,
      },
    },
    config = true,
  },
}
