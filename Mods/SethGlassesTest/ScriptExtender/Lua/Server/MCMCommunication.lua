-- Big thanks to Volitio for MCM.  https://www.nexusmods.com/baldursgate3/mods/9162



function MCMGet(settingID)
    return Mods.BG3MCM.MCMAPI:GetSettingValue(settingID, ModuleUUID)
end




-- TODO - if user chooses any glasses part, set "Toggle ON " - else they just get overridden once  the user 
-- presses "On"

Ext.RegisterNetListener("MCM_Saved_Setting", function(call, payload)
    local data = Ext.Json.Parse(payload)
    if not data or data.modGUID ~= ModuleUUID or not data.settingId then
        return
    end


    -- TODO - these have to be set based on character (on character change) - else they stay on the same choice
    -- TODO  - block usage in MM
    if data.settingId == "toggle_glasses" then

        local character = Osi.GetHostCharacter()

        if data.value == "On" then
            Visuals:RetrieveAndApplyGlasses(character)
        elseif data.value == "Off" then
            Visuals:SaveAndRemoveGlasses(character)
        end
    end
end)










