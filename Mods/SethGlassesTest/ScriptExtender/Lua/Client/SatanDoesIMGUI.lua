
-- Aahz : and if you're populating a thing, might AddGroup(), and use that group to :AddButton() or whatever



local none = "1f82fcd6-b6d2-4b4b-a7f6-64c6b4ae132c"

TYPES = {
    "PRESETS",
    "FRAME",
    "ARMS",
    "LENSES",
    "CHAINS_MAIN",
    "CHAINS_LEFT_1",
    "CHAINS_RIGHT_1",
    "CHAINS_RIGHT_2",
    "CHARM_LEFT_1",
    "CHARM_RIGHT_1",
    "CHARM_RIGHT_2"
}


STYLES = {
    "PIXIE_KILLER",
    "CINNAMONROLL",
    "STAINED_GLASS",
    "FLOWER_BOY",
    "DARK_URGE",
    "CANT_SEE",
    "MR_HEALING",
    "INFERNAL",
    "PLAIN", -- TODO - think about how to deal with style for arms, frames, main chain
    "NONE"
}



local function isControlledCharacter(entity)
    if type(entity) == "string" then
        entity = Ext.Entity.Get(entity)
    end
    return entity ~= nil and entity.ClientControl ~= nil and entity.UserReservedFor.UserID == 1
end

-- Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Optometry", function(tabHeader)

--     -- I cannot get any identifying information about button -> use index
--     local buttons = MCM:CreateOptometry(tabHeader)


--     -- buttons[1].OnClick = function()
--     --     _D("Copy Glasses from self was clicked!")
--         --Visuals:SavePreset(hostCharacter)
--         -- isControlledCharacter(entity) -- use this
--     --end


--     buttons[2].OnClick = function()
--         _D("Paste Glasses to Target was clicked!")
--         -- Start a spell
--     end


--     buttons[3].OnClick = function()
--         _D("Remove Glasses was clicked!")
--         -- Start a spell
--     end

-- end)





local function getType(str)
    -- Loop through the TYPES to find the type in the spell string
    local type
    for _, t in ipairs(TYPES) do
        if string.find(str, t) then
            type = t
            break
        end
    end

    return type
end


local function getStyle(str)
    -- Loop through the TYPES to find the type in the spell string
    local style
    for _, t in ipairs(STYLES) do
        if string.find(str, t) then
            style = t
            break
        end
    end

    return style
end



Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Glasses Low", function(tab)
    local tableOfTales = MCM:CreateGlasses("LOW", tab)

    for _, tbl in pairs(tableOfTales) do
        for _ , btn in pairs(tbl) do
            btn.OnClick = function()
                --print("name ", btn.Label)
                local type = getType(btn.Label)
                local style = getStyle(btn.Label)
             
                Ext.Net.PostMessageToServer("LOKE_GLASSES",Ext.Json.Stringify({size = "LOW", type = type, style = style}))

                -- when sending to server check if size needs to be overriden to DGB
            end
        end
    end
end)


Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Glasses High", function(tab)
    local tableOfTales = MCM:CreateGlasses("HIGH", tab)

    for _, tbl in pairs(tableOfTales) do
        for _ , btn in pairs(tbl) do
            btn.OnClick = function()
                --print("name ", btn.Label)
                local type = getType(btn.Label)
                local style = getStyle(btn.Label)
             
                Ext.Net.PostMessageToServer("LOKE_GLASSES",Ext.Json.Stringify({size = "HIGH", type = type, style = style}))
            end
        end
    end
    
end)


