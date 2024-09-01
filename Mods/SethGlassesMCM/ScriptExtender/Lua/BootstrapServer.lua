

-- Data
Ext.Require("Server/Data/Glasses.lua")


Ext.Require("Shared/Utils/Table.lua")
Ext.Require("Shared/Utils/Helper.lua")

-- Main
Ext.Require("Server/UserVars.lua")
Ext.Require("Server/Race.lua")
Ext.Require("Server/Shapeshift.lua")
Ext.Require("Server/Visuals.lua")
Ext.Require("Server/SpellAddition.lua")
Ext.Require("Server/SpellListener.lua")
Ext.Require("Server/MCMCommunication.lua")
Ext.Require("Server/MCMCommunication.lua")
Ext.Require("Server/ServerClientCommunication.lua")
Ext.Require("Server/UserError.lua")
Ext.Require("Server/Main.lua")



print("LOADED SETH MCM")



-- Used to save glasses choices



-- TODO - this can be used for a video
Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)


   -- print("Gameplay started")


    function DelayAdd(uuid, time)
        Ext.Timer.WaitFor(time, function()
            Osi.AddCustomVisualOverride(Osi.GetHostCharacter(),uuid)
        end)
        
    end
    
    
    function DelayRemove(uuid, time)
        Ext.Timer.WaitFor(time, function()
            Osi.RemoveCustomVisualOvirride(Osi.GetHostCharacter(),uuid)
        end)
    end
    
    
    function Test(time)
    
        -- Add Frame low
        DelayAdd("bee0659a-7f45-4e4e-9673-2b968cb859cd", time)
    
        -- Add Arms low
        DelayAdd("59e21041-e42f-4a11-9b4c-eead3c779a75", time * 2)
    
        -- Add Glasses Plain
        DelayAdd("44d1be58-c278-498a-bc26-dfabf14b5e60", time * 3)
        -- Remove Glasses Plain
        DelayRemove("44d1be58-c278-498a-bc26-dfabf14b5e60", time * 4)
    
        -- Add Glasses SG
        DelayAdd("036e0d0f-7e33-4530-8272-2559a7b80b24", time * 5)
        -- Remove Glasses SG
        DelayRemove("036e0d0f-7e33-4530-8272-2559a7b80b24", time * 6)
    
        -- Add Glasses FB
        DelayAdd("cadf68f7-d55c-49f6-98ae-eaaa6d51e6be", time * 7)
        -- Remove Glasses FB
        DelayRemove("cadf68f7-d55c-49f6-98ae-eaaa6d51e6be", time * 8)
    
        -- Add all chains
        DelayAdd("c820dd92-df3f-4848-96c2-88f78b65e779", time  * 9) -- main
        DelayAdd("e530ef83-bb7d-4e23-a1c3-762406863ef1", time  * 10) -- left
        DelayAdd("e530ef83-bb7d-4e23-a1c3-762406863ef1", time * 11) -- right1
        DelayAdd("37ad51fb-0e2d-46ba-8446-02c1ca37e1b6", time * 12) --right 2
    
    
        -- Add Glasses MH
        DelayAdd("d14b603c-010b-43e8-b258-3a754f959225", time * 13)
        -- Add Charm left MH
        DelayAdd("7ce11a52-82dc-4649-a44f-3d9c82af0c24", time * 14)
        -- Add Charm right MH
        DelayAdd("ac0b6574-1a11-4af0-99fd-b0050d575d4f", time * 15)
        -- Add Charm right 2 MH
        DelayAdd("546a7f81-6b89-4047-9762-675cd0be0330", time * 16)
    
    
        -- remove Charm left MH
        DelayRemove("7ce11a52-82dc-4649-a44f-3d9c82af0c24", time * 17)
        -- add Charm left IN
        DelayAdd("5f5579ef-4560-4db1-9939-7ff6b1221998", time * 18)
    
        -- remove Charm right MH
        DelayRemove("ac0b6574-1a11-4af0-99fd-b0050d575d4f", time * 19)
        -- add Charm right DU
        DelayAdd("b423b0f2-c552-414e-8719-28fdde57dd71", time  * 20)
    
        -- remove Charm right 2 MH
        DelayRemove("546a7f81-6b89-4047-9762-675cd0be0330", time  * 21)
        -- add Charm right 2 PK
        DelayAdd("9e8fb3ed-5695-46ea-addc-3fd1e540d629", time  * 22)
    
        -- remove Charm right DU
        DelayRemove("b423b0f2-c552-414e-8719-28fdde57dd71", time  * 23)
        -- remove chain right
        DelayRemove("e530ef83-bb7d-4e23-a1c3-762406863ef1", time *24)
    end
    
    


    Ext.Timer.WaitFor(10000, function ()

       -- print("starting glasses")
       -- Test(2000)

        
    end)
end)




