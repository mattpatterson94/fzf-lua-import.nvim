local rg = require("rg")
local utils = require("utils")
local actions = require("actions")
local fzf_lua = require("fzf-lua")
local fzf_lua_grep = require("fzf-lua/providers/grep")

local M = {}

M.live_grep = function(opts, cmd_args)
  opts = opts or {}
  opts.prompt = "Imports> "
  opts.actions = {
    ["default"] = actions.add_to_buffer,
  }

  local filetype_opts = M.filetypes[cmd_args.filetype]

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
  opts.prompt = string.format("Imports matching %s>", query)
  opts.actions = {
    ["default"] = actions.add_to_buffer,
  }

  opts.no_esc = true

  local filetype_opts = M.filetypes[cmd_args.filetype]

  if filetype_opts then
    opts.search = filetype_opts.regex(query)
    opts.rg_opts =
      string.format("%s --glob '%s'", opts.rg_opts, filetype_opts.glob(opts.include_dir))

    return fzf_lua_grep.grep(opts)
  else
    return print("Unsupported filetype: " .. cmd_args.filetype)
  end
end

M.filetypes = {
  typescript = rg.rg_ts_opts,
  typescriptreact = rg.rg_ts_opts,
  javascript = rg.rg_ts_opts,
}

M.commands = {
  live_grep = M.live_grep,
  grep_cword = M.grep_cword,
}

return M
