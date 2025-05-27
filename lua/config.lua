local fzf_lua_grep = require("fzf-lua/providers/grep")
local utils = require("utils")

local types = {
  ts = {
    -- eg. import { MyModule } from 'lib/my_module';
    -- eg. import * as mobx from 'mobx'
    -- eg. import styles from "myfile.css"
    -- does not match relative paths like import styles from "./myfile.css" (can be disabled by removing the \w at the end)
    regex = "^import\\s*(type\\s+)?(\\*\\s*as)?(\\*?\\s*\\{?[^}]%s[^}]*\\}?|\\*?\\s%s)\\s*from\\s[\\\"\\']@?\\/?\\w",
    glob = { "ts", "tsx", "js", "jsx" },
  },
}

local live_grep = function(search_fn)
  return function(opts)
    opts.search = search_fn and search_fn() or nil
    fzf_lua_grep.live_grep(opts)
  end
end

local M = {}

M.filetypes = {
  typescript = types.ts,
  typescriptreact = types.ts,
  javascript = types.ts,
}

M.commands = {
  live_grep = live_grep(),
  grep_visual = live_grep(utils.get_visual_selection),
  grep_cword = live_grep(utils.get_cword),
}

return M
