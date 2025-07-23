return {
  {

    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        on_highlights = function(highlights, colors)
          highlights.LspInlayHint = { fg = colors.base01 }
        end,
      }
    end,
    config = function(_, opts)
      vim.cmd.colorscheme('solarized-osaka')
    end,
  },
}
