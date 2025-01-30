local rg = require("rg")
local utils = require("utils")
local actions = require("actions")
local fzf_lua = require("fzf-lua")

local M = {}

M.live_grep = function(opts, filetype)
  opts = opts or {}
  opts.prompt = "Imports> "
  opts.actions = {
    ["default"] = actions.add_to_buffer,
  }

  local command = M.filetypes[filetype]

  if command then
    return fzf_lua.fzf_live(function(q)
      local parsed_q = utils.parse_query(q)
      return command(parsed_q, opts.include_dirs)
    end, opts)
  else
    return print("Unsupported filetype: " .. filetype)
  end
end

M.filetypes = {
  typescript = rg.rg_ts,
  typescriptreact = rg.rg_ts,
  javascript = rg.rg_ts,
}

M.commands = {
  live_grep = M.live_grep,
  grep_cword = M.live_grep,
}

return M
