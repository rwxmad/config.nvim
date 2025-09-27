local M = {}

M = {
  defaults = require('rwxmad.defaults'),
  util = {
    common = require('rwxmad.util.common'),
    treesitter = require('rwxmad.util.treesitter'),
    lsp = require('rwxmad.util.lsp'),
    cmp = require('rwxmad.util.cmp'),
    mini = require('rwxmad.util.mini'),
  },
}

return M
