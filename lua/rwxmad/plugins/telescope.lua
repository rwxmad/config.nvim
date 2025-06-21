return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      'AckslD/nvim-neoclip.lua',
    },
    run = 'make',
    lazy = false,
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Grep' },
      { '<leader>bg', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
      { '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = 'Recent' },
      { '<leader>fb', '<cmd>Telescope file_browser<cr>', desc = 'File browser' },
      { '<leader>fn', '<cmd>Telescope neoclip<cr>', desc = 'Clipboard history' },
      { '<leader>fm', '<cmd>Telescope media_files<cr>', desc = 'Media files' },

      -- lsp
      {
        'gd',
        function()
          require('telescope.builtin').lsp_definitions({ reuse_win = true })
        end,
        desc = 'Goto Definition',
      },
      { 'gr', '<cmd>Telescope lsp_references<cr>', desc = 'References', nowait = true },
      {
        'gI',
        function()
          require('telescope.builtin').lsp_implementations({ reuse_win = true })
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          require('telescope.builtin').lsp_type_definitions({ reuse_win = true })
        end,
        desc = 'Goto T[y]pe Definition',
      },

      -- search
      { '<leader>sm', '<cmd>Telescope keymaps<cr>', desc = 'Search keymaps' },
    },
    opts = function()
      local fb_actions = require('telescope').extensions.file_browser.actions

      return {
        defaults = {
          prompt_prefix = ' ',
          preview = {
            mime_hook = function(filepath, bufnr, opts)
              local is_image = function(filepath)
                local image_extensions = { 'png', 'jpg', 'jpeg', 'gif', 'mp4', 'webm', 'pdf', 'webp' } -- Supported image formats
                local split_path = vim.split(filepath:lower(), '.', { plain = true })
                local extension = split_path[#split_path]
                return vim.tbl_contains(image_extensions, extension)
              end

              if is_image(filepath) then
                local term = vim.api.nvim_open_term(bufnr, {})
                local function send_output(_, data, _)
                  for _, d in ipairs(data) do
                    vim.api.nvim_chan_send(term, d .. '\r\n')
                  end
                end

                vim.fn.jobstart({
                  'chafa',
                  filepath,
                }, { on_stdout = send_output, stdout_buffered = true, pty = true })
              else
                require('telescope.previewers.utils').set_preview_message(
                  bufnr,
                  opts.winid,
                  'Binary cannot be previewed'
                )
              end
            end,
          },
        },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
            file_ignore_patterns = { '.git/', 'node_modules/' },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
          file_browser = {
            path = '%:p:h',
            cwd = vim.fn.expand('%:p:h'),
            hidden = true,
            grouped = true,
            theme = 'dropdown',
            previewer = false,
            initial_mode = 'normal',
            mappings = {
              ['n'] = {
                ['N'] = fb_actions.create,
                ['D'] = fb_actions.remove,
              },
            },
          },
          media_files = {
            filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
            find_cmd = 'rg',
          },
        },
      }
    end,
    config = function(_, opts)
      require('telescope').setup(opts)

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('file_browser')
      require('telescope').load_extension('media_files')
      require('telescope').load_extension('neoclip')

      vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = '#ff0000' })
      vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = '#ff0000' })
    end,
  },
}
