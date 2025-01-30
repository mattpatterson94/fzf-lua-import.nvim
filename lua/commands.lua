local rg = require("rg")
local utils = require("utils")
local actions = require("actions")
local fzf_lua = require("fzf-lua")

local M = {}

M.live_grep = function(opts, cmd_args)
  opts = opts or {}
  opts.prompt = "Imports> "
  opts.actions = {
    ["default"] = actions.add_to_buffer,
  }

  local command = M.filetypes[cmd_args.filetype]

  if command then
    return fzf_lua.fzf_live(function(q)
      local query = utils.parse_query(q)
      return command(query, opts.include_dirs)
    end, opts)
  else
    return print("Unsupported filetype: " .. cmd_args.filetype)
  end
end

M.grep_cword = function(opts, cmd_args)
  opts = opts or {}
  local query = cmd_args.cword
  opts.prompt = "Imports matching " .. query .. "> "
  opts.actions = {
    ["default"] = actions.add_to_buffer,
  }

  local command = M.filetypes[cmd_args.filetype]

  if command then
    return fzf_lua.fzf_exec(command(query, opts.include_dirs), opts)
  else
    return print("Unsupported filetype: " .. cmd_args.filetype)
  end
end

M.filetypes = {
  typescript = rg.rg_ts,
  typescriptreact = rg.rg_ts,
  javascript = rg.rg_ts,
}

M.commands = {
  live_grep = M.live_grep,
  grep_cword = M.grep_cword,
}

return M
