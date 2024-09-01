-- Big thanks to Volitio for MCM.  https://www.nexusmods.com/baldursgate3/mods/9162

ModuleUUID = "dbdea5b5-a48c-4ea2-b3cb-32ba079e09d4"

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

    print("MCM_Saved_Setting received ", data.value) -- this works in the public version but not in the one you sent


    -- TODO - these have to be set based on character (on character change) - else they stay on the same choice
    -- TODO  - block usage in MM
    if data.settingId == "toggle_glasses" then

        local character = Osi.GetHostCharacter()

        -- TODO - assigning glasses settings might screw stuff up
        if data.value == "On" then
        
            Shapeshift:MakeEditable(character)
            Visuals:RetrieveAndApplyGlasses(character)
            Shapeshift:RevertEditability(character)

            UserVars:AssignGlassesSetting("ON", character)

        elseif data.value == "Off" then
            
            Shapeshift:MakeEditable(character)
            Visuals:SaveAndRemoveGlasses(character)
            Shapeshift:RevertEditability(character)

            UserVars:AssignGlassesSetting("OFF", character)

        end
    end
end)




-- After applying, get visuals. If there is no glasses, the set Glasses to Off
-- if there are, set them to on


-- TODO - also swap settings when  controlled character is switched.
-- save "actual" settings in UserVars








