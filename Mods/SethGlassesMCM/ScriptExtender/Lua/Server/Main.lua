
local previouslyControlled 



-- Control visibility of High glasses tab (has to be hidden for Dragonborn Tab)
-- On switching character
Ext.Osiris.RegisterListener("GainedControl", 1, "after", function(target)  

    if Ext.Mod.IsModLoaded(MCMUUID) then

        local settingPreviouslyControlled
        local glassesPreviouslyControlled

        if previouslyControlled then
            -- save glasses of previously controlled character, but only if setting if toggled on

            settingPreviouslyControlled = UserVars:GetGlassesSetting(previouslyControlled)
            glassesPreviouslyControlled =  Visuals:GetAllGlassesVisuals(previouslyControlled)

            if settingPreviouslyControlled == "ON" then
                UserVars:AssignGlasses(glassesPreviouslyControlled, previouslyControlled)
            end
        end

        local hasGlasses = UserVars:GetGlassesSetting(target)
        local currentGlasses = UserVars:GetGlasses(target)


        
        if not(hasGlasses) or (hasGlasses == "ON") then
            Mods.BG3MCM.MCMAPI:SetSettingValue("toggle_glasses", "On", ModuleUUID)
        else
            Mods.BG3MCM.MCMAPI:SetSettingValue("toggle_glasses", "Off", ModuleUUID)

            -- override UserVars change 
            if hasGlasses == "OFF" then

                UserVars:AssignGlasses(currentGlasses, target)

            end
            
        end

        -- send message requesting tab being made invisible if DGB
        -- or to make visible if not
        Ext.Net.BroadcastMessage("ChangeVisibilityOfDGBTab",Ext.Json.Stringify({isDragonborn = IsDragonborn(target)}))

        previouslyControlled = target

    end
end)




-- Control visibility of High glasses tab (has to be hidden for Dragonborn Tab)
-- On loading save
Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)
    
    -- send message requesting tab being made invisible if DGB
    -- or to make visible if not
    Ext.Net.BroadcastMessage("ChangeVisibilityOfDGBTab",Ext.Json.Stringify({isDragonborn = IsDragonborn(Osi.GetHostCharacter())}))
    previouslyControlled = Osi.GetHostCharacter()

end)




-- This function was only possible thanks to Trips research
-- Triggers when Magic Mirror is spoken to

Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "before", function(character, itemTemplate, _, _)
    if (itemTemplate == "UNI_MagicMirror_72ae7a39-d0ce-4cb6-8d74-ebdf7cdccf91") then
        Mods.BG3MCM.MCMAPI:SetSettingValue("toggle_glasses", "On", ModuleUUID)
        Visuals:RetrieveAndApplyGlasses(character)
    end
end)

