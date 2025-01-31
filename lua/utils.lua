local fzf_lua_utils = require("fzf-lua/utils")

local M = {}

M.parse_query = function(query)
  return fzf_lua_utils.rg_escape(query or "")
end

M.copy_to_register = function(text, register)
  vim.fn.setreg(register or "+", text)
end

M.paste_in_buffer = function(text, line_number, buffer)
  local line = line_number or 1
  local current_buffer = 0
  vim.api.nvim_buf_set_lines(buffer or current_buffer, line, line, false, { text })
end

M.get_filetype = function()
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.bo[bufnr].filetype
end

M.line_exists_in_buffer = function(line, buffer)
  local current_buffer = 0
  local lines = vim.api.nvim_buf_get_lines(buffer or current_buffer, 0, -1, false)
  for _, l in ipairs(lines) do
    if l == line then
      return true
    end
  end
  return false
end

M.get_visual_selection = function()
  return fzf_lua_utils.get_visual_selection()
end

M.get_cword = function()
  return vim.fn.expand("<cword>")
end

return M
