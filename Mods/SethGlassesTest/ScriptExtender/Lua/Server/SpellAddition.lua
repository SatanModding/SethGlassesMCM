
-- characters get different spells based on race (everyone gets high, low and shared. dgb get shared and low)
-- add spells for all partymembers



Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)
    local party = Osi.DB_PartyMembers:Get(nil)
    for i = #party, 1, -1 do
        Osi.AddSpell(party[i][1], "LOKE_GLASSES_GLASSES_CONTAINER_SHARED")
        Osi.AddSpell(party[i][1], "LOKE_GLASSES_GLASSES_CONTAINER_LOW")
        if not IsDragonborn(party[i][1]) then
            Osi.AddSpell(party[i][1], "LOKE_GLASSES_GLASSES_CONTAINER_HIGH")
        end
    end
end)


Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(character)
    Osi.AddSpell(character, "LOKE_GLASSES_GLASSES_CONTAINER_SHARED")
    Osi.AddSpell(character, "LOKE_GLASSES_GLASSES_CONTAINER_LOW")
    if not IsDragonborn(character) then
        Osi.AddSpell(character, "LOKE_GLASSES_GLASSES_CONTAINER_HIGH")
    end
end)
