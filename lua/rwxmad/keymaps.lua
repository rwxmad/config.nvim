-- -------------------------------------------------------------------------------------------------
-- General mappings
-- -------------------------------------------------------------------------------------------------

-- Map leader to ,
vim.g.mapleader = ','

-- Keymaps

-- Exit insert mode
vim.keymap.set('i', 'jj', '<Esc>')

-- Write file like :w command
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>')

-- Quit nvim like :q command
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { silent = true })

-- Turn off search highlight
vim.keymap.set('n', '<leader><space>', '<cmd>nohlsearch<CR>')

-- Delete a word backwards
vim.keymap.set('n', 'db', 'vb"_d')

-- Move to start or end of line in insert mode
vim.keymap.set('i', '<C-l>', '<ESC>A')
vim.keymap.set('i', '<C-h>', '<ESC>I')

-- -------------------------------------------------------------------------------------------------
-- Diagnostics
-- -------------------------------------------------------------------------------------------------

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Line diagnostics' })

vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })
