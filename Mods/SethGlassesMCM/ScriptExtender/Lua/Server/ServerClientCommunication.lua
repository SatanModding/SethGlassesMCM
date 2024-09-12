----------------------------------------------------------------------------------------
--
--               For sending  messages from Server to Client
--               And receiving messages frmm Client to Server
--
----------------------------------------------------------------------------------------



ServerClientCommunication = {}
ServerClientCommunication.__index = ServerClientCommunication



-- BroadcastMessage is Server -> Client
-- PostMessageToServer is Client -> Server 




-- receive message about what change should be made
Ext.Events.NetMessage:Subscribe(function(e)


    if (e.Channel == "LOKE_GLASSES") then

        local payload = Ext.Json.Parse(e.Payload)
        local size = payload.size
        local type = payload.type
        local style = payload.style

        local character = Osi.GetHostCharacter()

        Shapeshift:MakeEditable(character)
        DoTheThing(size, type, style)
        Shapeshift:RevertEditability(character)
        Visuals:Replicate(character)
    end
end)



-- main function that calls the visual changes
function DoTheThing(size, type, style)

    local character = Osi.GetHostCharacter()

    -- SatanPrint(GLOBALDEBUG, "size " .. size)
    -- SatanPrint(GLOBALDEBUG, "type " .. type)
    -- SatanPrint(GLOBALDEBUG, "style " .. style)


    if IsDragonborn(character) then
        
        local previousSize = size
        size = "DGB"

        -- DGBs don't have a high version
        if previousSize == "HIGH" then
            return
        end

    end


    if type == "PRESET" then
        Visuals:EquipPreset(character, style, size)
        return
    end

    
    local currentGlassVisuals = Visuals:GetAllGlassesVisuals(character)

    -- SatanPrint(GLOBALDEBUG, "current visuals")
    -- SatanDump(GLOBALDEBUG, currentGlassVisuals)

    local visual = Visuals:GetVisual(style, type, size)

    -- if the character was previously wearing low,switch to high and vice versa
    if not (style == "NONE") then
        if Visuals:DifferentSize(currentGlassVisuals, visual) then
            SatanPrint(GLOBALDEBUG,"Size changed" )
            Visuals:SwapGlasses(character, size)
        end
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
        SatanPrint(GLOBALDEBUG, "Matching chains")
        Visuals:MatchChain(character)
    end)

end