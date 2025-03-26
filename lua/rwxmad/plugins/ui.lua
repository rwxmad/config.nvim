return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },

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
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
    },
  },

  -- animations
  {
    'echasnovski/mini.animate',
    event = 'VeryLazy',
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
}
