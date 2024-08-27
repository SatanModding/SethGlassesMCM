

Visuals = {}
Visuals.__index = Visuals

local none = "1f82fcd6-b6d2-4b4b-a7f6-64c6b4ae132c"


-- TODO - fiddle with this
local TYPES = {
    "SETH_FRAME",
    "SETH_ARMS",
    "SETH_LENSES",
    "SET_CHAINS_MAIN",
    "SET_CHAINS_LEFT_1",
    "SET_CHAINS_RIGHT_1",
    "SET_CHAINS_RIGHT_2",
    "SET_CHARM_LEFT_1",
    "SET_CHARM_RIGHT_1",
    "SET_CHARM_RIGHT_2"
}



local SIZES = {
    "HIGH",
    "LOW",
    "DGB"
}


-- returns the table of allowed glasses
-- only Dragonborns are special
---@þaram chataczer string -uuid
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

    if cca then
        return cca.Visuals
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

    for name, entry in pairs(allowedGlasses) do
        if name == type then
            if size == "LOW" then
                table.insert(allowedVisuals, entry.uuidLow)
            else 
                table.insert(allowedVisuals, entry.uuidHigh) --this includes dgb
        end
    end

    return allowedVisuals()
end


-- returns all visuals that are Lokes glasses
---@param character string - uuid
function Visuals:GetAllGlassesVisuals(character)

    local glasses = {}
    local listToSearch = Visuals:GetAllowedGlasses(character)

    local allVisuals = Visuals:GetAllVisuals(character)

    for _, visual in pairs(allVisuals) do
        for name, entry in pairs(listToSearch) do
            if (entry.uuidLow == visual) or (entry.uuidHigh == visual) then
                table.insert(glasses, visual)
            end
        end
    end

    return glasses
end

-- Get the High version of a Low visual or vice versa
---@param visual string - uuid of visual
---@param size string - enum
---@return oppositeVisual uuid
function Visuals:GetOtherVersion(visual, size)

    -- dgb don't have another version
    if size == "DGB" then
        return
    end

    for _, entries in pairs(LOKE_HUMAN_GLASSES) do
        for name, content in pairs(entries) do
            if size == "LOW" then
                if content.uuidHigh == visual then
                    return content.uuidLow
                end
            elseif size =="HIGH" then
                if content.uuidLow == visual then
                    return content.uuidHigh
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

    if size == "DGB" then
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

    
    -- remove old glasses components
    for _, v in pairs(currentlyEquippedGlasses) do
        Osi.RemoveCustomVisualOvirride(character, v)
    end

    -- add new glasses components
    for _, w in pairs(oppositeVisual) do
        Osi.AddCustomVisualOverride(character, w)
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

    for typeName, content in pairs (tableToSearch) do
        if typeName == type then
            for _, entry in pairs(content) do
                if Table:Contains(allVisuals, (entry.uuidLow)) or Table:Contains(allVisuals, (entry.uuidHigh)) then
                    return true
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

    for typeName, content in pairs (tableToSearch) do
        if typeName == type then
            for _, entry in pairs(content) do
                if Table:Contains(allVisuals, entry.uuidLow) then
                    return entry.uuidLow
                elseif Table:Contains(allVisuals, entry.uuidHigh) then
                    return entry.uuidHigh
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
    Osi.RemoveCustomVisualOvirride(character, currentVisual)

    -- if the new visual is of type none, only remove, don't add 
    if not newVisual == none then
        Osi.AddCustomVisualOverride(character, newVisual)
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


---@param character string - uuid
---@param type string -- enum
---@return visual string -- uuid
function Visuals:GetNextVisual(character, type, size)


    local glasseslChoice = {} -- turn into uservars

    local permittedVisuals = Visuals:GetAllowedVisualsOfType(character, type, size)



    
end

    


-- TODO - Currently resets on Saveload. Make into uservariable
-- Allows to cycle through a list of genitals instead of choosing a random one
local genitalChoice = {}

-- Choose random genital from selection (Ex: random vulva from vulva a - c)
---@param spell				- Name of the spell by which the genitals are filtered (vulva, penis, erection)
---@param uuid 	   			- uuid of entity that will receive the genital
---@return selectedGenital	- ID of CharacterCreationAppearaceVisual
function Genital:GetNextGenital(spell, uuid)
    local permittedGenitals = getPermittedGenitals(uuid)
    local filteredGenitals = getFilteredGenitals(spell, permittedGenitals)

	if  not filteredGenitals then
        -- _P("[BG3SX] No " , spell , " genitals available after filtering for this entity.")
        return nil
    else
		if genitalChoice.uuid == uuid and genitalChoice.spell == spell then
			-- Increment the index, wrap around if necessary
			genitalChoice.index = (genitalChoice.index % #filteredGenitals) + 1
		else
			genitalChoice = {uuid = uuid, spell = spell, index = 1}
		end

        local selectedGenital = filteredGenitals[genitalChoice.index]
        return selectedGenital
    end
end



function Visuals:GetHandle(visual)

    local content = Ext.StaticData.Get(visual,"CharacterCreationSharedVisual")
    local handle = content.DisplayName.Handle.Handle
    local name = Ext.Loca.GetTranslatedString(handle)
    return name
    
end

