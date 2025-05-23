local M = {}
local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node

local fmt = require('luasnip.extras.fmt').fmt

function M.add_snippet(langs, trigger, fmt_string)
  -- Convert single filetype string to table for uniform handling
  if type(langs) == 'string' then
    langs = { langs }
  end

  for _, lang in ipairs(langs) do
    ls.add_snippets(lang, {
      s(trigger, fmt(fmt_string, { i(0) })),
    })
  end
end

return M
