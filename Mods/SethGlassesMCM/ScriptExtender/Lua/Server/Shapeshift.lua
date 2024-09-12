-------------------------------------------------------------------------------------------------------------
---
---                                 For Handling Visuals (CCAV/CCSV)
---                              For entities that are of GameObjectType = 2    
---                         They pull from entity.AppearanceOverride.Visual.Visuals
--- 
------------------------------------------------------------------------------------------------------------



Shapeshift = {}
Shapeshift.__index = Shapeshift



---@param character string -uuid
---@param listToAdd table 
function Shapeshift:IsShapeshifted(character)
    if (Ext.Entity.Get(character).GameObjectVisual.Type == 4) or (Ext.Entity.Get(character).GameObjectVisual.Type == 2) then 
        return true
    else
        return false
    end
end



---@param character string -uuid
---@param listToAdd table 
function Shapeshift:AddListOfVisuals(character, listToAdd)

    if listToAdd then

        for _, entry in pairs(listToAdd) do
            Shapeshift:AddCustomVisualOverride(character, entry)
        end

    end
end



---@param character string -uuid
---@param listToRemove table 
function Shapeshift:RemoveListOfVisuals(character, listToRemove)

    if listToRemove then

        for _, entry in pairs(listToRemove) do
            Shapeshift:RemoveCustomVisualOvirride(character, entry)
        end

    end
end



function Shapeshift:CreateAppearanceOverrideIfHasNone(character)

    local entity = Ext.Entity.Get(character)        

    -- usually this component never exists. AAE creates one too
    if (not entity.AppearanceOverride) then
        entity:CreateComponent("AppearanceOverride")
    end
    
end


---@param character string - uuid
---@return visuals table
function Shapeshift:GetAllVisuals(character)

    local entity = Ext.Entity.Get(character)

    local ao = Helper:GetPropertyOrDefault(entity, "AppearanceOverride", nil)

    if ao then
        return ao.Visual.Visuals
    else
        return {}
    end
    
end



function Shapeshift:MakeEditable(character)

    if Shapeshift:IsShapeshifted(character) then

        local entity = Ext.Entity.Get(character)

        -- Eralyne figured out that type has to be 2 for changes to be visible.
        -- We do not know why
        entity.GameObjectVisual.Type = 2

    end
end



-- in case this fucks with other shit
function Shapeshift:RevertEditability(character)


    -- anything faster than 500 fucks up the chain matching for my Lokelani glasses mcm mod
    Ext.Timer.WaitFor(600, function ()

        if Shapeshift:IsShapeshifted(character) then

            local entity = Ext.Entity.Get(character)
    
            entity:Replicate("AppearanceOverride")
            entity:Replicate("GameObjectVisual") 
    
            Ext.Timer.WaitFor(100, function()
                entity.GameObjectVisual.Type = 4
            end)
        end
        
    end)
end


---@param character string - uuid
---@return visual string - uuid
function Shapeshift:RemoveCustomVisualOvirride(character, visual)


    Shapeshift:CreateAppearanceOverrideIfHasNone(character)

    local entity = Ext.Entity.Get(character)

    local visuals = {}

    for _, entry in pairs(entity.AppearanceOverride.Visual.Visuals) do
        if not (entry == visual) then
            table.insert(visuals,entry)
        end
    end

    entity.AppearanceOverride.Visual.Visuals = visuals

end



---@param character string - uuid
---@return visual string - uuid
function Shapeshift:AddCustomVisualOverride(character, visual)

    Shapeshift:CreateAppearanceOverrideIfHasNone(character)

    Ext.Timer.WaitFor(100, function ()

        local entity = Ext.Entity.Get(character)

        local visuals = {}

        for _, entry in pairs(entity.AppearanceOverride.Visual.Visuals) do
            table.insert(visuals,entry)
        end


        -- this is specifically for my glasses mod. I add a "none" visual uuid 
        -- but the entity doesn't like it. Doesn't hurt to keep it in here but
        -- not necessary for your project
        if not (visual == "none")  then
            table.insert(visuals, visual)
            entity.AppearanceOverride.Visual.Visuals = visuals
        end
        
    end)

end
