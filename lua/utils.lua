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

M.remove_duplicates = function(inputTable)
  local uniqueTable = {}
  local resultTable = {}

  for _, value in ipairs(inputTable) do
    if not uniqueTable[value] then
      uniqueTable[value] = true
      table.insert(resultTable, value)
    end
  end

  return resultTable
end

M.remove_entries = function(source_table, table_to_remove)
  local lookup = {}
  for _, value in ipairs(table_to_remove) do
    lookup[value] = true
  end
  local new_table = {}
  for _, value in ipairs(source_table) do
    if not lookup[value] then
      table.insert(new_table, value)
    end
  end
  return new_table
end

M.sort_by_frequency = function(inputTable)
  local frequencies = {}

  -- Count the frequencies of elements in the input table
  for _, value in ipairs(inputTable) do
    frequencies[value] = (frequencies[value] or 0) + 1
  end

  -- Create a table with pairs of elements and their frequencies
  local elementsAndFrequencies = {}
  for element, frequency in pairs(frequencies) do
    table.insert(elementsAndFrequencies, { element = element, frequency = frequency })
  end

  -- Sort the table based on frequencies in descending order
  table.sort(elementsAndFrequencies, function(a, b)
    return a.frequency > b.frequency
  end)

  local sortedTable = {}
  for _, pair in ipairs(elementsAndFrequencies) do
    for _ = 1, pair.frequency do
      table.insert(sortedTable, pair.element)
    end
  end

  return sortedTable
end

M.concat_tables = function(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

return M
