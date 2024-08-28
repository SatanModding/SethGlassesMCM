MCM = {}
MCM.__index = MCM

local WHITE = {1.0, 1.0, 1.0, 1.0}



---@param return - list of Buttons I want to use OnClick on
function MCM:CreateOptometry(parent)

    local separator = parent:AddSeparatorText("Optometry")
    separator:SetColor(0, WHITE)

    parent:AddText("                                 Bring Fashion and good eyesight to the people of Faerun")
    parent:AddText("") 


    local copyGlassesButton = parent:AddButton("Copy Glasses from self")
    local text1 = parent:AddText("Copy your glasses preset to paste it onto another entity.")
    text1:SetColor(0,WHITE)
 


    parent:AddText("")

    local pasteGlassesButton = parent:AddButton("Paste Glasses to Target")
    local text2 = parent:AddText("Paste  your saved preset onto another entity.")
    text2:SetColor(0,WHITE)
    pasteGlassesButton.OnClick = function()
        _D("Paste Glasses to Targett was clicked!")
    end

    parent:AddText("")

    local removeGlassesFromTargetButton = parent:AddButton("Remove Glasses from Target")
    local text3 = parent:AddText("Paste your saved preset onto another entity.")
    text3:SetColor(0,WHITE)
    removeGlassesFromTargetButton.OnClick = function()
        _D("Remove Glasses was clicked!")
    end

    parent:AddText("")


    return {copyGlassesButton, pasteGlassesButton, removeGlassesFromTargetButton}
    
end




local default = "PUT_YOUR_ICON_NAME_HERE"

PRESET_IMAGES = {

    "ICON_LOKE_PIXIE_KILLER",
    "ICON_LOKE_CINNAMONROLL",
    "ICON_LOKE_STAINED_GLASS",
    "ICON_LOKE_FLOWER_BOY",
    "ICON_LOKE_DARK_URGE",
    "ICON_LOKE_CANT_SEE", 
    "ICON_LOKE_MR_HEALING", 
    "ICON_LOKE_INFERNAL",
    default
}

-- Plain only exists for glasses
NAMES = {
    "Pixie Killer",
    "Cinnamonroll",
    "Stained Glass",
    "Flower Boy",
    "Dark Urge",
    "Can't See",
    "Mr Healing",
    "Infernal",
    "Nothing"
}


---@param type "LOW" or "HIGH"
function MCM:CreateGlasses(type, parent)


    local buttons = {}

    local suffix_image
    local suffix_text
    local suffix_separator
    local isLow = false

    if type == "LOW" then
        suffix_image = "_LOW"
        suffix_text = " Low"
        suffix_separator = suffix_text
        isLow = true
    else
        suffix_image = "_HIGH"
        suffix_text = " High"
        suffix_separator = suffix_text .. " (Not available for Dragonborn)"
        
    end


     -------------------------
    --    DEFINITIONS      --
    -------------------------

    local size = {100,100}

    -------------------------
    --       PRESETS       --
    -------------------------
    
    -- spearator
    local separator = parent:AddSeparatorText("Glasses" .. suffix_separator)
    separator:SetColor(0, WHITE)
    parent:AddText("Presets")
    parent:AddText("")


    local presetsTable = parent:AddTable("presetsTable",#PRESET_IMAGES)
    local imageRow = presetsTable:AddRow()
    local descRow = presetsTable:AddRow()

    -- images
    for i, image in pairs(PRESET_IMAGES) do
        local imgbtn = imageRow:AddCell():AddImageButton(image .. suffix_image,image, size) 
        descRow:AddCell():AddText(NAMES[i])
        imgbtn.OnClick = function()
            _P("Clicked ", imgbtn.Image.Icon) -- use this to get the UUID
        end
    end

  
    -------------------------
    --    Customization    --
    -------------------------
    
    parent:AddSeparatorText("Customization")

    -----------------------------------------------
    --       Frame  , Arms,  Chains  Header      --
    -----------------------------------------------
    
    local arms_chains_suffix = ""

    if isLow then
        arms_chains_suffix = "Not available for DGB. Toggle off for large heads"
    end
  
    
    parent:AddText("                  Frame                                          ")
    local arms_header = parent:AddText("                                          Arms                                          ")
    arms_header.SameLine = true
    local chains_header = parent:AddText("                                          Chains")
    chains_header.SameLine = true


    -----------------------------------------------
    --       Frame  , Arms,  Chains  Images      --
    -----------------------------------------------

    -- Images Frame
    local frame = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE", "PUT_YOUR_ICON_NAME_HERE", size) 
    local no_frame = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE" , "PUT_YOUR_ICON_NAME_HERE" , size)
    no_frame.SameLine = true

    local separationText = parent:AddText("                                          ")
    separationText.SameLine = true
    

    -- Images Arms
    local arms = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE", "PUT_YOUR_ICON_NAME_HERE", size) 
    arms.SameLine = true
    local no_arms = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE" , "PUT_YOUR_ICON_NAME_HERE" , size)
    no_arms.SameLine = true

    local separationText = parent:AddText("                                          ")
    separationText.SameLine = true


    -- Images Chains
    local chains = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE", "PUT_YOUR_ICON_NAME_HERE", size) 
    chains.SameLine = true
    local no_chains = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE" , "PUT_YOUR_ICON_NAME_HERE" , size)
    no_chains.SameLine = true

  
    ----------------------------------------------------
    --       Frame  , Arms,  Chains  Description      --
    ----------------------------------------------------


    -- Frame
    local frame_text = parent:AddText(" Frame          ")
    local no_frame_text = parent:AddText("No Frame                                                         ")
    no_frame_text.SameLine = true
  
  
    -- Arms
    local arms = parent:AddText("Arms          ")   
    arms.SameLine = true
    local no_arms_text = parent:AddText("No Arms                                                  ")
    no_arms_text.SameLine = true


    -- Chains
    local chains = parent:AddText(" Chains        ")
    chains.SameLine = true
    local no_chains_text = parent:AddText("No Chains")
    no_chains_text.SameLine = true

    
    -------------------------
    --       Lenses        --
    -------------------------


    local separator = parent:AddSeparator()
    parent:AddText("Lenses")

    -- Images
    local pk_lens = parent:AddImageButton("ICON_LOKE_PIXIE_KILLER_PRESET", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    local cn_lens = parent:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    cn_lens.SameLine = true
    local sg_lens = parent:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    sg_lens.SameLine = true
    local fb_lens = parent:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    fb_lens.SameLine = true
    local du_lens = parent:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    du_lens.SameLine = true
    local cs_lens = parent:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    cs_lens.SameLine = true
    local mh_lens = parent:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    mh_lens.SameLine = true
    local in_lens = parent:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    in_lens.SameLine = true
    local plain_lens = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    plain_lens.SameLine = true
    local nothing_lens = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    nothing_lens.SameLine = true


    -- Descriptions
    local pk_lens_text = parent:AddText("Pixie Killer")
    local cn_lens_text = parent:AddText("Cinnamonroll")
    cn_lens_text.SameLine = true
    local sg_lens_text = parent:AddText("Stained Glass")
    sg_lens_text.SameLine = true
    local fb_lens_text = parent:AddText("Flower Boy")
    fb_lens_text.SameLine = true
    local du_lens_text = parent:AddText("  Dark Urge  ")
    du_lens_text.SameLine = true
    local cs_lens_text = parent:AddText("  Can't See")
    cs_lens_text.SameLine = true
    local mh_lens_text = parent:AddText("     Mr Healing")
    mh_lens_text.SameLine = true
    local in_lens_text = parent:AddText("     Infernal")
    in_lens_text.SameLine = true
    local plain_lens_text = parent:AddText("           Plain")
    plain_lens_text.SameLine = true
    local nothing_lens_text = parent:AddText("            Nothing")
    nothing_lens_text.SameLine = true



    -------------------------
    --     Charms Left     --
    -------------------------
    
    local separator = parent:AddSeparator()

    parent:AddText("Charms Left")

    -- Images
    local pk_charms_left = parent:AddImageButton("ICON_LOKE_PIXIE_KILLER_PRESET", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    local cn_charms_left = parent:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    cn_charms_left.SameLine = true
    local sg_charms_left = parent:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    sg_charms_left.SameLine = true
    local fb_charms_left = parent:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    fb_charms_left.SameLine = true
    local du_charms_left = parent:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    du_charms_left.SameLine = true
    local cs_charms_left = parent:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    cs_charms_left.SameLine = true
    local mh_charms_left = parent:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    mh_charms_left.SameLine = true
    local in_charms_left = parent:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    in_charms_left.SameLine = true
    local nothing_charms_left = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    nothing_charms_left.SameLine = true


    -- Descriptions
    local pk_charms_left_text = parent:AddText("Pixie Killer")
    local cn_charms_left_text = parent:AddText("Cinnamonroll")
    cn_charms_left_text.SameLine = true
    local sg_charms_left_text = parent:AddText("Stained Glass")
    sg_charms_left_text.SameLine = true
    local fb_charms_left_text = parent:AddText("Flower Boy")
    fb_charms_left_text.SameLine = true
    local du_charms_left_text = parent:AddText("  Dark Urge  ")
    du_charms_left_text.SameLine = true
    local cs_charms_left_text = parent:AddText("  Can't See")
    cs_charms_left_text.SameLine = true
    local mh_charms_left_text = parent:AddText("     Mr Healing")
    mh_charms_left_text.SameLine = true
    local in_charms_left_text = parent:AddText("     Infernal")
    in_charms_left_text.SameLine = true
    local nothing_charms_left_text = parent:AddText("            Nothing")
    nothing_charms_left_text.SameLine = true


    --------------------------------
    --     Charms Right Upper     --
    --------------------------------
    
    local separator = parent:AddSeparator()


    parent:AddText("Charms Upper Right")

    -- Images
    local pk_charms_right1 = parent:AddImageButton("ICON_LOKE_PIXIE_KILLER_PRESET", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    local cn_charms_right1 = parent:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    cn_charms_right1.SameLine = true
    local sg_charms_right1 = parent:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    sg_charms_right1.SameLine = true
    local fb_charms_right1 = parent:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    fb_charms_right1.SameLine = true
    local du_charms_right1 = parent:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    du_charms_right1.SameLine = true
    local cs_charms_right1 = parent:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    cs_charms_right1.SameLine = true
    local mh_charms_right1 = parent:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    mh_charms_right1.SameLine = true
    local in_charms_right1 = parent:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    in_charms_right1.SameLine = true
    local nothing_charms_right1 = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    nothing_charms_right1.SameLine = true


    -- Descriptions
    local pk_charms_right1_text = parent:AddText("Pixie Killer")
    local cn_charms_right1_text = parent:AddText("Cinnamonroll")
    cn_charms_right1_text.SameLine = true
    local sg_charms_right1_text = parent:AddText("Stained Glass")
    sg_charms_right1_text.SameLine = true
    local fb_charms_right1_text = parent:AddText("Flower Boy")
    fb_charms_right1_text.SameLine = true
    local du_charms_right1_text = parent:AddText("  Dark Urge  ")
    du_charms_right1_text.SameLine = true
    local cs_charms_right1_text = parent:AddText("  Can't See")
    cs_charms_right1_text.SameLine = true
    local mh_charms_right1_text = parent:AddText("     Mr Healing")
    mh_charms_right1_text.SameLine = true
    local in_charms_right1_text = parent:AddText("     Infernal")
    in_charms_right1_text.SameLine = true
    local nothing_charms_right1_text = parent:AddText("            Nothing")
    nothing_charms_right1_text.SameLine = true



    --------------------------------
    --     Charms Right Lower     --
    --------------------------------
    
    local separator = parent:AddSeparator()


    parent:AddText("Charms Lower Right")

    -- Images
    local pk_charms_righ2 = parent:AddImageButton("ICON_LOKE_PIXIE_KILLER_PRESET", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    local cn_charms_righ2 = parent:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    cn_charms_righ2.SameLine = true
    local sg_charms_righ2 = parent:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    sg_charms_righ2.SameLine = true
    local fb_charms_righ2 = parent:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    fb_charms_righ2.SameLine = true
    local du_charms_righ2 = parent:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    du_charms_righ2.SameLine = true
    local cs_charms_righ2 = parent:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    cs_charms_righ2.SameLine = true
    local mh_charms_righ2 = parent:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    mh_charms_righ2.SameLine = true
    local in_charms_righ2 = parent:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    in_charms_righ2.SameLine = true
    local nothing_charms_righ2 = parent:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    nothing_charms_righ2.SameLine = true


    -- Descriptions
    local pk_charms_righ2_text = parent:AddText("Pixie Killer")
    local cn_charms_righ2_text = parent:AddText("Cinnamonroll")
    cn_charms_righ2_text.SameLine = true
    local sg_charms_righ2_text = parent:AddText("Stained Glass")
    sg_charms_righ2_text.SameLine = true
    local fb_charms_righ2_text = parent:AddText("Flower Boy")
    fb_charms_righ2_text.SameLine = true
    local du_charms_righ2_text = parent:AddText("  Dark Urge  ")
    du_charms_righ2_text.SameLine = true
    local cs_charms_righ2_text = parent:AddText("  Can't See")
    cs_charms_righ2_text.SameLine = true
    local mh_charms_righ2_text = parent:AddText("     Mr Healing")
    mh_charms_righ2_text.SameLine = true
    local in_charms_righ2_text = parent:AddText("     Infernal")
    in_charms_righ2_text.SameLine = true
    local nothing_charms_righ2_text = parent:AddText("            Nothing")
    nothing_charms_righ2_text.SameLine = true
    
    
end


