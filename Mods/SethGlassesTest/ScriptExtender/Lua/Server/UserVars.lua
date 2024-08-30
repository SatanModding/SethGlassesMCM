
UserVars = {}
UserVars.__index = UserVars

-- TODO - these have to be set to a default
Ext.Vars.RegisterUserVariable("LOKE_GLASSES", {})



---@param glasses table
---@param character string - uuid
function UserVars:AssignGlasses(glasses, character)
      local e = Ext.Entity.Get(character)
      e.Vars.LOKE_GLASSES = glasses
end


---@param character string - uuid
function UserVars:GetGlasses(character)
    local e = Ext.Entity.Get(character)
    return e.Vars.LOKE_GLASSES
end

