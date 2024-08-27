

-- add spells for all partymembers

Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)
    local party = Osi.DB_PartyMembers:Get(nil)
    for i = #party, 1, -1 do
        Osi.AddSpell(party[i][1], "SETH_GLASSES_CONTAINER")
    end
end)


Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(actor)
    Osi.AddSpell(actor, "SETH_GLASSES_CONTAINER")
end)




Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "after", function(caster, target, spell, spellType, spellElement, storyActionID)
   
    if spell == "SETH_COPY_GLASSES" then


        local glasses = {}
        local characterVisuals = Ext.Entity.Get(caster).CharacterCreationAppearance.Visuals

        for _, visual in pairs(characterVisuals) do
            if SETH_FRAME[visual] then
                table.insert(glasses, visual)
            end

            if SETH_DANGLY[visual] then
                table.insert(glasses, visual)
            end
        end

        -- now glasses contains all visuals that will be transferred 

        -- assuming target is NPC, create cca component
        local npcEntity = Ext.Entity.Get(target)
        npcEntity:CreateComponent("CharacterCreationAppearance")

        for _, entry in pairs(glasses) do
            Osi.AddCustomVisualOverride(target, entry)
        end

        npcEntity:Replicate("GameObjectVisual")
        
    end


end)




Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function(caster, spell, _, _, _)
    
    if spell ==  "SETH_TAKE_OFF_DANGLY" then

        Osi.RemoveCustomVisualOvirride(caster,"f145941c-96bc-4902-985d-a38a630ce514" )

    end


    if spell ==  "SETH_PUT_ON_DANGLY" then 
        Osi.AddCustomVisualOverride(caster,"f145941c-96bc-4902-985d-a38a630ce514")
        
    end


    if spell ==  "SETH_TAKE_OFF_FRAME" then 
        Osi.RemoveCustomVisualOvirride(caster,"f785c9d6-9cea-4660-a2ee-8f0a8616203a" )
        
    end


    if spell ==  "SETH_PUT_ON_FRAME" then 
        Osi.AddCustomVisualOverride(caster,"f785c9d6-9cea-4660-a2ee-8f0a8616203a")
        
    end



end)
