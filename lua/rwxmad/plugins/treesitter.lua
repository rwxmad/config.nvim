return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    version = false, -- last release is way too old and doesn't work on Windows
    build = function()
      local TS = require('nvim-treesitter')
      if not TS.get_installed then
        print('Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.')
        return
      end
      rwxmad.util.treesitter.ensure_treesitter_cli(function()
        TS.update(nil, { summary = true })
      end)
    end,
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'toml',
        'tsx',
        'typescript',
        'typst',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
        'comment',
        'make',
        'go',
        'rust',
        'pug',
        'css',
        'scss',
        'dockerfile',
        'vue',
        'glsl',
      },
    },
    config = function(_, opts)
      local TS = require('nvim-treesitter')

      setmetatable(require('nvim-treesitter.install'), {
        __newindex = function(_, k)
          if k == 'compilers' then
            vim.schedule(function()
              print({
                'Setting custom compilers for `nvim-treesitter` is no longer supported.',
                '',
                'For more info, see:',
                '- [compilers](https://docs.rs/cc/latest/cc/#compile-time-requirements)',
              })
            end)
          end
        end,
      })

      -- some quick sanity checks
      if not TS.get_installed then
        return print('Please use `:Lazy` and update `nvim-treesitter`')
      elseif type(opts.ensure_installed) ~= 'table' then
        return print('`nvim-treesitter` opts.ensure_installed must be a table')
      end

      -- setup treesitter
      TS.setup(opts)
      rwxmad.util.treesitter.get_installed(true) -- initialize the installed langs

      -- install missing parsers
      local install = vim.tbl_filter(function(lang)
        return not rwxmad.util.treesitter.have(lang)
      end, opts.ensure_installed or {})
      if #install > 0 then
        rwxmad.util.treesitter.ensure_treesitter_cli(function()
          TS.install(install, { summary = true }):await(function()
            rwxmad.util.treesitter.get_installed(true) -- refresh the installed langs
          end)
        end)
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('rwxmad_treesitter', { clear = true }),
        callback = function(ev)
          if not rwxmad.util.treesitter.have(ev.match) then
            return
          end

          -- highlighting
          if vim.tbl_get(opts, 'highlight', 'enable') ~= false then
            pcall(vim.treesitter.start)
          end

          -- indents
          if vim.tbl_get(opts, 'indent', 'enable') ~= false and rwxmad.util.treesitter.have(ev.match, 'indents') then
            vim.api.nvim_set_option_value(
              'indentexpr',
              "v:lua.require'nvim-treesitter'.indentexpr()",
              { scope = 'local' }
            )
          end

          -- folds
          if vim.tbl_get(opts, 'folds', 'enable') ~= false and rwxmad.util.treesitter.have(ev.match, 'folds') then
            vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.treesitter.foldexpr()', { scope = 'local' })
          end
        end,
      })

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = 'mdx',
        },
      })
      vim.treesitter.language.register('markdown', 'mdx')
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
    opts = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['uc'] = '@comment.outer',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        keys = {
          goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
          goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
        },
      },
    },
    config = function(_, opts)
      local TS = require('nvim-treesitter-textobjects')
      if not TS.setup then
        print('Please use `:Lazy` and update `nvim-treesitter`')
        return
      end
      TS.setup(opts)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('rwxmad_treesitter_textobjects', { clear = true }),
        callback = function(ev)
          if not (vim.tbl_get(opts, 'move', 'enable') and rwxmad.util.treesitter.have(ev.match, 'textobjects')) then
            return
          end
          ---@type table<string, table<string, string>>
          local moves = vim.tbl_get(opts, 'move', 'keys') or {}

          ---@type table<string, table<string, string>>
          local selections = vim.tbl_get(opts, 'select', 'keymaps') or {}

          -- move
          for method, keymaps in pairs(moves) do
            for key, query in pairs(keymaps) do
              local desc = query:gsub('@', ''):gsub('%..*', '')
              desc = desc:sub(1, 1):upper() .. desc:sub(2)
              desc = (key:sub(1, 1) == '[' and 'Prev ' or 'Next ') .. desc
              desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and ' End' or ' Start')
              if not (vim.wo.diff and key:find('[cC]')) then
                vim.keymap.set({ 'n', 'x', 'o' }, key, function()
                  require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
                end, {
                  buffer = ev.buf,
                  desc = desc,
                  silent = true,
                })
              end
            end
          end

          -- select
          for key, capture in pairs(selections) do
            for _, mode in ipairs({ 'x', 'o' }) do
              local desc = ('TS Select %s'):format(capture)
              vim.keymap.set(mode, key, function()
                require('nvim-treesitter-textobjects.select').select_textobject(capture, 'textobjects')
              end, { buffer = ev.buf, silent = true, desc = desc })
            end
          end
        end,
      })
    end,
  },

  -- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
