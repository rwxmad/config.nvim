return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'folke/snacks.nvim' },
    config = function()
      local harpoon = require('harpoon')

      harpoon:setup()

      local ui = harpoon.ui

      local normalize_list = function(t)
        local normalized = {}
        for _, v in pairs(t) do
          if v ~= nil then
            table.insert(normalized, v)
          end
        end
        return normalized
      end

      local function harpoon_picker()
        Snacks.picker({
          title = 'Harpoon',
          finder = function()
            local file_paths = {}
            local list = normalize_list(harpoon:list().items)
            for i, item in ipairs(list) do
              table.insert(
                file_paths,
                { text = item.value, file = item.value, icon = { icon = tostring(i), hl = 'Number' } }
              )
            end
            return file_paths
          end,
          format = function(item)
            local icon, hl = Snacks.util.icon(item.file or item.text)

            return {
              -- harpoon index
              { tostring(item.idx) .. ' ', 'Number' },

              -- extension icon with hl group
              { icon .. ' ', hl },

              -- path
              { item.text },
            }
          end,
          win = {
            input = {
              keys = { ['dd'] = { 'harpoon_delete', mode = { 'n', 'x' } } },
            },
            list = {
              keys = { ['dd'] = { 'harpoon_delete', mode = { 'n', 'x' } } },
            },
          },
          actions = {
            harpoon_delete = function(picker, item)
              local to_remove = item or picker:selected()
              harpoon:list():remove({ value = to_remove.text })
              harpoon:list().items = normalize_list(harpoon:list().items)
              picker:find({ refresh = true })
            end,
          },
        })
      end

      -- keys

      -- add current file in list
      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Harpoon: add file' })

      -- open default harpoon menu
      vim.keymap.set('n', '<leader>hm', function()
        ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon: quick menu' })

      -- index slots
      vim.keymap.set('n', '<leader>h1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: file 1' })

      vim.keymap.set('n', '<leader>h2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: file 2' })

      vim.keymap.set('n', '<leader>h3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: file 3' })

      vim.keymap.set('n', '<leader>h4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: file 4' })

      -- open list in picker
      vim.keymap.set('n', '<leader>hh', harpoon_picker, {
        desc = 'Harpoon: open via Snacks picker',
      })
    end,
  },
}
