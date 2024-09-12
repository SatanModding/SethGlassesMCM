----------------------------------------------------------------------------------------
--
--               For sending  messages from Client to Server
--               And receivign messages fromm Server to Client
--
----------------------------------------------------------------------------------------


ClientServerCommunication = {}
ClientServerCommunication.__index = ClientServerCommunication



-------------------------------------------------------------------------------------------
---                             Receiving messages
-------------------------------------------------------------------------------------------


-- Dragonborns don't have "high" glasses options. 
-- If DGB has been selected, hide those options
Ext.Events.NetMessage:Subscribe(function(e)

    if (e.Channel == "ChangeVisibilityOfDGBTab") then

        local payload = Ext.Json.Parse(e.Payload)
        -- get Tab
        local tab = SatanDoesIMGUI:GetHighGlassesTab()
        -- set invisible is the character is a dragonborn (is is dragonborn then -> false)
        tab.Visible = (not payload.isDragonborn)


        -- Couldn't get this to work for release.
        -- if payload.isDragonborn then
        --     print("Is dragoborn. Hiding")
        --     MCM:HideForDGB()
        -- else
        --     print("Is not dragoborn. Showing")
        --     MCM:showForNoneDGB()
        -- end

    end
end)

