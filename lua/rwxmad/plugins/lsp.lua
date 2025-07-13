return {
  {
    'mason-org/mason.nvim',
    dependencies = {
      -- 'neovim/nvim-lspconfig',
      { 'mason-org/mason-lspconfig.nvim', config = function() end },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Autoformatting
      'stevearc/conform.nvim',
    },
    config = function()
      local lsp = require('rwxmad.util.lsp')

      local capabilities = nil

      if pcall(require, 'blink.cmp') then
        capabilities = require('blink.cmp').get_lsp_capabilities()
      end

      local inlay_hints_exclude = { 'vue' }

      -- inlay hints
      if vim.fn.has('nvim-0.10') == 1 then
        lsp.on_supports_method('textDocument/inlayHint', function(client, buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ''
            and not vim.tbl_contains(inlay_hints_exclude, vim.bo[buffer].filetype)
          then
            lsp.toggle_inlay_hints(buffer, true)
          end
        end)
      end

      lsp.setup()

      vim.lsp.config('*', {
        capabilities = capabilities,
        root_markers = { '.git' },
      })

      local servers = {
        'html',
        'cssls',
        'emmet_ls',
        'eslint',
        'jsonls',
        'pyright',
        'bashls',
        'vtsls',
        'vue_ls',
        'lua_ls',
        'tailwindcss',
        'rust_analyzer',
      }

      local ensure_installed = {
        'stylua',
        'shfmt',
        'prettierd',
        'prettier',
      }

      require('mason').setup()

      -- mason-lspconfig
      require('mason-lspconfig').setup({
        ensure_installed = servers,
        automatic_installation = true,
        automatic_enable = true,
      })

      -- diagnostics
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
        },
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'if_many',
          header = '',
          prefix = '',
        },
      })

      vim.list_extend(ensure_installed, servers)
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed, automatic_enable = false })

      -- Autoformatting Setup
      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettierd', 'prettier' },
          javascriptreact = { 'prettierd', 'prettier' },
          typescript = { 'prettierd', 'prettier' },
          typescriptreact = { 'prettierd', 'prettier' },
          css = { 'stylelint', 'prettierd', 'prettier' },
          vue = { 'prettierd', 'prettier' },
          python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
          rust = { 'rustfmt' },
          markdown = { 'prettierd', 'prettier' },
          ['_'] = { 'trim_whitespace' },
        },
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function(args)
          require('conform').format({
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          })
        end,
      })
    end,
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
