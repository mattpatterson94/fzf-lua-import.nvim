local M = {}

M.rg_ts_regex = function(query)
  -- eg. import { SomeModule } from 'some/directory/some_module';
  -- eg. import * as mobx from 'mobx'
  -- eg. import styles from "myfile.css"
  return string.format(
    "^import\\s*(type\\s+)?(\\*?\\s*\\{[^}]*%s[^}]*\\}|\\*?\\s*%s)\\s*from",
    query,
    query
  )
end

M.rg_ts_glob = function(include_dirs)
  local include = ""
  if include_dirs then
    include = "{"
    include = include .. table.concat(include_dirs, ",")
    include = include .. "}"
  end

  return include .. "*.{ts,tsx}"
end

M.rg_ts_opts = {
  regex = M.rg_ts_regex,
  glob = M.rg_ts_glob,
}

return M
