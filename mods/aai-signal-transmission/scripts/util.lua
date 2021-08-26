local Util = {}

function Util.string_split (str, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function Util.string_join (str_table, sep)
  local str = ""
  for _, str_part in pairs(str_table) do
    if str ~= "" then
      str = str .. sep
    end
      str = str .. str_part
  end
  return str
end


function Util.dot_string_less_than(a, b, allow_equal)
  if allow_equal and a == b then return true end
  local a_parts = Util.string_split(a, ".")
  local b_parts = Util.string_split(b, ".")
  for i = 1, #a_parts do
    if tonumber(a_parts[i]) < tonumber(b_parts[i]) then
      return true
    elseif a_parts[i] ~= b_parts[i] then
      return false
    end
  end
  return false
end

function Util.dot_string_greater_than(a, b, allow_equal)
  if allow_equal and a == b then return true end
  local a_parts = Util.string_split(a, ".")
  local b_parts = Util.string_split(b, ".")
  for i = 1, #a_parts do
    if tonumber(a_parts[i]) > tonumber(b_parts[i]) then
      return true
    elseif a_parts[i] ~= b_parts[i] then
      return false
    end
  end
  return false
end


function Util.string_trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

return Util
