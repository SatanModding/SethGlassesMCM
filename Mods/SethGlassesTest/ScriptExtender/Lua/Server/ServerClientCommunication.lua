ServerClientCommunication = {}
ServerClientCommunication.__index = ServerClientCommunication





-- BroadcastMessage is Server -> Client
-- PostMessageToServer is Client -> Server 


Ext.Events.NetMessage:Subscribe(function(e)


    if (e.Channel == "LOKE_GLASSES") then

        local payload = Ext.Json.Parse(e.Payload)
        local size = payload.size
        local type = payload.type
        local style = payload.style
    
    
        DoTheThing(size, type, style)
    
  
    end
end)





function DoTheThing(size, type, style)

    local character = Osi.GetHostCharacter()

    -- print("size " , size)
    -- print("type ", type)
    -- print("style " , style)

    if IsDragonborn(character) then
        
        local previousSize = size
        size = "DGB"

        -- DGBs don't have a high version
        if previousSize == "HIGH" then
            return
        end

    end



    if type == "PRESETS" then
        Visuals:EquipPreset(character, style, size)
        return
    end

    

    local currentGlassVisuals = Visuals:GetAllGlassesVisuals(character)


    local visual = Visuals:GetVisual(style, type, size)

    --_P("current glasses visuals")
    --_D(currentGlassVisuals)

    -- if the character was previously wearing low,switch to high and vice versa
    if Visuals:DifferentSize(currentGlassVisuals, visual) then
        --print("Size changed")
        Visuals:SwapGlasses(character, size)
    end


    -- waiting for glasses swap
    Ext.Timer.WaitFor(200, function ()
        -- remove old type and add new one
        Visuals:SwapVisuals(character, type, visual)
    end)

   
    -- waiting for addition/swap
    Ext.Timer.WaitFor(400, function ()
        -- match the chain so it looks good

        -- Chain matching broken for lower right LOW and DGB
        --print("Matching chains")
        Visuals:MatchChain(character)
    end)

end