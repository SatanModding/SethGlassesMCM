MCM = {}
MCM.__index = MCM




---@param return - list of Buttons I want to use OnClick on
function MCM:CreateOptometry(parent)

    MCMHelper:CreateWhiteSeparator(parent, "Optometry")

    parent:AddText(MCMHelper:EmptyText(0) .. "Bring Fashion and good eyesight to the people of Faerun")
    parent:AddText("") 

    -- shouldn't be necessary as this is saved anyways in UserVars

    -- local copyGlassesButton = parent:AddButton("Copy Glasses from self")
    -- MCMHelper:CreateWhiteText(parent, "Copy your glasses preset to paste it onto another entity.")
    -- copyGlassesButton.OnClick = function()
    --     _D("[DEBUG SETH_GLASSES] Copy Glasses to Target was clicked!")
    -- end
 
    -- parent:AddText("")

    local pasteGlassesButton = parent:AddButton("Paste Glasses to Target")
    MCMHelper:CreateWhiteText(parent, "Paste your saved preset onto another entity.")
    pasteGlassesButton.OnClick = function()
        _D("[DEBUG SETH_GLASSES] Paste Glasses to Targett was clicked!")
    end

    parent:AddText("")

    local removeGlassesFromTargetButton = parent:AddButton("Remove Glasses from Target")
    MCMHelper:CreateWhiteText(parent, "Remove glasses from the targeted entity")
    removeGlassesFromTargetButton.OnClick = function()
        _D("[DEBUG SETH_GLASSES] Remove Glasses was clicked!")
    end

    parent:AddText("")

    return {copyGlassesButton, pasteGlassesButton, removeGlassesFromTargetButton}
    
end



---@param type enum "LOW" or "HIGH"
function MCM:CreateGlasses(type, parent)

    local allButtons = {}

    -------------------------
    --    DEFINITIONS      --
    -------------------------

    local size = {100,100}

    -------------------------
    --       PRESETS       --
    -------------------------
    
    -- spearator
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(120) .. "Presets")

    local buttons1 = MCMHelper:CreateTableOfImageAndDescription(parent, PRESET_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "presetsTable", "PRESETS")
    table.insert(allButtons, buttons1)
  
    -------------------------
    --    Customization    --
    -------------------------
    
    parent:AddSeparatorText("Customization")

    -----------------------------------------------
    --       Frame  , Arms,  Chains  Header      --
    -----------------------------------------------
    
    local arms_chains_suffix = ""
    local arms = 80
    local chains = 80

    if type == "HIGH" then
        arms_chains_suffix = " (Toggle off for large heads)"
        chains = 20
    end


   
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(19) .. "Frame")
    MCMHelper:AddTextSameLineWhite(parent,MCMHelper:EmptyText(arms) .. "Arms" .. arms_chains_suffix)
    MCMHelper:AddTextSameLineWhite(parent,MCMHelper:EmptyText(chains) .. "Chains" .. arms_chains_suffix)

    -----------------------------------------------
    --       Frame  , Arms,  Chains  Images      --
    -----------------------------------------------
    

     -- TODO - TYPE WILL BE DORECTLY PULLED FROM IMAGE: DO NOT APPEND WHEN ATLAS IS FINALIZED

    -- Images Frame
    local buttons2 = MCMHelper:CreateTableOfImageAndDescription(parent, FRAME_IMAGES, FRAMES_TEXT, size, THREE_TABLE_TABLESIZE,  "frametable", "FRAME")
    local buttons3 = MCMHelper:CreateTableOfImageAndDescriptionSameLine(parent, ARMS_IMAGES, ARMS_TEXT, size, THREE_TABLE_TABLESIZE, "armstable", "ARMS")
    local buttons4 = MCMHelper:CreateTableOfImageAndDescriptionSameLine(parent, CHAIN_MAIN_IMAGES, CHAIN_MAIN_TEXT, size, THREE_TABLE_TABLESIZE, "chainmaintable", "CHAINS_MAIN")
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


