-- Move to IMGUI if we can figure out why borked
Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)
    local party = Osi.DB_PartyMembers:Get(nil)
    for i = #party, 1, -1 do
        Osi.AddPassive(party[i][1], "LOKE_GLASSES_TAKE_OFF_GLASSES")
    end
end)


Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(character)
    Osi.AddPassive(character, "LOKE_GLASSES_TAKE_OFF_GLASSES")
end)
