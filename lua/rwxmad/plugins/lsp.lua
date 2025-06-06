return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Autoformatting
      'stevearc/conform.nvim',
    },
    config = function()
      local lsp = require('rwxmad.util.lsp')

      lsp.on_attach(function(client, buffer)
        vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = 0 })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
        -- vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
      end)

      lsp.setup()

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

      local lspconfig = require('lspconfig')
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

      local servers = {
        html = {},
        cssls = {},
        ts_ls = {
          init_options = {
            plugins = {
              -- NOTE: for typescript + vue work
              {
                name = '@vue/typescript-plugin',
                -- location = '/usr/local/lib/node_modules/@vue/typescript-plugin',
                location = '/Users/rwxmad/.npm/lib/node_modules/@vue/typescript-plugin',
                languages = { 'javascript', 'typescript', 'vue' },
              },
            },
          },
          single_file_support = true,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'literal',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
          filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'vue',
          },
        },
        eslint = {
          enable = true,
          format = true,
          autoFixOnSave = true,
          workingDirectories = { mode = 'auto' },
        },
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                allFeatures = true,
                command = 'clippy',
              },
              procMacro = {
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
            },
          },
        },
        emmet_ls = {},
        tailwindcss = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                globals = { 'vim' },
              },
              completion = {
                callSnippet = 'Replace',
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
              hint = {
                enable = true,
                arrayIndex = 'Disable',
              },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                  continuation_indent_size = '2',
                },
              },
            },
          },
        },
        pyright = {},
        vue_ls = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
        bashls = {},
        marksman = {},
      }

      local options = {
        capabilities = capabilities,
      }

      local server_list = {}

      for server, opts in pairs(servers) do
        opts = vim.tbl_deep_extend('force', {}, options, opts or {})
        table.insert(server_list, server)
        -- FIXME: remove or configure
        -- if server == 'tsserver' then
        --   require('typescript-tools').setup({
        --     on_attach = on_attach,
        --     filetypes = {
        --       'javascript',
        --       'javascriptreact',
        --       'typescript',
        --       'typescriptreact',
        --       'vue',
        --     },
        --     settings = {
        --       separate_diagnostic_server = true,
        --       tsserver_file_preferences = {
        --         includeInlayParameterNameHints = 'all',
        --         includeCompletionsForModuleExports = true,
        --         quotePreference = 'auto',
        --       },
        --       tsserver_plugins = {
        --         '@vue/typescript-plugin',
        --       },
        --     },
        --   })
        if server == 'rust_analyzer' then
          -- require('rust-tools').setup({ server = opts })
          lspconfig[server].setup(opts)
        else
          lspconfig[server].setup(opts)
        end
      end

      require('mason').setup()

      -- mason-lspconfig
      require('mason-lspconfig').setup({
        ensure_installed = server_list,
        automatic_installation = true,
        automatic_enable = true,
      })

      local ensure_installed = {
        'stylua',
        'shfmt',
        'prettierd',
        'prettier',
      }

      vim.list_extend(ensure_installed, servers)
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

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
