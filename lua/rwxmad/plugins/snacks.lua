return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      indent = {},
      lazygit = {
        win = {
          width = 0.9,
          height = 0.9,
        },
      },
      input = {},
      scratch = {},
      git = {},
      words = {},
      notifier = {},
      explorer = {},
      picker = {},
      image = {},
      terminal = {
        win = {
          position = 'float',
          width = 0.6,
          height = 0.6,
          border = 'rounded',
        },
      },
      dashboard = {
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
          {
            pane = 2,
            icon = ' ',
            desc = 'Browse Repo',
            padding = 1,
            key = 'r',
            action = function()
              Snacks.gitbrowse()
            end,
          },
          function()
            local in_git = Snacks.git.get_root() ~= nil
            local cmds = {
              {
                title = 'Notifications',
                cmd = 'gh notify -s -a -n5',
                action = function()
                  vim.ui.open('https://github.com/notifications')
                end,
                key = 'n',
                icon = ' ',
                height = 5,
                enabled = true,
              },
              {
                title = 'Open Issues',
                cmd = 'gh issue list -L 3',
                key = 'i',
                action = function()
                  vim.fn.jobstart('gh issue list --web', { detach = true })
                end,
                icon = ' ',
                height = 7,
              },
              {
                icon = ' ',
                title = 'Open PRs',
                cmd = 'gh pr list -L 3',
                key = 'p',
                action = function()
                  vim.fn.jobstart('gh pr list --web', { detach = true })
                end,
                height = 7,
              },
              {
                icon = ' ',
                title = 'Git Status',
                cmd = 'hub --no-pager diff --stat -B -M -C',
                height = 10,
              },
            }
            return vim.tbl_map(function(cmd)
              return vim.tbl_extend('force', {
                pane = 2,
                section = 'terminal',
                enabled = in_git,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
              }, cmd)
            end, cmds)
          end,
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
        preset = {
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ' ', key = 'b', desc = 'File browser', action = ':lua Snacks.explorer()' },
            { icon = ' ', key = 'o', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = ' ',
              key = 'c',
              desc = 'Config',
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
            { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
          header = [[
██████╗ ██╗    ██╗██╗  ██╗███╗   ███╗ █████╗ ██████╗
██╔══██╗██║    ██║╚██╗██╔╝████╗ ████║██╔══██╗██╔══██╗
██████╔╝██║ █╗ ██║ ╚███╔╝ ██╔████╔██║███████║██║  ██║
██╔══██╗██║███╗██║ ██╔██╗ ██║╚██╔╝██║██╔══██║██║  ██║
██║  ██║╚███╔███╔╝██╔╝ ██╗██║ ╚═╝ ██║██║  ██║██████╔╝
╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═════╝
]],
        },
      },
    },
    keys = {
      {
        '<leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>S',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
      {
        '<leader>n',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
      -- {
      --   '<leader>bd',
      --   function()
      --     Snacks.bufdelete()
      --   end,
      --   desc = 'Delete Buffer',
      -- },
      {
        '<leader>cR',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'Rename File',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
        mode = { 'n', 'v' },
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>gf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = 'Lazygit Current File History',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>gl',
        function()
          Snacks.lazygit.log()
        end,
        desc = 'Lazygit Log (cwd)',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<c-_>',
        function()
          Snacks.terminal()
        end,
      },
      {
        '<c-d>',
        function()
          Snacks.terminal.toggle()
        end,
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
    },
  },
}
