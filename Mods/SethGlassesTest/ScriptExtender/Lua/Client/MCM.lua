MCM = {}
MCM.__index = MCM




---@param return - list of Buttons I want to use OnClick on
function MCM:CreateOptometry(parent)

    MCMHelper:CreateWhiteSeparator(parent, "Optometry")

    parent:AddText(MCMHelper:EmptyText(33) .. "Bring Fashion and good eyesight to the people of Faerun")
    parent:AddText("") 

    local copyGlassesButton = parent:AddButton("Copy Glasses from self")
    MCMHelper:CreateWhiteText(parent, "Copy your glasses preset to paste it onto another entity.")
    copyGlassesButton.OnClick = function()
        _D("[DEBUG SETH_GLASSES] Copy Glasses to Targett was clicked!")
    end
 
    parent:AddText("")

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

    local buttons = {}

    -------------------------
    --    DEFINITIONS      --
    -------------------------

    local size = {100,100}

    -------------------------
    --       PRESETS       --
    -------------------------
    
    -- spearator
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(120) .. "Presets")

    MCMHelper:CreateTableOfImageAndDescription(parent, PRESET_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "presetsTable")

  
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
    
    -- Images Frame
    MCMHelper:CreateTableOfImageAndDescription(parent, FRAME_IMAGES, FRAMES_TEXT, size, THREE_TABLE_TABLESIZE,  "frametable")
    MCMHelper:CreateTableOfImageAndDescriptionSameLine(parent, ARMS_IMAGES, ARMS_TEXT, size, THREE_TABLE_TABLESIZE, "armstable")
    MCMHelper:CreateTableOfImageAndDescriptionSameLine(parent, CHAIN_MAIN_IMAGES, CHAIN_MAIN_TEXT, size, THREE_TABLE_TABLESIZE, "chainmaintable")


    -------------------------
    --       Lenses        --
    -------------------------

    parent:AddSeparator()
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(112) .. "Lenses")
    MCMHelper:CreateTableOfImageAndDescription(parent, LENSES_IMAGES, LENSES_NAMES, size, DEFAULT_TABLESIZE, "lensestable")

    -------------------------
    --     Charms Left     --
    -------------------------
    
    parent:AddSeparator()
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(112) .. "Charms Left")

    MCMHelper:CreateTableOfImageAndDescription(parent, CHARMS_LEFT_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "charmslefttable")

   
    --------------------------------
    --     Charms Right Upper     --
    --------------------------------
    
    parent:AddSeparator()
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(112) .. "Charms Upper Right")

    MCMHelper:CreateTableOfImageAndDescription(parent, CHARMS_RIGHT1_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "charmsright1table")

  
    --------------------------------
    --     Charms Right Lower     --
    --------------------------------
    
    parent:AddSeparator()
    MCMHelper:CreateWhiteText(parent, MCMHelper:EmptyText(112) .. "Charms Lower Right")

    MCMHelper:CreateTableOfImageAndDescription(parent, CHARMS_RIGHT2_IMAGES, NAMES, size, DEFAULT_TABLESIZE, "charmsright1table")

end


