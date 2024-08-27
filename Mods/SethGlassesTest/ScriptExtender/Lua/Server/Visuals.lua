

Visuals = {}
Visuals.__index = Visuals

local none = "1f82fcd6-b6d2-4b4b-a7f6-64c6b4ae132c"

local TYPES = {
    "FRAME",
    "ARMS",
    "LENSES",
    "CHAINS_MAIN",
    "CHAINS_RIGHT_1",
    "CHAINS_RIGHT_2",
    "CHAINS_LEFT_1" 
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
        return{LOKE_GLASSES_DGB}
    else
        return {LOKE_GLASSES}
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

-- TODO
-- returns all visuals that the chracter is allowed to have of a certain type (ex: all dgb lenses)
function Visuals:GetAllowedVisualsOfType(character, type, size)

    local allowedVisals = {}
    
    local allowedGlasses =  Visuals:GetAllowedGlasses(character)


end


-- TODO
function Visuals:GetLowVersion(visual)

end

-- TODO
function Visuals:GetHighVersion(visual)

end


function Visuals:SwapLowForHigh(character)
    
end

function Visuals:SwapHighForLow(character)
    
end




---@param character string - uuid
---@param type string
---@return bool
function Visuals:HasGlassesEntryOfType(character, type)

    local tableToSearch = Visuals:GetAllowedGlasses(character)
    local allVisuals = Visuals:GetAllVisuals(character)

    for tableName, visuals in pairs (tableToSearch) do
        if Helper:StringContains(tableName, type) then
            for _, entry in pairs (visuals) do
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

    for tableName, visuals in pairs (tableToSearch) do
        if Helper:StringContains(tableName, type) then
            for _, entry in pairs (visuals) do
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
function Visuals:GetNextVisual(character, type)

    local permittedVisuals = Visuals:GetAllowedVisualsOfType(character, type)
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

    
end




-- if user chooses component from LOW while wearing HIGH, transfer all HUGH components to the corresponding LOW ones