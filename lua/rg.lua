local M = {}

M.rg_ts_regex = function(query)
  -- eg. import { SomeModule } from 'some/directory/some_module';
  -- eg. import * as mobx from 'mobx'
  -- eg. import styles from "myfile.css"
  return "^import\\s*(type\\s+)?(\\*?\\s*\\{[^}]*"
    .. query
    .. "[^}]*\\}|\\*?\\s*"
    .. query
    .. ")\\s*from"
end

M.rg_ts = function(query, include_dirs)
  local regex = M.rg_ts_regex(query)
  local include = ""
  if include_dirs then
    include = "{"
    include = include .. table.concat(include_dirs, ",")
    include = include .. "}"
  end

  local glob = include .. "*.{ts,tsx}"
  return M.rg(regex, glob)
end

M.rg = function(regex, glob)
  return "rg --color=always -i --no-column --no-line-number --no-filename '"
    .. regex
    .. "' --glob '"
    .. glob
    .. "'"
end

return M
