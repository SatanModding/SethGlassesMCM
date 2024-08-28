local settingsIDs = {
    "toggle_glasses", 


    "presets_low",
    "frame_low",
    "arms_low",
    "chains_low",
    "lenses_low",
    "charms_left_1_low",
    "charms_right_1_low",
    "charms_right_2_low",


    "presets_high",
    "frame_high",
    "arms_high",
    "chains_high",
    "lenses_high",
    "charms_left_1_high",
    "charms_right_1_high",
    "charms_right_2_high",


    "copy_glasses",
    "paste_glasses",
    "remove_glasses_from_target"


}


-- Big thanks to Volitio for MCM.  https://www.nexusmods.com/baldursgate3/mods/9162



function MCMGet(settingID)
    return Mods.BG3MCM.MCMAPI:GetSettingValue(settingID, ModuleUUID)
end




Ext.RegisterNetListener("MCM_Saved_Setting", function(call, payload)
    local data = Ext.Json.Parse(payload)
    if not data or data.modGUID ~= ModuleUUID or not data.settingId then
        return
    end


    if data.settingId == "toggle_glasses" then
        print("Value of toggle_glasses has been changed to ", data.value)
        -- do code here
    end

    -- add other settingIds ( unless I use my own IMGUI stuff)


end)

