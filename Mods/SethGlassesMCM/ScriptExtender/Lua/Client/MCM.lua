----------------------------------------------------------------------------------------
--
--                             Adding custom tabs to MCM             
--
----------------------------------------------------------------------------------------




MCM = {}
MCM.__index = MCM



-- currently unused. Couldn't get it to work for the release

local armsTable
local chainsTable
local dgbWarningArm
local dgbWarningChain


function MCM:HideForDGB()
    armsTable.Visible = false
    chainsTable.Visible = false
    dgbWarningArm.Visible = false
    dgbWarningChain.Visible = false

end


function MCM:showForNoneDGB()
    armsTable.Visible = true
    chainsTable.Visible = true
    dgbWarningArm.Visible = false
    dgbWarningChain.Visible = false
end




-- Design off the tabs
---@param type enum "LOW" or "HIGH"
function MCM:CreateGlasses(type, parent)

    parent:AddText("DOES NOT WORK IN THE MAGIC MIRROR OR CC\n")

    local allButtons = {}

    -------------------------
    --    DEFINITIONS      --
    -------------------------

    local size = {100,100}

    -- TODO : chain main broken

    -------------------------
    --       PRESET       --
    -------------------------
    
    -- spearator
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(120) .. "Presets")

    local buttons1 = MCMHelper:CreateTableOfImageAndDescription(parent, PRESET_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "presetsTable", "PRESET")
    table.insert(allButtons, buttons1)
  
    -------------------------
    --    Customization    --
    -------------------------
    
    parent:AddSeparatorText("Customization")

    -----------------------------------------------
    --       Frame  , Arms,  Chains  Header      --
    -----------------------------------------------
    
    local arms_chains_suffix = ""
    local arms = 60
    local chains = 35

    if type == "HIGH" then
        arms_chains_suffix = " (Toggle off for large heads)"
        chains = 20
    end


   
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(19) .. "Frame")
    MCMHelper:AddTextSameLineWhite(parent,MCMHelper:EmptyText(arms) .. "Arms" .. arms_chains_suffix)

    if type == "LOW" then
        dgbWarningArm = MCMHelper:AddTextSameLine(parent, "not available for DGB")
    end
    MCMHelper:AddTextSameLineWhite(parent,MCMHelper:EmptyText(chains) .. "Chains" .. arms_chains_suffix)
    if type == "LOW" then
        dgbWarningChain = MCMHelper:AddTextSameLine(parent,"not available for DGB")
    end

    -----------------------------------------------
    --       Frame  , Arms,  Chains  Images      --
    -----------------------------------------------
    

     -- TODO - TYPE WILL BE DORECTLY PULLED FROM IMAGE: DO NOT APPEND WHEN ATLAS IS FINALIZED

    -- Images Frame
    local buttons2 = MCMHelper:CreateTableOfImageAndDescription(parent, FRAME_IMAGES, FRAMES_TEXT, size, THREE_TABLE_TABLESIZE,  "frametable", "FRAME")
    local buttons3, myArmsTable = MCMHelper:CreateTableOfImageAndDescriptionSameLine(parent, ARMS_IMAGES, ARMS_TEXT, size, THREE_TABLE_TABLESIZE, "armstable", "ARMS")

    local buttons4, myChainsTable = MCMHelper:CreateTableOfImageAndDescriptionSameLine(parent, CHAIN_MAIN_IMAGES, CHAIN_MAIN_TEXT, size, THREE_TABLE_TABLESIZE, "chainmaintable", "CHAINS_MAIN")
   
   
    -- Auto hide those buttons for DGB. Couldn't get it to work for release
    armsTable = myArmsTable
    chainsTable = myChainsTable
    armsTable.Visible = true
    chainsTable.Visible = true
    dgbWarningArm.Visible = true
    dgbWarningChain.Visible = true

    
    table.insert(allButtons, buttons2)
    table.insert(allButtons, buttons3)
    table.insert(allButtons, buttons4)
    
    -------------------------
    --       Lenses        --
    -------------------------

    parent:AddSeparator()
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(112) .. "Lenses")
    local buttons4 = MCMHelper:CreateTableOfImageAndDescription(parent, LENSES_IMAGES, LENSES_NAMES, size, DEFAULT_TABLESIZE, "lensestable", "LENSES")
    table.insert(allButtons, buttons4)

    -------------------------
    --     Charms Left     --
    -------------------------
    
    parent:AddSeparator()
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(112) .. "Charms Left")

    local buttons5 = MCMHelper:CreateTableOfImageAndDescription(parent, CHARMS_LEFT_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "charmslefttable", "CHARM_LEFT_1")
    table.insert(allButtons, buttons5)

   
    --------------------------------
    --     Charms Right Upper     --
    --------------------------------
    
    parent:AddSeparator()
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(112) .. "Charms Upper Right")

    local buttons6 = MCMHelper:CreateTableOfImageAndDescription(parent, CHARMS_RIGHT1_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "charmsright1table", "CHARM_RIGHT_1")
    table.insert(allButtons, buttons6)

  
    --------------------------------
    --     Charms Right Lower     --
    --------------------------------
    
    parent:AddSeparator()
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(112) .. "Charms Lower Right")

    local buttons7 = MCMHelper:CreateTableOfImageAndDescription(parent, CHARMS_RIGHT2_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "charmsright1table", "CHARM_RIGHT_2")
    table.insert(allButtons, buttons7)


    return allButtons

end







