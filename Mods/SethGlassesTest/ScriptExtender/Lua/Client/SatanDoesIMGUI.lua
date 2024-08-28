
-- Aahz : and if you're populating a thing, might AddGroup(), and use that group to :AddButton() or whatever


local WHITE = {1.0, 1.0, 1.0, 1.0}




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



Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Seth's Glasses 2 - Electric Boogalo", function(glasses_low)


    MCM:CreateGlasses("LOW", glasses_low)

    -------------------------
    --    DEFINITIONS      --
    -------------------------

    -- local size = {100,100}

    -- -------------------------
    -- --       PRESETS       --
    -- -------------------------
    

    -- -- spearator
    -- local separator = glasses_low:AddSeparatorText("Glasses Low")
    -- separator:SetColor(0, WHITE)
    -- glasses_low:AddText("Presets")

    -- -- Images
    -- local pk_low = glasses_low:AddImageButton("ICON_LOKE_PIXIE_KILLER_LOW", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    -- local cn_low = glasses_low:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    -- cn_low.SameLine = true
    -- local sg_low = glasses_low:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    -- sg_low.SameLine = true
    -- local fb_low = glasses_low:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    -- fb_low.SameLine = true
    -- local du_low = glasses_low:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    -- du_low.SameLine = true
    -- local cs_low = glasses_low:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    -- cs_low.SameLine = true
    -- local mh_low = glasses_low:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    -- mh_low.SameLine = true
    -- local in_low = glasses_low:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    -- in_low.SameLine = true
    -- local nothing_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    -- nothing_low.SameLine = true


    -- pk_low.OnClick = function()
    --     _D("Pixie Killer Preset clicked!")
    --     _P(pk_low.Image.Icon) -- I can probably use this to encode the UUIDs or so
    -- end

    -- -- Descriptions
    -- local pk_text = glasses_low:AddText("Pixie Killer")
    -- local cn_text = glasses_low:AddText("Cinnamonroll")
    -- cn_text.SameLine = true
    -- local sg_text = glasses_low:AddText("Stained Glass")
    -- sg_text.SameLine = true
    -- local fb_text = glasses_low:AddText("Flower Boy")
    -- fb_text.SameLine = true
    -- local du_text = glasses_low:AddText("  Dark Urge  ")
    -- du_text.SameLine = true
    -- local cs_text = glasses_low:AddText("  Can't See")
    -- cs_text.SameLine = true
    -- local mh_text = glasses_low:AddText("     Mr Healing")
    -- mh_text.SameLine = true
    -- local in_text = glasses_low:AddText("     Infernal")
    -- in_text.SameLine = true
    -- local nothing_text = glasses_low:AddText("       Nothing")
    -- nothing_text.SameLine = true



    -- -------------------------
    -- --    Customization    --
    -- -------------------------
    
    -- local separator = glasses_low:AddSeparatorText("Customization")



    -- -----------------------------------------------
    -- --       Frame  , Arms,  Chains  Header      --
    -- -----------------------------------------------
  
    
    -- glasses_low:AddText("                  Frame                                          ")
    -- local arms_header = glasses_low:AddText("                                          Arms                                          ")
    -- arms_header.SameLine = true
    -- local chains_header = glasses_low:AddText("                                          Chains")
    -- chains_header.SameLine = true


    -- -----------------------------------------------
    -- --       Frame  , Arms,  Chains  Images      --
    -- -----------------------------------------------

    -- -- Images Frame
    -- local frame_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE", "PUT_YOUR_ICON_NAME_HERE", size) 
    -- local no_frame_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE" , "PUT_YOUR_ICON_NAME_HERE" , size)
    -- no_frame_low.SameLine = true

    -- local separationText = glasses_low:AddText("                                          ")
    -- separationText.SameLine = true
    

    -- -- Images Arms
    -- local arms_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE", "PUT_YOUR_ICON_NAME_HERE", size) 
    -- arms_low.SameLine = true
    -- local no_arms_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE" , "PUT_YOUR_ICON_NAME_HERE" , size)
    -- no_arms_low.SameLine = true

    -- local separationText = glasses_low:AddText("                                          ")
    -- separationText.SameLine = true


    -- -- Images Chains
    -- local chains_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE", "PUT_YOUR_ICON_NAME_HERE", size) 
    -- chains_low.SameLine = true
    -- local no_chains_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE" , "PUT_YOUR_ICON_NAME_HERE" , size)
    -- no_chains_low.SameLine = true

  
    -- ----------------------------------------------------
    -- --       Frame  , Arms,  Chains  Description      --
    -- ----------------------------------------------------


    -- -- Frame
    -- local frame_low_text = glasses_low:AddText(" Frame          ")
    -- local no_frame_low_text = glasses_low:AddText("No Frame                                                         ")
    -- no_frame_low_text.SameLine = true
  
  
    -- -- Arms
    -- local arms_low = glasses_low:AddText("Arms          ")   
    -- arms_low.SameLine = true
    -- local no_arms_low_text = glasses_low:AddText("No Arms                                                  ")
    -- no_arms_low_text.SameLine = true


    -- -- Chains
    -- local chains_low = glasses_low:AddText(" Chains        ")
    -- chains_low.SameLine = true
    -- local no_chains_low_text = glasses_low:AddText("No Chains")
    -- no_chains_low_text.SameLine = true

    
    -- -------------------------
    -- --       Lenses        --
    -- -------------------------


    -- local separator = glasses_low:AddSeparator()
    -- glasses_low:AddText("Lenses")

    -- -- Images
    -- local pk_lens_low = glasses_low:AddImageButton("ICON_LOKE_PIXIE_KILLER_PRESET", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    -- local cn_lens_low = glasses_low:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    -- cn_lens_low.SameLine = true
    -- local sg_lens_low = glasses_low:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    -- sg_lens_low.SameLine = true
    -- local fb_lens_low = glasses_low:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    -- fb_lens_low.SameLine = true
    -- local du_lens_low = glasses_low:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    -- du_lens_low.SameLine = true
    -- local cs_lens_low = glasses_low:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    -- cs_lens_low.SameLine = true
    -- local mh_lens_low = glasses_low:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    -- mh_lens_low.SameLine = true
    -- local in_lens_low = glasses_low:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    -- in_lens_low.SameLine = true
    -- local plain_lens_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    -- plain_lens_low.SameLine = true
    -- local nothing_lens_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    -- nothing_lens_low.SameLine = true


    -- -- Descriptions
    -- local pk_lens_text = glasses_low:AddText("Pixie Killer")
    -- local cn_lens_text = glasses_low:AddText("Cinnamonroll")
    -- cn_lens_text.SameLine = true
    -- local sg_lens_text = glasses_low:AddText("Stained Glass")
    -- sg_lens_text.SameLine = true
    -- local fb_lens_text = glasses_low:AddText("Flower Boy")
    -- fb_lens_text.SameLine = true
    -- local du_lens_text = glasses_low:AddText("  Dark Urge  ")
    -- du_lens_text.SameLine = true
    -- local cs_lens_text = glasses_low:AddText("  Can't See")
    -- cs_lens_text.SameLine = true
    -- local mh_lens_text = glasses_low:AddText("     Mr Healing")
    -- mh_lens_text.SameLine = true
    -- local in_lens_text = glasses_low:AddText("     Infernal")
    -- in_lens_text.SameLine = true
    -- local plain_lens_text = glasses_low:AddText("           Plain")
    -- plain_lens_text.SameLine = true
    -- local nothing_lens_text = glasses_low:AddText("            Nothing")
    -- nothing_lens_text.SameLine = true



    -- -------------------------
    -- --     Charms Left     --
    -- -------------------------
    
    -- local separator = glasses_low:AddSeparator()

    -- glasses_low:AddText("Charms Left")

    -- -- Images
    -- local pk_charms_left_low = glasses_low:AddImageButton("ICON_LOKE_PIXIE_KILLER_PRESET", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    -- local cn_charms_left_low = glasses_low:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    -- cn_charms_left_low.SameLine = true
    -- local sg_charms_left_low = glasses_low:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    -- sg_charms_left_low.SameLine = true
    -- local fb_charms_left_low = glasses_low:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    -- fb_charms_left_low.SameLine = true
    -- local du_charms_left_low = glasses_low:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    -- du_charms_left_low.SameLine = true
    -- local cs_charms_left_low = glasses_low:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    -- cs_charms_left_low.SameLine = true
    -- local mh_charms_left_low = glasses_low:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    -- mh_charms_left_low.SameLine = true
    -- local in_charms_left_low = glasses_low:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    -- in_charms_left_low.SameLine = true
    -- local nothing_charms_left_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    -- nothing_charms_left_low.SameLine = true


    -- -- Descriptions
    -- local pk_charms_left_text = glasses_low:AddText("Pixie Killer")
    -- local cn_charms_left_text = glasses_low:AddText("Cinnamonroll")
    -- cn_charms_left_text.SameLine = true
    -- local sg_charms_left_text = glasses_low:AddText("Stained Glass")
    -- sg_charms_left_text.SameLine = true
    -- local fb_charms_left_text = glasses_low:AddText("Flower Boy")
    -- fb_charms_left_text.SameLine = true
    -- local du_charms_left_text = glasses_low:AddText("  Dark Urge  ")
    -- du_charms_left_text.SameLine = true
    -- local cs_charms_left_text = glasses_low:AddText("  Can't See")
    -- cs_charms_left_text.SameLine = true
    -- local mh_charms_left_text = glasses_low:AddText("     Mr Healing")
    -- mh_charms_left_text.SameLine = true
    -- local in_charms_left_text = glasses_low:AddText("     Infernal")
    -- in_charms_left_text.SameLine = true
    -- local nothing_charms_left_text = glasses_low:AddText("            Nothing")
    -- nothing_charms_left_text.SameLine = true


    -- --------------------------------
    -- --     Charms Right Upper     --
    -- --------------------------------
    
    -- local separator = glasses_low:AddSeparator()


    -- glasses_low:AddText("Charms Upper Right")

    -- -- Images
    -- local pk_charms_right1_low = glasses_low:AddImageButton("ICON_LOKE_PIXIE_KILLER_PRESET", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    -- local cn_charms_right1_low = glasses_low:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    -- cn_charms_right1_low.SameLine = true
    -- local sg_charms_right1_low = glasses_low:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    -- sg_charms_right1_low.SameLine = true
    -- local fb_charms_right1_low = glasses_low:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    -- fb_charms_right1_low.SameLine = true
    -- local du_charms_right1_low = glasses_low:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    -- du_charms_right1_low.SameLine = true
    -- local cs_charms_right1_low = glasses_low:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    -- cs_charms_right1_low.SameLine = true
    -- local mh_charms_right1_low = glasses_low:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    -- mh_charms_right1_low.SameLine = true
    -- local in_charms_right1_low = glasses_low:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    -- in_charms_right1_low.SameLine = true
    -- local nothing_charms_right1_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    -- nothing_charms_right1_low.SameLine = true


    -- -- Descriptions
    -- local pk_charms_right1_text = glasses_low:AddText("Pixie Killer")
    -- local cn_charms_right1_text = glasses_low:AddText("Cinnamonroll")
    -- cn_charms_right1_text.SameLine = true
    -- local sg_charms_right1_text = glasses_low:AddText("Stained Glass")
    -- sg_charms_right1_text.SameLine = true
    -- local fb_charms_right1_text = glasses_low:AddText("Flower Boy")
    -- fb_charms_right1_text.SameLine = true
    -- local du_charms_right1_text = glasses_low:AddText("  Dark Urge  ")
    -- du_charms_right1_text.SameLine = true
    -- local cs_charms_right1_text = glasses_low:AddText("  Can't See")
    -- cs_charms_right1_text.SameLine = true
    -- local mh_charms_right1_text = glasses_low:AddText("     Mr Healing")
    -- mh_charms_right1_text.SameLine = true
    -- local in_charms_right1_text = glasses_low:AddText("     Infernal")
    -- in_charms_right1_text.SameLine = true
    -- local nothing_charms_right1_text = glasses_low:AddText("            Nothing")
    -- nothing_charms_right1_text.SameLine = true



    -- --------------------------------
    -- --     Charms Right Lower     --
    -- --------------------------------
    
    -- local separator = glasses_low:AddSeparator()


    -- glasses_low:AddText("Charms Lower Right")

    -- -- Images
    -- local pk_charms_righ2_low = glasses_low:AddImageButton("ICON_LOKE_PIXIE_KILLER_PRESET", "ICON_LOKE_PIXIE_KILLER_PRESET", size) 
    -- local cn_charms_righ2_low = glasses_low:AddImageButton("ICON_LOKE_CINNAMONROLL" , "ICON_LOKE_CINNAMONROLL" , size)
    -- cn_charms_righ2_low.SameLine = true
    -- local sg_charms_righ2_low = glasses_low:AddImageButton("ICON_LOKE_STAINED_GLASS"  , "ICON_LOKE_STAINED_GLASS", size)
    -- sg_charms_righ2_low.SameLine = true
    -- local fb_charms_righ2_low = glasses_low:AddImageButton("ICON_LOKE_FLOWER_BOY"  , "ICON_LOKE_FLOWER_BOY", size)
    -- fb_charms_righ2_low.SameLine = true
    -- local du_charms_righ2_low = glasses_low:AddImageButton("ICON_LOKE_DARK_URGE"  , "ICON_LOKE_DARK_URGE", size)
    -- du_charms_righ2_low.SameLine = true
    -- local cs_charms_righ2_low = glasses_low:AddImageButton("ICON_LOKE_CANT_SEE"  , "ICON_LOKE_CANT_SEE", size)
    -- cs_charms_righ2_low.SameLine = true
    -- local mh_charms_righ2_low = glasses_low:AddImageButton("ICON_LOKE_MR_HEALING"  , "ICON_LOKE_MR_HEALING", size)
    -- mh_charms_righ2_low.SameLine = true
    -- local in_charms_righ2_low = glasses_low:AddImageButton("ICON_LOKE_INFERNAL"  , "ICON_LOKE_INFERNAL", size)
    -- in_charms_righ2_low.SameLine = true
    -- local nothing_charms_righ2_low = glasses_low:AddImageButton("PUT_YOUR_ICON_NAME_HERE"  , "PUT_YOUR_ICON_NAME_HERE", size)
    -- nothing_charms_righ2_low.SameLine = true


    -- -- Descriptions
    -- local pk_charms_righ2_text = glasses_low:AddText("Pixie Killer")
    -- local cn_charms_righ2_text = glasses_low:AddText("Cinnamonroll")
    -- cn_charms_righ2_text.SameLine = true
    -- local sg_charms_righ2_text = glasses_low:AddText("Stained Glass")
    -- sg_charms_righ2_text.SameLine = true
    -- local fb_charms_righ2_text = glasses_low:AddText("Flower Boy")
    -- fb_charms_righ2_text.SameLine = true
    -- local du_charms_righ2_text = glasses_low:AddText("  Dark Urge  ")
    -- du_charms_righ2_text.SameLine = true
    -- local cs_charms_righ2_text = glasses_low:AddText("  Can't See")
    -- cs_charms_righ2_text.SameLine = true
    -- local mh_charms_righ2_text = glasses_low:AddText("     Mr Healing")
    -- mh_charms_righ2_text.SameLine = true
    -- local in_charms_righ2_text = glasses_low:AddText("     Infernal")
    -- in_charms_righ2_text.SameLine = true
    -- local nothing_charms_righ2_text = glasses_low:AddText("            Nothing")
   -- nothing_charms_righ2_text.SameLine = true
    
    
end)

