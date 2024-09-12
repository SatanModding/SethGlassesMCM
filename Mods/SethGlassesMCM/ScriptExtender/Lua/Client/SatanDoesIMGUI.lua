----------------------------------------------------------------------------------------
--
--                  IMGUI helper functions for creating IMGIO objects            
--
----------------------------------------------------------------------------------------



SatanDoesIMGUI = {}
SatanDoesIMGUI.__index = SatanDoesIMGUI


MCMUUID = "755a8a72-407f-4f0d-9a33-274ac0f0b53d"



TYPES = {
    "PRESET",
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
    "PLAIN",
    "NONE"
}


local highGlassesTab


--------------------------------------------------------------------------------
---                          Getters and Setters
--------------------------------------------------------------------------------


function SatanDoesIMGUI:GetHighGlassesTab()
    return highGlassesTab
end


-- Get type ("PRESET", "CHAINS_RIGHT_1" etc.) from a string
---@param str string 
function SatanDoesIMGUI:GetType(str)
    local type
    for _, t in ipairs(TYPES) do
        if string.find(str, t) then
            type = t
            break
        end
    end

    return type
end


-- Get type ("PIXIE_KILLER", "CINNAMONROLL" etc.) from a string
---@param str string 
function SatanDoesIMGUI:GetStyle(str)
    local style
    for _, t in ipairs(STYLES) do
        if string.find(str, t) then
            style = t
            break
        end
    end
    return style
end



--------------------------------------------------------------------------------
---                             Methods
--------------------------------------------------------------------------------


-- TODO - These stay when regions are changed, meaning the tabs get added again
-- For every region swap

-- Insert Glasses Low Tab
if Ext.Mod.IsModLoaded(MCMUUID) then

    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Glasses Low", function(tab)
        local tableOfTales = MCM:CreateGlasses("LOW", tab)

        for _, tbl in pairs(tableOfTales) do
            for _ , btn in pairs(tbl) do
                btn.OnClick = function()
                    local type = SatanDoesIMGUI:GetType(btn.Label)
                    local style = SatanDoesIMGUI:GetStyle(btn.Label)

                    
                    Ext.Net.PostMessageToServer("LOKE_GLASSES",Ext.Json.Stringify({size = "LOW", type = type, style = style}))
                end
            end
        end

    end)
end


-- Insert Glasses High Tab
if Ext.Mod.IsModLoaded(MCMUUID) then

    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Glasses High", function(tab)
        local tableOfTales = MCM:CreateGlasses("HIGH", tab)

        for _, tbl in pairs(tableOfTales) do
            for _ , btn in pairs(tbl) do
                btn.OnClick = function()
                    local type = SatanDoesIMGUI:GetType(btn.Label)
                    local style = SatanDoesIMGUI:GetStyle(btn.Label)
                
                    Ext.Net.PostMessageToServer("LOKE_GLASSES",Ext.Json.Stringify({size = "HIGH", type = type, style = style}))
                end
            end
        end

        highGlassesTab = tab
        
    end)
end



-- Insert Credits tab
if Ext.Mod.IsModLoaded(MCMUUID) then

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
end



