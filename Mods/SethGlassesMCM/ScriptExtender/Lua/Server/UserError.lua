



-- TODO - get rid of them. Voli displays missing dependencies (still gotta yell at users if they dont have MCM installed)


-- MCM UUID
MCMUUID = "755a8a72-407f-4f0d-9a33-274ac0f0b53d"




local MCMMessage = "You do not have Mod Configuration menu loaded.\nPlease download it from Volitio on Nexus\nhttps://www.nexusmods.com/baldursgate3/mods/9162\nremember to export your modsettings!"


Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)


    local character = Osi.GetHostCharacter()

    Ext.Timer.WaitFor(10000, function ()

        local isMCMLoaded = Ext.Mod.IsModLoaded(MCMUUID)

        if (isMCMLoaded == false) then
    
            Osi.OpenMessageBox(character, MCMMessage)
        end
    
    
    end)

end)


