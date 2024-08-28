-- this will be replaced by IMGUI





local function getTypeAndSizeFromSpell(spell)
    -- Loop through the TYPES to find the type in the spell string
    local type
    for _, t in ipairs(TYPES) do
        if string.find(spell, t) then
            type = t
            break
        end
    end

    -- Loop through the SIZES to find the size in the spell string
    local size
    for _, s in ipairs(SIZES) do
        if string.find(spell, s) then
            size = s
            break
        end
    end

    return type, size
end




-- Copy glasses
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "after", function(caster, target, spell, spellType, spellElement, storyActionID)
   
    if spell == "LOKE_GLASSES_COPY_GLASSES" then
        
        -- if the character is an NPC they don't have a Visual component and one has to be created first
        Visuals:GiveVisualComponentIfHasNone(target)

        -- remove glasses if they wear them
        local glassesToRemove = Visuals:GetAllGlassesVisuals(target)
        Visuals:RemoveListOfVisuals(target, glassesToRemove)
         
        -- get the glasses components teh character currently wears
        local glassesToAdd = Visuals:GetAllGlassesVisuals(caster)
        -- add glasses
        Visuals:AddListOfVisuals(target, glassesToAdd)

        -- npcEntity:Replicate("GameObjectVisual")
        -- TODO - check if we need to replicate after giving visual
        -- TODO - test with companions and NPCs
    end
end)



Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function(caster, spell, _, _, _)


    -- failsafe for similar spells -- checl if the name LOKE is contained



    -- TODO - the dragonborns don't work

    if Helper:StringContains(spell, "LOKE") then
        
        local type, size = getTypeAndSizeFromSpell(spell)

        if IsDragonborn(caster) then
            size = "DGB"
        end

        local currentGlassVisuals = Visuals:GetAllGlassesVisuals(caster)
        local nextVisual = Visuals:GetNextVisual(caster, type, size)

        --_P("current glasses visuals")
        --_D(currentGlassVisuals)

        --_P("next visual ", nextVisual)

        -- if the character was previously wearing low,switch to high and vice versa
        if Visuals:DifferentSize(currentGlassVisuals, nextVisual) then
            print("Size changed")
            Visuals:SwapGlasses(caster, size)
        end


        -- waiting for glasses swap
        Ext.Timer.WaitFor(200, function ()
            -- remove old type and add new one
            Visuals:SwapVisuals(caster, type, nextVisual)
        end)

       
        -- waiting for addition/swap
        Ext.Timer.WaitFor(400, function ()
            -- match the chain so it looks good
            print("Matching chains")
            Visuals:MatchChain(caster)
        end)


    end
end)
