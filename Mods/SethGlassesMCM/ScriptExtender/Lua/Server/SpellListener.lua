Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)



    if status == "LOKE_GLASSES_GIVE_GLASSES_BOOST"  then


        Shapeshift:MakeEditable(object)
        

        -- if both characters are not dragoborns, or not characters are not DGB return
        if (IsDragonborn(Osi.GetHostCharacter()) and IsDragonborn(object)) 
        or ((not IsDragonborn(Osi.GetHostCharacter())) and (not IsDragonborn(object))) then
            
     
            local glassesToGive = Visuals:GetAllGlassesVisuals(Osi.GetHostCharacter())
            -- this is for NPCs
            Visuals:GiveVisualComponentIfHasNone(object)

            -- remove previous glasses
            local previousGlasses = Visuals:GetAllGlassesVisuals(object)
            Visuals:RemoveListOfVisuals(object, previousGlasses)

            Ext.Timer.WaitFor(200, function ()
                Visuals:AddListOfVisuals(object, glassesToGive)
            end)

        end

        Shapeshift:RevertEditability(object)

    end


    if status == "LOKE_GLASSES_REMOVE_GLASSES_BOOST"  then

        Shapeshift:MakeEditable(object)

        local previousGlasses = Visuals:GetAllGlassesVisuals(object)
        Visuals:RemoveListOfVisuals(object, previousGlasses)

        Shapeshift:RevertEditability(object)

    end



end)