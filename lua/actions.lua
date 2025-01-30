local utils = require("utils")

local M = {}

-- Places the import statement at the top of the file
-- Adds to the clipboard for additional usage
M.add_to_buffer = function(selected)
  utils.copy_to_register(selected[1])
  utils.paste_in_buffer(selected[1])
end

return M
