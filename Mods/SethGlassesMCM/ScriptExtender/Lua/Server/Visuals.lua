
-------------------------------------------------------------------------------------------------------------
---
---                                 For Handling Visuals (CCAV/CCSV)
---                              For entities that are of GameObjectType = 0    
---                           They pull from entity.CharacterCreationAppearance.Visuals
--- 
------------------------------------------------------------------------------------------------------------



Visuals = {}
Visuals.__index = Visuals


TYPES = {
    "FRAME",
    "ARMS",
    "LENSES",
    "CHAINS_MAIN",
    "CHAINS_LEFT_1",
    "CHAINS_RIGHT_1",
    "CHAINS_RIGHT_2",
    "CHARM_LEFT_1",
    "CHARM_RIGHT_1",
    "CHARM_RIGHT_2"
}



SIZES = {
    "HIGH",
    "LOW",
}

-- TODO - instead of calling Osi.AddCustomVisualOverride or Osi.RemoveCustomVisualOvirride
-- insert into the visuals table and call replicate to reduce flickering


function Visuals:Replicate(character)
    local entity = Ext.Entity.Get(character)

    Ext.Timer.WaitFor(600, function() 
        entity:Replicate("CharacterCreationAppearance")
    end)
    
end


-- I kept the typo for consistency, and because it's funny
---@param character string - uuid
---@return visual string - uuid
function Visuals:BetterRemoveVisualOvirride(character, visual)

    local entity = Ext.Entity.Get(character)
    local visuals = {}

    for _, entry in pairs(entity.CharacterCreationAppearance.Visuals) do
        if not (entry == visual) then
            table.insert(visuals,entry)
        end
    end

    entity.CharacterCreationAppearance.Visuals = visuals
end



---@param character string - uuid
function Visuals:BetterAddVisualOverride(character, visual)

    Ext.Timer.WaitFor(100, function ()

        local entity = Ext.Entity.Get(character)                    
        local visuals = {}

        for _, entry in pairs(entity.CharacterCreationAppearance.Visuals) do
            table.insert(visuals,entry)
        end

        -- this is specifically for my glasses mod. I add a "none" visual uuid 
        -- but the entity doesn't like it. Doesn't hurt to keep it in here but
        -- not necessary for your project
        if not (visual == "none")  then
            table.insert(visuals, visual)
            entity.CharacterCreationAppearance.Visuals = visuals
        end
        
    end)

end



-- adds a whole list of visuals with Osi.AddCustomVisualOverride for convenience
---@param character string -uuid
---@param listToAdd table 
function Visuals:AddListOfVisuals(character, listToAdd)
  
    if listToAdd then

        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:AddListOfVisuals(character, listToAdd)
        else
            for _, entry in pairs(listToAdd) do
                Visuals:BetterAddVisualOverride(character, entry)
            end
        end
    end
end


-- removes a whole list of visuals with Osi.RemoveCustomVisualOvirride for convenience
---@param character string -uuid
---@param listToRemove table 
function Visuals:RemoveListOfVisuals(character, listToRemove)

    if listToRemove then

        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:RemoveListOfVisuals(character, listToRemove)
        else

            for _, entry in pairs(listToRemove) do
                Osi.RemoveCustomVisualOvirride(character, entry)
            end
        
        end
    end
end


-- returns the table of allowed glasses
-- only Dragonborns are special
---@param character string -uuid
---@return allowedGlasses table -- 
function Visuals:GetAllowedGlasses(character)

    if IsDragonborn(character) then
        return{LOKE_DGB_GLASSES}
    else
        return {LOKE_HUMAN_GLASSES}
    end
end


---@param character string - uuid
---@return visuals table
function Visuals:GetAllVisuals(character)

    local entity = Ext.Entity.Get(character)

    -- if they don't have a CCA entry, they are an NPC and need to have one created
    local cca = Helper:GetPropertyOrDefault(entity,"CharacterCreationAppearance", nil)


    if Shapeshift:IsShapeshifted(character) then 
        return Shapeshift:GetAllVisuals(character)
    else

        if cca then
            return cca.Visuals
        end
    end
end





-- returns all visuals that the chracter is allowed to have of a certain type (ex: all dgb lenses)
---@param character string - uuid
---@param type string -- enum
---@param size string -- enum
---@return table -- table of uuids
function Visuals:GetAllowedVisualsOfType(character, type, size)

    local allowedVisuals = {}
    
    --DGB or other
    local allowedGlasses =  Visuals:GetAllowedGlasses(character)

    for _, content in pairs(allowedGlasses) do
        for name, entry in pairs(content) do
            if name == type then
                for _, package in pairs(entry) do
                    if size == "LOW" then
                        table.insert(allowedVisuals, package.uuidLow)
                    else 
                        table.insert(allowedVisuals, package.uuidHigh) --this includes dgb
                    end
                end
            end
        end
    end
    return allowedVisuals
end


-- returns all visuals that are Lokes glasses that are currently equipped on the character
---@param character string - uuid
function Visuals:GetAllGlassesVisuals(character)

    local glasses = {}
    local listToSearch = Visuals:GetAllowedGlasses(character)

    local allVisuals = Visuals:GetAllVisuals(character)

    if allVisuals then

        for _, visual in pairs(allVisuals) do
            for _, content in pairs(listToSearch) do
                for name, entry in pairs(content) do
                    for _, package in pairs(entry) do
                        if (package.uuidLow == visual) or (package.uuidHigh == visual) then
                            table.insert(glasses, visual)
                        end
                    end
                end
            end
        end
    end
    return glasses
end


-- saves glasses in UserVars
---@param character string - uuid
function Visuals:SaveAndRemoveGlasses(character)

    local currentGlasses = Visuals:GetAllGlassesVisuals(character)
    UserVars:AssignGlasses(currentGlasses, character)
    Visuals:RemoveListOfVisuals(character, currentGlasses)
    
end


---@param character string - uuid
function Visuals:RetrieveAndApplyGlasses(character)

    -- if user has chosen any pther glasses visual, remove it before applying
    -- the saved glasses

    -- but only if there is a value in the UserVars.
    -- Else they get removed if glasses have been applied via the MM
    local userVars = UserVars:GetGlasses(character)
    if userVars then
        local currentGlasses = Visuals:GetAllGlassesVisuals(character)
        Visuals:RemoveListOfVisuals(character, currentGlasses)
    end
   

    local glassesToApply = UserVars:GetGlasses(character)
    Visuals:AddListOfVisuals(character, glassesToApply)
end


-- Get the High version of a Low visual or vice versa
---@param visual string - uuid of visual
---@param size string - enum
---@return oppositeVisual uuid
function Visuals:GetOtherVersion(visual, size)

    -- not for DGBs
    for name, entry in pairs(LOKE_HUMAN_GLASSES) do
        for _, package in pairs(entry) do
            if size == "LOW" then
                if package.uuidHigh == visual then
                    return package.uuidLow
                end
            elseif size =="HIGH" then
                if package.uuidLow == visual then
                    return package.uuidHigh
                end
            end
        end
    end
end



-- Get the Low version of a High visual
---@param visual string - uuid of visual
---@return oppositeVisual uuid
function Visuals:GetLowVersion(visual)
    return Visuals:GetOtherVersion(visual, "LOW")
end

-- Get the High version of a Low visual
---@param visual string - uuid of visual
---@return oppositeVisual uuid
function Visuals:GetHighVersion(visual)
    return Visuals:GetOtherVersion(visual, "HIGH")
end



-- swap all visuals of type low to high or vice versa
---@param visual string - uuid of visual
---@param size string - enum - the one we want to swap to
function Visuals:SwapGlasses(character, size)


    if IsDragonborn(character) then
        return
    end

    local oppositeVisual = {}

    -- get all currently equipped glasses component
    local currentlyEquippedGlasses = Visuals:GetAllGlassesVisuals(character)

    -- for each visual, if it is a glasses component, get the opposite one
    for _, glassesPart in pairs(currentlyEquippedGlasses) do
        local opposite = Visuals:GetOtherVersion(glassesPart, size)
        table.insert(oppositeVisual, opposite)
    end



    if Shapeshift:IsShapeshifted(character) then 

        -- remove old glasses components
        for _, v in pairs(currentlyEquippedGlasses) do
            Shapeshift:RemoveCustomVisualOvirride(character, v)
        end

        -- add new glasses components
        for _, w in pairs(oppositeVisual) do
            Shapeshift:AddCustomVisualOverride(character, w)
        end
	else
        -- Not Shapeshifted

           -- remove old glasses components
        for _, v in pairs(currentlyEquippedGlasses) do
            Osi.RemoveCustomVisualOvirride(character, v)
        end

        -- add new glasses components
        for _, w in pairs(oppositeVisual) do
            Visuals:BetterAddVisualOverride(character, w)
        end

    end

    
 
end



-- swap all visuals of type low to high
function Visuals:SwapLowForHigh(character)
    Visuals:SwapGlasses(character, "HIGH")
    
end


-- swap all visuals of type high to low
function Visuals:SwapHighForLow(character)
    Visuals:SwapGlasses(character, "LOW")
   
end




---@param character string - uuid
---@param type string
---@return bool
function Visuals:HasGlassesEntryOfType(character, type)

    local tableToSearch = Visuals:GetAllowedGlasses(character)
    local allVisuals = Visuals:GetAllVisuals(character)


   for _, content in pairs (tableToSearch) do
        for name, entry in pairs(content) do
            if name == type then
                for _, package in pairs(entry) do
                    if Table:Contains(allVisuals, package.uuidLow) or Table:Contains(allVisuals, package.uuidHigh) then
                        return true
                    end
                end
            end
        end
    end
end




-- returns the uuid of a certain type if the characters wears it
---@param character string - uuid
---@param type string
---@return string uuid
function Visuals:GetGlassesEntryOfType(character, type)
    local tableToSearch = Visuals:GetAllowedGlasses(character)
    local allVisuals = Visuals:GetAllVisuals(character)

    for _, content in pairs (tableToSearch) do
        for name, entry in pairs(content) do
            if name == type then
                for _, package in pairs(entry) do
                    if Table:Contains(allVisuals, package.uuidLow) then
                        return package.uuidLow
                    elseif Table:Contains(allVisuals, package.uuidHigh) then
                        return package.uuidHigh
                    end
                end
            end
        end
    end
end





---@param character string - uuid
---@param type string -- enum
---@param newVisual string -- uuid
function Visuals:SwapVisuals(character, type, newVisual)


    local currentVisual = Visuals:GetGlassesEntryOfType(character, type)

   if currentVisual then 
        SatanPrint(GLOBALDEBUG, "currentVisual ".. currentVisual)
   else
        SatanPrint(GLOBALDEBUG, "no current visual")
   end

   if currentVisual then
        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:RemoveCustomVisualOvirride(character, currentVisual)
        end
    end

    
    -- if the new visual is of type none, only remove, don't add 
    if newVisual then 
        -- I probably use both of these for some reason
        if not (newVisual == "none") then

            SatanPrint(GLOBALDEBUG, "visual type is not none but " .. newVisual)

            if Shapeshift:IsShapeshifted(character) then 
                Shapeshift:AddCustomVisualOverride(character, newVisual)
            else
                Visuals:BetterRemoveVisualOvirride(character, currentVisual)
                Visuals:BetterAddVisualOverride(character, newVisual)
            end
        else
            if not Shapeshift:IsShapeshifted(character) then
                Visuals:BetterRemoveVisualOvirride(character, currentVisual)
            end
        end
    end
end


---@param character string - uuid
function Visuals:GiveVisualComponentIfHasNone(character)

    local entity = Ext.Entity.Get(character)

    -- if they don't have a CCA entry, they are an NPC and need to have one created
    local cca = Helper:GetPropertyOrDefault(entity,"CharacterCreationAppearance", nil)

    if not cca then
        entity:CreateComponent("CharacterCreationAppearance")
        -- TODO - check if we need to replicate after giving visual
        entity:Replicate("GameObjectVisual")
    end
end



-- TODO - this can be deleted after everything is on MCM
local glassesChoice = {} -- resets on console reset.


-- cycles through visuals
---@param character string - uuid
---@param type string -- enum
---@return visual string -- uuid
function Visuals:GetNextVisual(character, type, size)

    local permittedVisuals = Visuals:GetAllowedVisualsOfType(character, type, size)

    -- if there already is an entry
    if glassesChoice.character == character and glassesChoice.type == type and glassesChoice.size == size then

        -- Increment the index, wrap around if necessary
        glassesChoice.index = (glassesChoice.index % #permittedVisuals) + 1
    
    -- add entry
    else
        glassesChoice = {character = character, type = type, size = size, index = 1}
    end

    local selectedGlassesComponent = permittedVisuals[glassesChoice.index]
    return selectedGlassesComponent
    
end

    


--@param type -    "CHARM_LEFT_1" "CHARM_RIGHT_1" "CHARM_RIGHT_2"
function Visuals:GetChainForCharm(type, size)

    local MATCH = {

    ["CHARM_LEFT_1"] = "CHAINS_LEFT_1",
    ["CHARM_RIGHT_1"] = "CHAINS_RIGHT_1",
    ["CHARM_RIGHT_2"] = "CHAINS_RIGHT_2"
    }

    local tableToSearch
    if size == "DGB" then 
        tableToSearch = LOKE_DGB_GLASSES
    else 
        tableToSearch = LOKE_HUMAN_GLASSES
    end

    for name, entry in pairs(tableToSearch) do
        if name == MATCH[type] then
            if size == "LOW" then
                return entry[1].uuidLow
            else
                return entry[1].uuidHigh
            end
        end
    end
end



-- add left chain if there is  a left charm
-- add right chain if there is a right charm
-- add right chain 2 if there is a right charm
-- remove left chain if there is  no left charm
-- remove right chain if there is no right charm
-- remove right chain 2 if there is no right charm

-- main chain is optional. Can be chosen at will
-- Do not allow chains to be chosen by themselces, they are always part of left charm, right charm or right charm 2
function Visuals:MatchChain(character)

   -- print("Matching Chain ")

    local size = Visuals:GetCurrentGlassesSizeCharacter(character)
    if IsDragonborn(character) then
        size = "DGB"
    end

   -- print("size is ", size)

    local chainLeft = Visuals:GetChainForCharm("CHARM_LEFT_1",size)
    local chainright1 = Visuals:GetChainForCharm("CHARM_RIGHT_1",size)
    local chainright2 = Visuals:GetChainForCharm("CHARM_RIGHT_2", size)

   -- print("chain left ", chainLeft)
   -- print("chain right ", chainright1)
   -- print("chain right 2 ", chainright2)


  

   if Visuals:HasGlassesEntryOfType(character,"CHARM_LEFT_1") then
    --  print("HAS CHARMS LEFT")

        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:AddCustomVisualOverride(character, chainLeft)
        else
            Visuals:BetterAddVisualOverride(character, chainLeft)
        end
    
    elseif Visuals:HasGlassesEntryOfType(character,"CHAINS_LEFT_1")then
    --  print("HAS NO CHARMS LEFT BUT A CHAIN")

        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:RemoveCustomVisualOvirride(character, chainLeft)  -- Using the typo
        else
            Osi.RemoveCustomVisualOvirride(character, chainLeft)  -- Using the typo
        end
    end


    if Visuals:HasGlassesEntryOfType(character,"CHARM_RIGHT_1")  then
        --  print("HAS CHARMS RIGHT")

        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:AddCustomVisualOverride(character, chainright1)
        else
            Visuals:BetterAddVisualOverride(character, chainright1)
        end

    elseif Visuals:HasGlassesEntryOfType(character,"CHAINS_RIGHT_1")then
        --  print("HAS NO CHARMS RIGHT BUT A CHAIN")

        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:RemoveCustomVisualOvirride(character, chainright1)  
        else
            Osi.RemoveCustomVisualOvirride(character, chainright1) 
        end

    end


    if Visuals:HasGlassesEntryOfType(character,"CHARM_RIGHT_2") then
        -- print("HAS CHARMS RIGHT 2")

        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:AddCustomVisualOverride(character, chainright2)
        else
            Visuals:BetterAddVisualOverride(character, chainright2)
        end

    elseif Visuals:HasGlassesEntryOfType(character,"CHAINS_RIGHT_2")then
        --  print("HAS NO CHARMS RIGHT 2 BUT A CHAIN")

        if Shapeshift:IsShapeshifted(character) then 
            Shapeshift:RemoveCustomVisualOvirride(character, chainright2)  
        else
            Osi.RemoveCustomVisualOvirride(character, chainright2)  
        end
    end
end




function Visuals:GetCurrentGlassesSizeCharacter(character)

    local currenGlassesVisuals = Visuals:GetAllGlassesVisuals(character)
    local sample = currenGlassesVisuals[1]
    local tableToSearch = Visuals:GetAllowedGlasses(character)
    

    for _, content in pairs (tableToSearch) do
        for name, entry in pairs(content) do
            for _, package in pairs(entry) do
                if sample == package.uuidLow then
                    return "LOW"
                end

                if sample == package.uuidHigh then
                    return "High"
                end
            end
        end
    end
end



function Visuals:GetCurrentGlassesSizeVisual(visual)

    local allTables = {LOKE_HUMAN_GLASSES, LOKE_DGB_GLASSES}

    for _,tableToSearch in pairs(allTables) do
        for name, entry in pairs(tableToSearch) do
            for _, package in pairs(entry) do
                if visual == package.uuidLow then
                    return "LOW"
                end

                if visual == package.uuidHigh then
                    return "High"
                end
            end
        end
    end
end



function Visuals:DifferentSize(currentGlassVisuals, anotherVisual)

    if not currentGlassVisuals then
        return
    end

    --_D(currentGlassVisuals)

    local sizeA = Visuals:GetCurrentGlassesSizeVisual(currentGlassVisuals[1])
    local sizeB = Visuals:GetCurrentGlassesSizeVisual(anotherVisual)

    --print("sizeA ", sizeA)
    --print("sizeB ", sizeB)

    if sizeA == sizeB then
        return false
    else
        return true
    end

end





-- returns visual of certain style, type and size
---@param style string - PIXIE_KILLER
---@param type string - LENSES
---@param size string - LOW, HIGH, DGB
function Visuals:GetVisual(style, type, size)


    local tableToSearch = LOKE_HUMAN_GLASSES

    if size == "DGB" then
        tableToSearch = LOKE_DGB_GLASSES
    end


    if style then

        for typeName, entry in pairs(tableToSearch) do
            if typeName == type then
                for _, package in pairs(entry) do
                if Helper:StringContains(package.name, style) then
                    if size == "LOW" then
                            return package.uuidLow
                    else
                            return package.uuidHigh
                        end
                    end
                end
            end
        end


    else

        -- if style is nil then we have Frame, Arm or chain main.
        -- In this case return the first entry, as there is no style


        for typeName, entry in pairs(tableToSearch) do
            if typeName == type then
                for _, package in pairs(entry) do
                    if size == "LOW" then
                        return entry[1].uuidLow
                    else
                        return entry[1].uuidHigh
                    end
                end
                
            end
        end


    end

end



-- return a preset designed by lokelani
---@param style enum ["PIXIE_KILLER", "NONE"]   
---@param size enum ["LOW", "HIGH" "DGB"]   
function Visuals:GetPresetVisuals(style, size)

    local presetVisuals = {}
    local tableToSearch



    -- always add: "Frame", "Arms" and "Chain Main"
    -- for DGB add "FRAME"
    if size == "DGB" then
        tableToSearch = LOKE_DGB_GLASSES
        table.insert(presetVisuals, Visuals:GetVisual(nil, "FRAME", size))
    else
        tableToSearch = LOKE_HUMAN_GLASSES
        table.insert(presetVisuals, Visuals:GetVisual(nil, "FRAME", size))
        table.insert(presetVisuals, Visuals:GetVisual(nil, "ARMS", size))
        table.insert(presetVisuals, Visuals:GetVisual(nil, "CHAINS_MAIN", size))
    end



    for typeName, entry in pairs(tableToSearch) do
        for _, package in pairs(entry) do
        if Helper:StringContains(package.name, style) then
            if size == "LOW" then
                table.insert(presetVisuals,package.uuidLow)
            else
                table.insert(presetVisuals,package.uuidHigh)
                end
            end
        end
    end

    return presetVisuals

end


-- equip a preset designed by lokelani
---@param character string
---@param style enum ["PIXIE_KILLER", "NONE"]   
---@param size enum ["LOW", "HIGH"m "DGB"]   
function Visuals:EquipPreset(character, style, size)


    -- remove current glasses
    local currentlyEquippedGlasses = Visuals:GetAllGlassesVisuals(character)
    Visuals:RemoveListOfVisuals(character, currentlyEquippedGlasses)
    

    Ext.Timer.WaitFor(200, function ()

        if not (style == "NONE") then
            -- get all preset visuals
            local presetVisuals = Visuals:GetPresetVisuals(style, size)
    
            -- equip all preset visuals 
            Visuals:AddListOfVisuals(character, presetVisuals)

            Ext.Timer.WaitFor(300, function ()
                Visuals:MatchChain(character)
                
            end)
        end
    
        
    end)
  
    
end



-- TODO - some visuals seem to get stuck sometimes
-- create a "Oh fuck" spell that purges glasses 

-- TODO -glasses seem to bet sometimes yeeted when swapping low <-> high

