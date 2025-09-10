return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'mrcjkb/rustaceanvim',
    },
    keys = {
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        desc = 'Neotest run nearest test',
      },
      {
        '<leader>tt',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Neotest run current file',
      },

      {
        '<leader>td',
        function()
          require('neotest').run.run({ strategy = 'dap' })
        end,
        desc = 'Neotest run nearest test with dap',
      },
    },
    config = function()
      require('neotest').setup({ adapters = { require('rustaceanvim.neotest') } })
    end,
  },
}
