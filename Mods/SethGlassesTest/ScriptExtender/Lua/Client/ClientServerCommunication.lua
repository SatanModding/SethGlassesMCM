ClientServerCommunication = {}
ClientServerCommunication.__index = ClientServerCommunication



-- BroadcastMessage is Server -> Client
-- PostMessageToServer is Client -> Server 


Ext.Events.NetMessage:Subscribe(function(e)

    --print("Received message from Server")
    local payload = Ext.Json.Parse(e.Payload)

    if (e.Channel == "TestMessageFromServer") then
        print("received Test on Client. Sending message back")
        Ext.Net.PostMessageToServer("TestMessageFromClient",Ext.Json.Stringify("Test from client"))
    end
end)





-- Ext.Timer.WaitFor(5000, function()

--     print("sending message from server")
--     --Ext.Net.BroadcastMessage("TestMessageFromServer",Ext.Json.Stringify("Test from client"))
--     Ext.Net.PostMessageToServer("TestMessageFromClient", Ext.Json.Stringify({ "some table"}))
-- end)


