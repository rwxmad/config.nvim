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
  --   config = function(_, opts)
  --     require('solarized-osaka').setup(opts)
  --     vim.cmd.colorscheme('solarized-osaka')
  --   end,
  -- },
  -- {
  --   'neanias/everforest-nvim',
  --   version = false,
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent_background_level = 1,
  --   },
  --   config = function(_, opts)
  --     local theme = require('everforest')
  --     theme.setup(opts)
  --     theme.load()
  --   end,
  -- },
  -- {
  --   'EdenEast/nightfox.nvim',
  --   opts = {
  --     options = {
  --       transparent = true,
  --     },
  --   },
  --   config = function(_, opts)
  --     require('nightfox').setup(opts)
  --     vim.cmd([[colorscheme nordfox]])
  --   end,
  -- },
  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   config = function(_, opts)
  --     require('gruvbox').setup(opts)
  --     vim.cmd([[colorscheme gruvbox]])
  --   end,
  -- },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
