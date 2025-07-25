-- -------------------------------------------------------------------------------------------------
-- General options
-- -------------------------------------------------------------------------------------------------

require('rwxmad.options')

-- -------------------------------------------------------------------------------------------------
-- Keymaps
-- -------------------------------------------------------------------------------------------------

require('rwxmad.keymaps')

-- -------------------------------------------------------------------------------------------------
-- Plugins
-- -------------------------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({ import = 'rwxmad/plugins' })
