
-- Aahz : and if you're populating a thing, might AddGroup(), and use that group to :AddButton() or whatever




local function isControlledCharacter(entity)
    if type(entity) == "string" then
        entity = Ext.Entity.Get(entity)
    end
    return entity ~= nil and entity.ClientControl ~= nil and entity.UserReservedFor.UserID == 1
end

Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Optometry", function(tabHeader)

    -- I cannot get any identifying information about button -> use index
    local buttons = MCM:CreateOptometry(tabHeader)


    buttons[1].OnClick = function()
        _D("Copy Glasses from self was clicked!")
        --Visuals:SavePreset(hostCharacter)
        -- isControlledCharacter(entity) -- use this
    end


    buttons[2].OnClick = function()
        _D("Paste Glasses to Target was clicked!")
        -- Start a spell
    end


    buttons[3].OnClick = function()
        _D("Remove Glasses was clicked!")
        -- Start a spell
    end

end)



Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Glasses Low", function(tab)
    MCM:CreateGlasses("LOW", tab)
end)


Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Glasses High", function(tab)
    MCM:CreateGlasses("HIGH", tab)
end)
