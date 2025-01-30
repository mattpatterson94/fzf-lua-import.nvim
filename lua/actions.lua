local utils = require("utils")

local M = {}

-- Places the import statement at the top of the file
-- Adds to the clipboard for additional usage
M.add_to_buffer = function(selected)
  local line_to_add = selected[1]

  if not utils.line_exists_in_buffer(line_to_add) then
    utils.paste_in_buffer(line_to_add)
    utils.copy_to_register(line_to_add)
  else
    vim.notify("Import already in buffer. Skipping.")
  end
end

return M
