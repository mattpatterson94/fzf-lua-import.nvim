local commands = require("commands")
local utils = require("utils")

local M = {
  config = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    previewer = false,
    multiprocess = true,
    hidden = false,
    keys = {
      { key = "<leader>ci", mode = { "n" }, command = "live_grep", enabled = true },
      { key = "<leader>cI", mode = { "n" }, command = "grep_cword", enabled = true },
    },
  },
}

M.import = function(opts)
  local command = commands.commands[opts.args]
  local command_args = {
    filetype = utils.get_filetype(),
    cword = vim.fn.expand("<cword>"),
  }

  if command then
    command(M.config, command_args)
  else
    print("Unknown command: " .. opts.args)
  end
end

function M.setup(config)
  M.config = vim.tbl_deep_extend("keep", config or {}, M.config)

  -- Commands
  vim.api.nvim_create_user_command("FzfImport", M.import, {
    nargs = 1,
    complete = function(arg_lead)
      return vim.tbl_filter(function(val)
        return vim.startswith(val, arg_lead)
      end, vim.tbl_keys(commands.command))
    end,
  })

  -- Keymap
  for _, key in ipairs(M.config.keys) do
    if key.enabled then
      vim.keymap.set(
        key.mode,
        key.key,
        "<cmd>FzfImport " .. key.command .. "<CR>",
        { desc = "fzf-lua-import " .. key.command }
      )
    end
  end
end

return M

-- TODO:
--   - Can we use the duplicate functionality in here and add into our code?
