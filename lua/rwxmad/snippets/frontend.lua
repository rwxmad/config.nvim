require('luasnip.session.snippet_collection').clear_snippets('javascript')
require('luasnip.session.snippet_collection').clear_snippets('typescript')
local common = require('rwxmad.util.common')

-- console.log()
local console_log = 'console.log({})'

-- console.error()
local console_error = 'console.error({})'

-- JavaScript, Typescript, React, Vue
common.add_snippet({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' }, 'log', console_log)

common.add_snippet({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' }, 'ce', console_error)
