local M = {}
require 'table'

function M.get_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

function M.get_values(t)
  if not t then
    return {}
  end
  local values = {}
  for _, val in pairs(t) do
    table.insert(values, val)
  end
  return values
end

function M.concat_tables(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

return M
