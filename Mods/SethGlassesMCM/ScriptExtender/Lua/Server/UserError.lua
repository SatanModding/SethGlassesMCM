

-- MCM UUID
mcmUUID = "755a8a72-407f-4f0d-9a33-274ac0f0b53d"

-- loke UUID
local glassesUUID = "52bc7ae8-16c6-472c-bb6f-dde5a71b8cb5"



local MCMMessage = "You do not have Mod Configuration menu loaded.\nPlease download it from Volitio on Nexus\nhttps://www.nexusmods.com/baldursgate3/mods/9162\nremember to export your modsettings!"

local lokeMessage = "You do not have Seth's Glasses loaded.\nPlease download it from lokelaniii on Nexus\nhttps://next.nexusmods.com/profile/lokelaniii/about-me?gameId=3474\nremember to export your modsettings!"



Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)


    local character = Osi.GetHostCharacter()

    Ext.Timer.WaitFor(10000, function ()

        local isMCMLoaded = Ext.Mod.IsModLoaded(mcmUUID)

        if (isMCMLoaded == false) then
    
            Osi.OpenMessageBox(character, MCMMessage)
    
        end
    
    
        if (not Ext.Mod.IsModLoaded(glassesUUID)) then
    
            Osi.OpenMessageBox(character, lokeMessage)
    
        end
        
    end)

end)


