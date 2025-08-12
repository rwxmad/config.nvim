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

  -- Create annotations with one keybind, and jump your cursor in the inserted annotation
  {
    'danymat/neogen',
    keys = {
      {
        '<leader>cc',
        function()
          require('neogen').generate({})
        end,
        desc = 'Neogen Comment',
      },
    },
    opts = { snippet_engine = 'luasnip' },
  },
}
