local set = vim.opt

set.mouse = 'a'

set.syntax = 'enable'
set.termguicolors = true
set.background = 'dark'
set.clipboard = 'unnamedplus'

set.encoding = 'utf-8'
set.fileencoding = 'utf-8'

set.filetype = 'on'

set.showcmd = false
set.cmdheight = 1
set.laststatus = 2
set.scrolloff = 10

set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.swapfile = false
set.backup = false
set.undofile = true

set.nu = true -- line numbers
set.rnu = true -- relative number
set.ruler = true
set.signcolumn = 'yes'
set.autoindent = true
set.cursorline = true

set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true

set.list = true -- Show some invisible characters

vim.g.ai_cmp = true

-- File types
vim.filetype.add({
  extension = {
    mdx = 'mdx',
  },
})

-- nvim-navic
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
