------------------------------------------------------------------------------------------
---
---                   Handles Appearance Edit Enhanced Comaptibility
---                     
-------------------------------------------------------------------------------------------


-- get Avatars and Origins
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



-- Add glasses from UserVars
local function giveBackGlasses(character)


    local hasGlasses = UserVars:GetGlassesSetting(character)
    local glasses = UserVars:GetGlasses(character)


    if glasses then
        if not(hasGlasses) or (hasGlasses == "ON") then
            Shapeshift:MakeEditable(character)
            Shapeshift:AddListOfVisuals(character, glasses)
            Shapeshift:RevertEditability(character)
            Visuals:Replicate(character)
        end
    end
end



-- AAE removes visuals. Add them back
local function revertAEELoadedActions()

    local gang = getTheGang()
    for _, character in pairs(gang) do
        giveBackGlasses(character)
    end

end



-- AAE removes visuals. Add them back
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



-----------------------------------------------------------------------
---
---                          Listener
---
------------------------------------------------------------------------



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

    end

end)




-- AEE support
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function(caster, spell, _, _, _)

    if spell == "Shout_Open_Mirror" then

        Mods.BG3MCM.MCMAPI:SetSettingValue("toggle_glasses", "On", ModuleUUID)
        Visuals:RetrieveAndApplyGlasses(caster)
    end
end)
