

-- If people toggle glasses off, then go to the MM and equip new ones, 
-- then toggle them on again, they will get layered
-- also bricks MM

-- TODO: This works but MCM GUI doesn't update visuals -> wait for Volitio to answer


-- This function was only possible thanks to Trips research
-- Triggers when Magic Mirror is spoken to

Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "before", function(character, itemTemplate, _, _)
    if (itemTemplate == "UNI_MagicMirror_72ae7a39-d0ce-4cb6-8d74-ebdf7cdccf91") then
        -- Mods.BG3MCM.MCMAPI:SetSettingValue("toggle_glasses", "On", ModuleUUID)
        -- Visuals:RetrieveAndApplyGlasses(character)
    end
end)




-- TODO - some issues with that, but should be solved once I can control the radio button 

-- After MM is done, override the saved glasses
-- Purge them on going into MM,  as we apply the glasses anyways
-- The override on going back 
Ext.Osiris.RegisterListener("ChangeAppearanceCompleted", 1, "after", function(character)
    -- print("ChangeAppearanceCompleted")

    -- -- clear old user vars and assign the new ones
    -- Ext.Timer.WaitFor(200, function ()
    --     print("timer 200 ms")
    --     local newGlasses = Visuals:GetAllGlassesVisuals(character)
    --     _D(newGlasses)
    --     UserVars:AssignGlasses(newGlasses, character)
    --     print("uservars ")
    --     _D(UserVars:GetGlasses(character))
    -- end)
end)

Ext.Osiris.RegisterListener("ChangeAppearanceCancelled", 1, "after", function(character)
    -- print("ChangeAppearanceCancelled")

    -- Ext.Timer.WaitFor(200, function ()
    --     local newGlasses = Visuals:GetAllGlassesVisuals(character)
    --     _D(newGlasses)
    --     UserVars:AssignGlasses(newGlasses, character)
    -- end)


end)