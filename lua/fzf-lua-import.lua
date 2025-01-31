local commands = require("config")
local utils = require("utils")
local actions = require("actions")
local make_entry = require("fzf-lua.make_entry")

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
      { key = "<leader>ci", mode = { "v" }, command = "grep_visual", enabled = true },
      { key = "<leader>cI", mode = { "v", "n" }, command = "grep_cword", enabled = true },
    },
  },
}

local create_rg_glob_fn = function(filetype_opts)
  local glob = string.format("--glob '*.{%s}'", table.concat(filetype_opts.glob, ","))

  return function(q)
    -- regex contains two placeholders
    local search = string.format(filetype_opts.regex, q, q)
    return search, glob
  end
end

-- Filter out duplicates
local create_fn_transform = function(opts)
  local results = {}

  return function(x)
    -- Every now and then clear the results
    if vim.tbl_count(results) > 1000 then
      results = {}
    end

    if results[x] == nil then
      results[x] = true
      return make_entry.file(x, opts)
    end
  end
end

M.import = function(opts)
  local command = commands.commands[opts.args]

  if command then
    local filetype = utils.get_filetype()
    local filetype_opts = commands.filetypes[filetype]

    if filetype_opts then
      command(vim.tbl_deep_extend("keep", {
        rg_glob_fn = create_rg_glob_fn(filetype_opts),
        fn_transform = create_fn_transform(M.config.fzf_lua_opts),
      }, M.config.fzf_lua_opts))
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
