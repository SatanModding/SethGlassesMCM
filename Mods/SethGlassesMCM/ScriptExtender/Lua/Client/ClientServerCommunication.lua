ClientServerCommunication = {}
ClientServerCommunication.__index = ClientServerCommunication



-- BroadcastMessage is Server -> Client
-- PostMessageToServer is Client -> Server 


Ext.Events.NetMessage:Subscribe(function(e)

    if (e.Channel == "ChangeVisibilityOfHighTab") then

        local payload = Ext.Json.Parse(e.Payload)
        -- get Tab
        local tab = SatanDoesIMGUI:GetHighGlassesTab()
        -- set invisible is the character is a dragonborn (is is dragonborn then -> false)
        tab.Visible = (not payload.isDragonborn)

    end
end)

