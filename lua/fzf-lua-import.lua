local rg = require("rg")
local actions = require("actions")

local M = {
  config = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    previewer = false,
    multiprocess = true,
    hidden = false,
    prompt = "Imports> ",
  },
}

M.live_grep = function(opts)
  local fzf_lua = require("fzf-lua")
  opts = opts or M.config
  opts.actions = {
    ["default"] = actions.add_to_buffer,
  }
  return fzf_lua.fzf_live(function(q)
    local parsed_q = M.parse_query(q)
    return rg.rg_ts(parsed_q, opts.include_dirs)
  end, opts)
end

function M.setup(config)
  M.config = vim.tbl_deep_extend("keep", config or {}, M.config)

  vim.api.nvim_create_user_command(
    "Import", -- Command name
    M.live_grep, -- Function to execute
    {} -- Options (optional)
  )
  -- Hook into LSP
end

return M

-- TODO:
--   - Make work on function like :Import
--   - Register based on filetype
--   - Hook into LSP somehow
--   - Can we use the duplicate functionality in here and add into our code?
