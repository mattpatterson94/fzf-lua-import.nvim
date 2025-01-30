local rg = require("rg")
local fzf_lua_grep = require("fzf-lua/providers/grep")

local M = {}

M.filetypes = {
  typescript = rg.rg_ts_opts,
  typescriptreact = rg.rg_ts_opts,
  javascript = rg.rg_ts_opts,
}

M.commands = {
  live_grep = fzf_lua_grep.live_grep_st,
  grep_cword = fzf_lua_grep.grep_cword,
}

return M
