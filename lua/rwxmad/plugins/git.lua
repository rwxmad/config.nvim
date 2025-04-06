return {
  {
    'lewis6991/gitsigns.nvim',
    keys = {
      { '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Stage hunk' },
      { '<leader>hy', '<cmd>Gitsigns undo_stage_hunk<CR>', desc = 'Undo stage hunk' },
      { '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', desc = 'Reset hunk' },
      { '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', desc = 'Preview hunk' },
      { '<leader>hb', '<cmd>Gitsigns blame_line<CR>', desc = 'Blame line' },
      { '<leader>hd', '<cmd>Gitsigns diffthis<CR>', desc = 'Diff hunk' },
      { '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', desc = 'Reset buffer' },
      { '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', desc = 'Stage buffer' },
    },
    config = function()
      require('gitsigns').setup()
    end,
  },
}
