
-- characters get different spells based on race (everyone gets high, low and shared. dgb get shared and low)
-- add spells for all partymembers



Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)
    local party = Osi.DB_PartyMembers:Get(nil)
    for i = #party, 1, -1 do
        Osi.AddSpell(party[i][1], "LOKE_GLASSES_CONTAINER")
    end
end)


Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(character)
    Osi.AddSpell(character, "LOKE_GLASSES_CONTAINER")
end)
