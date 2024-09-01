
UserVars = {}
UserVars.__index = UserVars

-- TODO - these have to be set to a default
Ext.Vars.RegisterUserVariable("LOKE_GLASSES_GLASSES", {})
Ext.Vars.RegisterUserVariable("LOKE_GLASSES_TOGGLE", {})



---@param glasses table
---@param character string - uuid
function UserVars:AssignGlasses(glasses, character)
      local e = Ext.Entity.Get(character)
      e.Vars.LOKE_GLASSES_GLASSES = glasses
end


---@param character string - uuid
function UserVars:GetGlasses(character)
    local e = Ext.Entity.Get(character)
    return e.Vars.LOKE_GLASSES_GLASSES
end


---@param setting strin (on or off)
---@param character string - uuid
function UserVars:AssignGlassesSetting(setting, character)

    if (setting ~= "ON") and (setting ~= "OFF") then
        print(setting , " is not allowed. Choose ON or OFF")
        return
    end

    local e = Ext.Entity.Get(character)
    e.Vars.LOKE_GLASSES_TOGGLE = setting
end


---@param character string - uuid
function UserVars:GetGlassesSetting(character)
  local e = Ext.Entity.Get(character)
  return e.Vars.LOKE_GLASSES_TOGGLE
end

