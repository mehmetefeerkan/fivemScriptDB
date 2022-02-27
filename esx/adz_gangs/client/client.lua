ESX = nil
local Creatgangs = {}
local CurrentBandana = nil
local PlayerJoined = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(2000)
    for k,v in pairs(Config.NPCS) do
        Creatgangs[k] = false
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    PlayerJoined = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:playerDropped')
AddEventHandler('esx:playerDropped', function(xPlayer)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Config.NPCS) do
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords, true)
        if dist <= v.range then
            if CreatedGangs[k] == true then
                Creatgangs[k] = false
                TriggerServerEvent('kov_gang:updateCreate', k, false)
            end
        end
    end  
end)


RegisterNetEvent("kov_gang:spawnGang")
AddEventHandler("kov_gang:spawnGang", function(gang)
    local scenerio = math.random(1, #Config.NPCS[gang].Scenerios)
    TriggerServerEvent('kov_gangs:CurrentScenerio', gang, scenerio) 
    for k=1, #Config.NPCS[gang].Scenerios[scenerio].npcs, 1 do
        Citizen.SetTimeout(250, function()
            local models = Config.NPCS[gang].npcmodel[math.random(1, #Config.NPCS[gang].npcmodel)]
            local pdweapon = Config.NPCS[gang].weapons[math.random(1, #Config.NPCS[gang].weapons)]
            local pdammo = math.random(Config.PedAmmos[1], Config.PedAmmos[2])
            RequestModel(models)
            while not HasModelLoaded(models) do
                Citizen.Wait(1)
            end
            Config.NPCS[gang].Scenerios[scenerio].npcs[k].np = CreatePed(26, models, Config.NPCS[gang].Scenerios[scenerio].npcs[k].coord, Config.NPCS[gang].Scenerios[scenerio].npcs[k].heading, 1, 0)
            SetPedRelationshipGroupHash(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, Config.NPCS[gang].grouphash)
            GiveWeaponToPed(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, pdweapon, pdammo, 0, 1)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 1, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 2, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 5, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 16, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 26, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 46, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 52, true)
            SetPedAccuracy(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 30)
            SetPedArmour(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 5000)
            SetPedDiesWhenInjured(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, false)
            --SetPedFleeAttributes(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 0, 0)
            SetPedToInformRespectedFriends(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 200, 100)
            SetPedCombatRange(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, 200)
            if Config.NPCS[gang].Scenerios[scenerio].npcs[k].Task ~= nil then
                if Config.NPCS[gang].Scenerios[scenerio].npcs[k].Task.type == 1 then
                    TaskPlayAnim(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, Config.NPCS[gang].Scenerios[scenerio].npcs[k].Task.anim, 0, true)
                elseif Config.NPCS[gang].Scenerios[scenerio].npcs[k].Task.type == 2 then
                    RequestAnimDict(Config.NPCS[gang].Scenerios[scenerio].npcs[k].Task.dict)
                while (not HasAnimDictLoaded(Config.NPCS[gang].Scenerios[scenerio].npcs[k].Task.dict)) do Citizen.Wait(0) end
                    TaskPlayAnim(Config.NPCS[gang].Scenerios[scenerio].npcs[k].np, Config.NPCS[gang].Scenerios[scenerio].npcs[k].Task.dict, Config.NPCS[gang].Scenerios[scenerio].npcs[k].Task.anim, 1.5, 1.5, -1, 1, 0, false, false, false)
                end
                Citizen.Wait(1)
            end
        end)
    end
    for o=1, #Config.NPCS[gang].Scenerios[scenerio].animals, 1 do
        Citizen.SetTimeout(250, function()
            --TriggerServerEvent('kov_gangs:printSv', 'deneme1')
            local animalmodels = Config.NPCS[gang].animals[math.random(1, #Config.NPCS[gang].animals)]
            RequestModel(animalmodels)
            while not HasModelLoaded(animalmodels) do
                Citizen.Wait(1)
            end
            --TriggerServerEvent('kov_gangs:printSv', animalmodels)
            Config.NPCS[gang].Scenerios[scenerio].animals[o].np = CreatePed(28, animalmodels, Config.NPCS[gang].Scenerios[scenerio].animals[o].coord, Config.NPCS[gang].Scenerios[scenerio].animals[o].heading, 1, 1)
            SetPedRelationshipGroupHash(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, Config.NPCS[gang].grouphash)SetPedAsGroupMember(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, Config.NPCS[gang].grouphash)
            SetPedNeverLeavesGroup(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, true)
		    SetPedCanBeTargetted(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, false)
		    SetEntityAsMissionEntity(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, true,true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, 1, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, 2, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, 5, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, 16, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, 26, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, 46, true)
            SetPedCombatAttributes(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, 52, true)
            SetPedCombatRange(Config.NPCS[gang].Scenerios[scenerio].animals[o].np, 200)
            --TriggerServerEvent('kov_gangs:printSv', 'deneme3')
        end)
    end
    for j=1, #Config.NPCS[gang].Scenerios[scenerio].Vehicle, 1 do
        RequestModel(Config.NPCS[gang].Scenerios[scenerio].Vehicle[j].model)
        while not HasModelLoaded(Config.NPCS[gang].Scenerios[scenerio].Vehicle[j].model) do
            Citizen.Wait(1)
        end
        local x, y, z = table.unpack(Config.NPCS[gang].Scenerios[scenerio].Vehicle[j].coord)
        Config.NPCS[gang].Scenerios[scenerio].Vehicle[j].vh = CreateVehicle(Config.NPCS[gang].Scenerios[scenerio].Vehicle[j].model, x, y, z, Config.NPCS[gang].Scenerios[scenerio].Vehicle[j].heading, true, false)
        SetModelAsNoLongerNeeded(Config.NPCS[gang].Scenerios[scenerio].Vehicle[j].model)
    end
    for f=1, #Config.NPCS[gang].npcmodel, 1 do
        SetModelAsNoLongerNeeded(Config.NPCS[gang].npcmodel[f])
    end
    for e=1, #Config.NPCS[gang].animals, 1 do
        SetModelAsNoLongerNeeded(Config.NPCS[gang].animals[e])
    end
end)

RegisterNetEvent("kov_gang:spawnServer")
AddEventHandler("kov_gang:spawnServer", function(gang)
    TriggerServerEvent('kov_gang:spawnServer', gang)
end)

RegisterNetEvent("kov_gang:DeleteGang")
AddEventHandler("kov_gang:DeleteGang", function(gang)
    TriggerServerEvent('kov_gang:DeleteGang', gang)
end)

RegisterNetEvent("kov_gang:deleteGang")
AddEventHandler("kov_gang:deleteGang", function(gang, scenerio)
    --TriggerServerEvent('kov_gangs:printSv', scenerio)
    for h=1, #Config.NPCS[gang].Scenerios[scenerio].animals, 1 do
        DeleteEntity(Config.NPCS[gang].Scenerios[scenerio].animals[h].np)
    end
    for l=1, #Config.NPCS[gang].Scenerios[scenerio].npcs, 1 do
        DeleteEntity(Config.NPCS[gang].Scenerios[scenerio].npcs[l].np)
    end
    for j=1, #Config.NPCS[gang].Scenerios[scenerio].Vehicle, 1 do
        DeleteEntity(Config.NPCS[gang].Scenerios[scenerio].Vehicle[j].vh)
    end
    TriggerServerEvent('kov_gangs:CurrentScenerio', gang, nil)
end)

function PlayerGang()
    for k,v in pairs(Config.NPCS) do
       --TriggerServerEvent('kov_gangs:printSv', CurrentBandana)
        local gangGroup = v.grouphash
        if CurrentBandana == v.job or ESX.PlayerData.job and ESX.PlayerData.job.name == v.job then
            SetRelationshipBetweenGroups(1, gangGroup, GetHashKey("PLAYER"))
            SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), gangGroup)
        else
            SetRelationshipBetweenGroups(3, gangGroup, GetHashKey("PLAYER"))
            SetRelationshipBetweenGroups(3, GetHashKey("PLAYER"), gangGroup)
        end
    end
end

RegisterNetEvent('kov_gangs:PlayerBandana')
AddEventHandler('kov_gangs:PlayerBandana', function(Object)
    CurrentBandana = Object
end)

RegisterCommand('gangsfix', function()
    PlayerJoined = true
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 125
        local pos = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.NPCS) do
            ESX.TriggerServerCallback('kov_gang:getState', function(create)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords, true)
                if dist <= v.range + 200 then
                    if dist > v.range - 2.5 and dist <= v.range then
                        if create == false then
                            if Creatgangs[k] == false then
                                print('gangsCreated')
                                Creatgangs[k] = true
                                TriggerEvent("kov_gang:spawnServer", k)
                                --TriggerServerEvent('kov_gang:updateCreate', k, true)
                                --TriggerServerEvent('kov_gangs:printSv', 'gang:npcyaratildi')
                            end
                        end
                    elseif dist >= v.range + 2 and dist < v.range + 3.5 then
                        if Creatgangs[k] == true then 
                            if create == true then
                                --TriggerServerEvent('kov_gang:updateCreate', k, false)
                                print('gangsDeleted')
                                Creatgangs[k] = false
                                TriggerEvent('kov_gang:DeleteGang', k)
                                --TriggerServerEvent('kov_gangs:printSv', 'gang:npcsilindi')
                            else
                                Creatgangs[k] = false
                            end
                        end
                    end
                else
                    sleep = 4000
                end
            end, k)
        end
        Citizen.Wait(sleep)      
    end
end)


Citizen.CreateThread(function() 
    local pos = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Config.NPCS) do
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords, true)
        if dist <= v.range then
            Creatgangs[k] = true
        end
    end
    while true do
        Citizen.Wait(7000)
        if PlayerJoined == true then  
            TriggerServerEvent('kov_gangs:getPlBandanaSv')
            PlayerGang()
        end
    end
end)
