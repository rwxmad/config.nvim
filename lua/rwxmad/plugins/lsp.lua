return {
  {
    'mason-org/mason.nvim',
    dependencies = {
      -- 'neovim/nvim-lspconfig',
      { 'mason-org/mason-lspconfig.nvim', config = function() end },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Autoformatting
      'stevearc/conform.nvim',
      {
        'SmiteshP/nvim-navic',
        opts = function()
          return {
            separator = ' ',
            highlight = true,
            depth_limit = 5,
            icons = rwxmad.defaults.icons.kinds,
            lazy_update_context = false,
          }
        end,
      },
    },
    config = function()
      local lsp = rwxmad.util.lsp
      local navic = require('nvim-navic')

      local capabilities = nil

      if pcall(require, 'blink.cmp') then
        capabilities = require('blink.cmp').get_lsp_capabilities()
      end

      local inlay_hints_exclude = { 'vue' }

      -- inlay hints
      lsp.on_supports_method('textDocument/inlayHint', function(client, buffer)
        if
          vim.api.nvim_buf_is_valid(buffer)
          and vim.bo[buffer].buftype == ''
          and not vim.tbl_contains(inlay_hints_exclude, vim.bo[buffer].filetype)
        then
          lsp.toggle_inlay_hints(buffer, true)
        end
      end)

      -- code lens
      -- if vim.lsp.codelens then
      --   lsp.on_supports_method('textDocument/codeLens', function(client, buffer)
      --     vim.lsp.codelens.enable(true, { bufnr = buffer })
      --   end)
      -- end

      -- nvim-navic
      lsp.on_supports_method('textDocument/documentSymbol', function(client, buffer)
        navic.attach(client, buffer)
      end)

      lsp.setup()

      vim.lsp.config('*', {
        capabilities = capabilities,
        root_markers = { '.git' },
      })

      local servers = {
        'html',
        'cssls',
        'eslint',
        'jsonls',
        'pyright',
        'bashls',
        'vtsls',
        'vue_ls',
        'lua_ls',
        'tailwindcss',
        -- 'rust_analyzer',
        'marksman',
        'mdx_analyzer',
      }

      local tools = {
        'stylua',
        'shfmt',
        'prettierd',
        'prettier',
        'eslint_d',
      }

      require('mason').setup()

      -- mason-lspconfig
      require('mason-lspconfig').setup({
        ensure_installed = servers,
        automatic_enable = {
          exclude = { 'rust_analyzer' },
        },
      })

      require('mason-tool-installer').setup({ ensure_installed = tools, automatic_enable = false })

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

      -- Autoformatting Setup
      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettierd', 'prettier', 'eslint_d' },
          javascriptreact = { 'prettierd', 'prettier', 'eslint_d' },
          typescript = { 'prettierd', 'prettier', 'eslint_d' },
          typescriptreact = { 'prettierd', 'prettier', 'eslint_d' },
          css = { 'stylelint', 'prettierd', 'prettier' },
          vue = { 'prettierd', 'prettier', 'eslint_d' },
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
