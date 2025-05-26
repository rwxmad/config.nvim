return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
      {
        '<leader>sm',
        function()
          require('fzf-lua').keymaps()
        end,
        desc = 'List keymaps',
      },
    },
    config = function()
      local lsp = require('rwxmad.util.lsp')

      local ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend('force', fzf_opts, {
          prompt = ' ',
          winopts = {
            title = ' ' .. vim.trim((fzf_opts.prompt or 'Select'):gsub('%s*:%s*$', '')) .. ' ',
            title_pos = 'center',
          },
        }, fzf_opts.kind == 'codeaction' and {
          winopts = {
            layout = 'horizontal',
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(lsp.get_clients({ bufnr = 0, name = 'vtsls' }))
                and {
                  layout = 'horizontal',
                  vertical = 'down:15,border-top',
                  -- hidden = 'hidden',
                }
              or {
                layout = 'horizontal',
                vertical = 'down:15,border-top',
              },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end

      -- custom vim.ui.select with fzf-lua
      vim.ui.select = function(...)
        require('fzf-lua').register_ui_select(ui_select)
        return vim.ui.select(...)
      end
    end,
  },
}
