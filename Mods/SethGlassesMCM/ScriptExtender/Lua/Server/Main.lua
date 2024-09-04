ORIGINS = {
    ["S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d"] = "Wyll",
    ["S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679"] = "ShadowHeart",
    ["S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12"] = "Laezel",
    ["S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255"] = "Astarion",
    ["S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604"] = "Gale",
    ["S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a"] = "Jaheira",
    ["S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba"] = "Minsc",
    ["S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c"] = "Karlach",
    ["S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b"] = "Minthara",
    ["S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323"] = "Halsin",
}



-- TODO: This works but MCM GUI doesn't update visuals -> wait for Volitio to answer
--> works with MCM v 1.10+ -> wait on release (MCM update should be next week)

-- This function was only possible thanks to Trips research
-- Triggers when Magic Mirror is spoken to

Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "before", function(character, itemTemplate, _, _)
    if (itemTemplate == "UNI_MagicMirror_72ae7a39-d0ce-4cb6-8d74-ebdf7cdccf91") then
        Mods.BG3MCM.MCMAPI:SetSettingValue("toggle_glasses", "On", ModuleUUID)
        Visuals:RetrieveAndApplyGlasses(character)
    end
end)



-- AEE support
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function(caster, spell, _, _, _)

    if spell == "Shout_Open_Mirror" then

        Mods.BG3MCM.MCMAPI:SetSettingValue("toggle_glasses", "On", ModuleUUID)
        Visuals:RetrieveAndApplyGlasses(caster)
    end
end)


local previouslyControlled 


Ext.Osiris.RegisterListener("GainedControl", 1, "after", function(target)  

    if Ext.Mod.IsModLoaded(mcmUUID) then

        local settingPreviouslyControlled
        local glassesPreviouslyControlled

        if previouslyControlled then
            -- save glasses of previously controlled character, but only if setting if toggled on

            local settingPreviouslyControlled = UserVars:GetGlassesSetting(previouslyControlled)
            glassesPreviouslyControlled =  Visuals:GetAllGlassesVisuals(previouslyControlled)

            if settingPreviouslyControlled == "ON" then
                UserVars:AssignGlasses(glassesPreviouslyControlled, previouslyControlled)
            end
        end

        local hasGlasses = UserVars:GetGlassesSetting(target)
        local currentGlasses = UserVars:GetGlasses(target)

        -- TODO - Astarion after using AEE and reloading does not count as shapeshifted
        -- and displays items Osi.Add. However they are getting added to his A override
        -- Yeah, this is an issue for all non  shapeshifted one. The regular addition seems broken
        
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



-- TODO - change Icon for spell container


local function giveBackGlasses(character)


    local hasGlasses = UserVars:GetGlassesSetting(character)
    local glasses = UserVars:GetGlasses(character)


    if glasses then
        if not(hasGlasses) or (hasGlasses == "ON") then
            Shapeshift:MakeEditable(character)
            Shapeshift:AddListOfVisuals(character, glasses)
            Shapeshift:RevertEditability(character)
        end
    end
end


local function getTheGang()

    local gang = {}
    
    local avatars = Osi.DB_Avatars:Get(nil)
    for i = #avatars, 1, -1 do
        table.insert(gang,avatars[i][1])
    end

    for uuid, name in pairs(ORIGINS) do
        table.insert(gang,uuid)
    end
    return gang
end

local function revertAEELoadedActions()

    local gang = getTheGang()
    for _, character in pairs(gang) do
        giveBackGlasses(character)
    end

end


local function revertAEESaveCleanup()
    
    local gang = getTheGang()

    for _, character in pairs(gang) do
        local glasses = Visuals:GetAllGlassesVisuals(character)
        local glassesChoice = UserVars:GetGlassesSetting(character)
        if glasses then

            -- If the glasses are off, we don't want to override the UserVars with empty ones
            if glassesChoice == "OFF" then
                return
            end
            UserVars:AssignGlasses(glasses, character)
        end

    end
end


-- TODO - test if this causes issues when AEE is not installed.
-- If yes just run this when SEE is detected


-- AEE yeets glasses. Add them again, Basically reverts AEEs cleanup 
Ext.Events.GameStateChanged:Subscribe(function(e)

    -- only seems necessary for shapeshifted

    -- If glasses toggled ON, reapply them from UserVars
    -- AEE yeets them



     -- ----------------------------- Loaded ------------------------------ --


     if e.FromState == "Sync" and e.ToState == "Running" then
        revertAEELoadedActions()
    end

    -- ----------------------------- Before Saving ------------------------------ --
    if e.FromState == "Running" and e.ToState == "Save" then
        revertAEESaveCleanup()
    
    -- -------------------------------- Post Save ------------------------------- --
    elseif e.FromState == "Save" and e.ToState == "Running" then
        revertAEELoadedActions()

       -- ------------------ Go back to main ------------------ --
    elseif e.FromState == "Running" and e.ToState == "UnloadLevel" then
        revertAEESaveCleanup()

        -- ------------------ Load save ------------------ --
        -- DB avatars doesn't exist here yet
    -- elseif e.FromState == "UnloadSession" and e.ToState == "LoadSession" then
    --     RevertAEESaveCleanup()
    -- end

    end


end)



Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)
    

    -- send message requesting tab being made invisible if DGB
    -- or to make visible if not
    Ext.Net.BroadcastMessage("ChangeVisibilityOfDGBTab",Ext.Json.Stringify({isDragonborn = IsDragonborn(Osi.GetHostCharacter())}))
    previouslyControlled = Osi.GetHostCharacter()


end)


-- TODO - move AEE stuff to AEE files


      
-- TODO - clicking Arms, Frame or chain on HIGH removes entire glasses 

-- TODO - UserVars only get saved when toggling on/off -> gotta use another method to
-- reapply visuals after AEE removes them -> save to UserVars before game saved etc.?


-- TODO - toggling glassess off and on on Astarion , then switching to Tav an dtoggling them off and on,
-- Then switching back to astarion yeets them. 
-- Probably because UserVars get overwritten on selecting character


-- TODO - Chain matching does not work for presets.. Probably a timer issue


-- TODO - remove arm and chain option for DGB and replace by test : "Not available for DGB"

-- TODO - Wyll /Tav might have reset on save / load and then entering convo. Seems to be related to saving and loading

-- TODO - toggle glasses ON if user chooses any visual (presses any button)

-- TODO - when having glasses toggled off, then saving, they seem to get lost