local TGlib = {}

local showlog = false     -- Debug log message toggle

function TGlib.debuglog(msg)
  if showlog then log(msg) end
  return showlog
end



function TGlib.check_set_value(entry, prop, val)
  if entry then
    if type(prop) == "table" then
      if #prop > 1 then
        TGlib.debuglog("  At lv "..#prop.. ": "..prop[1])
        return TGlib.check_set_value(entry[prop[1]], {table.unpack(prop,2)}, val)
      else
        TGlib.debuglog("    Set "..prop[1].. " = `"..tostring(val).."`")
        entry[prop[1]] = val
        return true
      end
    else
      TGlib.debuglog("    Set "..prop.. " = `"..tostring(val).."`")
      entry[prop] = val
      return true
    end
  else
    if type(prop) == "table" then
      log("Failed to set prop `"..prop[1].."` = `"..tostring(val).."`")
    else
      log("Failed to set prop `"..prop.."` = `"..tostring(val).."`")
    end
    return false
  end
end



return TGlib