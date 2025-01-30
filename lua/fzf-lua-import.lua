local commands = require("commands")
local utils = require("utils")
local actions = require("actions")

local M = {
  config = {
    fzf_lua_opts = {
      git_icons = false,
      file_icons = false,
      color_icons = false,
      previewer = false,
      hidden = false,
      multiprocess = false,
      rg_opts = "--column --no-filename -n --no-heading --color=always --smart-case --no-column --no-line-number",
      glob_separator = "--",
      prompt = "Imports> ",
      rg_glob = true,
      actions = {
        ["default"] = actions.add_to_buffer,
      },
    },
    keys = {
      { key = "<leader>ci", mode = { "n" }, command = "live_grep", enabled = true },
      { key = "<leader>cI", mode = { "n" }, command = "grep_cword", enabled = true },
    },
  },
}

M.import = function(opts)
  local command = commands.commands[opts.args]

  if command then
    local filetype = utils.get_filetype()
    local filetype_opts = commands.filetypes[filetype]

    if filetype_opts then
      local local_opts = {
        rg_glob_fn = function(q)
          return filetype_opts.regex(q or ""),
            string.format("--glob '%s'", filetype_opts.glob(opts.include_dir))
        end,
      }
      command(vim.tbl_deep_extend("keep", local_opts, M.config.fzf_lua_opts))
    else
      return print("Unsupported filetype: " .. filetype)
    end
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
