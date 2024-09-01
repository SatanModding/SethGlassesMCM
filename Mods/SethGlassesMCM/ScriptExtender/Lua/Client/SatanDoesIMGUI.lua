
-- Aahz : and if you're populating a thing, might AddGroup(), and use that group to :AddButton() or whatever

mcmUUID = "755a8a72-407f-4f0d-9a33-274ac0f0b53d"

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



SatanDoesIMGUI = {}
SatanDoesIMGUI.__index = SatanDoesIMGUI

local highGlassesTab


print("DEFINED HIGH GLASSES TAB")

-- TODO - client can'T acces this function. Send an event instead

function SatanDoesIMGUI:GetHighGlassesTab()
    print("returning ", highGlassesTab)
    return highGlassesTab
end

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







if Ext.Mod.IsModLoaded(mcmUUID) then

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
end



if Ext.Mod.IsModLoaded(mcmUUID) then

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

        highGlassesTab = tab
        
    end)
end


if Ext.Mod.IsModLoaded(mcmUUID) then

    print("Populating Credits section")

    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Credits and thanks", function(tab)

        tab:AddBulletText("Aahz for his many helpful tips for working with IMGUI")
        tab:AddBulletText("Volitio for MCM which makes IMGUI actually fun to work with!")
        tab:AddBulletText("Skiz for helpful tips and moral support")
        tab:AddBulletText("Muffin for the amazing name")
        tab:AddBulletText("Norbyte without whom none of this would be possible")
        tab:AddBulletText("lokelani because without her glasses, this would literally be useless")
        tab:AddBulletText("And special thanks to Kaz for being an amazing friend ")
        tab:AddText("")


    end)
else


    print("MCM is not loaded")
end



-- TODO - rename tabs etc.



