local fzf_lua_grep = require("fzf-lua/providers/grep")

local types = {
  ts = {
    regex = "^import\\s*(type\\s+)?(\\*?\\s*\\{[^}]*%s[^}]*\\}|\\*?\\s*%s)\\s*from",
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
