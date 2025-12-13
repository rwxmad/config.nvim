return {
  -- {
  --
  --   'craftzdog/solarized-osaka.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = function()
  --     return {
  --       transparent = true,
  --       on_highlights = function(highlights, colors)
  --         highlights.LspInlayHint = { fg = colors.base01 }
  --       end,
  --     }
  --   end,
  -- config = function(_, opts)
  -- require('solarized-osaka').setup(opts)
  -- vim.cmd.colorscheme('solarized-osaka')
  -- end,
  -- },

  -- {
  --   'rebelot/kanagawa.nvim',
  --   lazy = false,
  --   opts = {},
  --   config = function()
  -- require('kanagawa').setup({
  --   theme = 'dragon',
  --   transparent = true,
  --   colors = {
  --     theme = { all = { ui = { bg_gutter = 'none' } } },
  --   },
  -- })
  -- vim.cmd.colorscheme('kanagawa-dragon')
  --   end,
  -- },
  -- {
  --   'neanias/everforest-nvim',
  --   version = false,
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local theme = require('everforest')
  --     theme.setup({
  --       transparent_background_level = 1,
  --     })
  --     theme.load()
  --   end,
  -- },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
        bg = true,
      },
    },
    config = function(_, opts)
      require('nordic').load(opts)
    end,
  },
}
