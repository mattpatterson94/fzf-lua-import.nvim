local fzf_lua_grep = require("fzf-lua/providers/grep")

local types = {
  ts = {
    -- eg. import { MyModule } from 'lib/my_module';
    -- eg. import * as mobx from 'mobx'
    -- eg. import styles from "myfile.css"
    -- does not match relative paths like import styles from "./myfile.css" (can be disabled by removing the \w at the end)
    regex = "^import\\s*(type\\s+)?(\\*?\\s*\\{[^}]*%s[^}]*\\}|\\*?\\s*%s)\\s*from\\s[\\\"\\']\\w",
    glob = { "ts", "tsx", "js", "jsx" },
  },
}

local M = {}

M.filetypes = {
  typescript = types.ts,
  typescriptreact = types.ts,
  javascript = types.ts,
}

M.commands = {
  live_grep = fzf_lua_grep.live_grep,
  grep_cword = fzf_lua_grep.grep_cword,
}

return M
