-- Big thanks to Volitio for MCM.  https://www.nexusmods.com/baldursgate3/mods/9162

ModuleUUID = "dbdea5b5-a48c-4ea2-b3cb-32ba079e09d4"

function MCMGet(settingID)
    return Mods.BG3MCM.MCMAPI:GetSettingValue(settingID, ModuleUUID)
end



-- Toggling Glases on and off
-- This way is a bit janky, but I wanted to try out MCM 
Ext.ModEvents.BG3MCM["MCM_Setting_Saved"]:Subscribe(function(payload)
    if not payload or payload.modUUID ~= ModuleUUID or not payload.settingId then
        return
    end


    -- TODO  - block usage in MM
    if payload.settingId == "toggle_glasses" then

        local character = Osi.GetHostCharacter()

        if payload.value == "On" then
        
            Shapeshift:MakeEditable(character)
            Visuals:RetrieveAndApplyGlasses(character)
            Shapeshift:RevertEditability(character)
            Visuals:Replicate(character)

            UserVars:AssignGlassesSetting("ON", character)

        elseif payload.value == "Off" then

            
            Shapeshift:MakeEditable(character)
            Visuals:SaveAndRemoveGlasses(character)
            Shapeshift:RevertEditability(character)
            Visuals:Replicate(character)

            UserVars:AssignGlassesSetting("OFF", character)

        end
    end
end)

