return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        vim.o.laststatus = 3
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require('lualine_require')

      -- get default colors from colorscheme
      local colorscheme_default_colors = require('solarized-osaka.colors').default

      lualine_require.require = require

      local icons = require('rwxmad.defaults').icons

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          icons_enabled = true,
          theme = 'solarized_dark',
          section_separators = '',
          component_separators = '',
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'branch', icon = '' },
          },
          lualine_c = {
            {
              'filename',
              file_status = true, -- Displays file status (readonly status, modified status)
              path = 1, -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              -- 4: Filename and parent dir, with tilde as the home directory
              symbols = {
                modified = '[+]', -- Text to show when the file is modified.
                readonly = ' 󰌾 ', -- Text to show when the file is non-modifiable or readonly.
              },
            },
            {
              require('noice').api.status.mode.get,
              cond = require('noice').api.status.mode.has,
              color = { fg = colorscheme_default_colors.yellow500 },
            },
          },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_lsp' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            },
            { 'diff', symbols = { added = ' ', modified = '柳', removed = ' ' } },
            'encoding',
            'filetype',
          },
          lualine_y = {
            { 'fileformat' },
            { 'progress' },
          },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { 'quickfix', 'nvim-tree' },
      }
    end,
  },
}
