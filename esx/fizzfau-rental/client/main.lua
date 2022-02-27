ESX = nil
local ped, currentStore, Vehicle = nil, nil, nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(250)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    TriggerServerEvent("fizzfau-rental:getVehicle")
end)

Citizen.CreateThread(function()
    while true do
        local thread = 750
        local ped = PlayerPedId()
        if ped ~= nil then
            local coords = GetEntityCoords(ped)
            for k,v in pairs(Config.Locations) do
                local distance = #(coords - v.coords.rent)
                if distance <= 3 then
                    thread = 0
                    text = "Araç Kirala"
                    if distance <= 2.5 then
                        text = "E - " ..text
                        if IsControlJustReleased(0, 46) then
                            OpenRentMenu(k, v)
                        end
                    end
                    DrawText3Ds(v.coords.rent, text)
                end
            end
        end
        Citizen.Wait(thread)
    end
end)

Citizen.CreateThread(function()
    while true do
        local thread = 750
        if Vehicle ~= nil and currentStore ~= nil then
            local coords = GetEntityCoords(Vehicle)
            local distance = #(coords - Config.Locations[currentStore].coords.spawn)
            if distance <= 5 then
                thread = 0
                text = "Aracı Bırak"
                if distance <= 5 then
                    text = "E - " ..text
                    if IsControlJustReleased(0, 46) then
                        GiveBackVehicle()
                    end
                end
                DrawText3Ds(Config.Locations[currentStore].coords.spawn, text)
            end
        end
        Citizen.Wait(thread)
    end
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("rent", function(data)
    local plate = GeneratePlate()
    local data = data.data
    TriggerServerEvent("fizzfau-rental:rent", data.name, data, plate, currentStore)
end)

RegisterNetEvent("fizzfau-rental:spawnVehicle")
AddEventHandler("fizzfau-rental:spawnVehicle", function(k, v, plate)
    local ped = PlayerPedId()
    ESX.Game.SpawnVehicle(v.name, Config.Locations[currentStore].coords.spawn, Config.Locations[currentStore].coords.Heading, function(vehicle)
        Vehicle = vehicle
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, plate)
        SetEntityAsMissionEntity(vehicle, 1, 1)
        FreezeEntityPosition(ped, false)
        SetEntityVisible(ped, true)
        TriggerServerEvent("fizzfau-rental:update", vehicle)
    end)
end)

RegisterNetEvent("fizzfau-rental:delete")
AddEventHandler("fizzfau-rental:delete", function(vehicle)
    local ped = PlayerPedId()
    TaskLeaveVehicle(ped, vehicle, 0)
    while IsPedInVehicle(ped, vehicle, true) do
      Citizen.Wait(100)
    end
    Citizen.Wait(1000)
    DeleteEntity(vehicle)
end)

RegisterNetEvent("fizzfau-rental:client:getVehicle")
AddEventHandler("fizzfau-rental:client:getVehicle", function(vehicle)
    if not DoesEntityExist(vehicle) then
        TriggerServerEvent("fizzfau-rental:update", vehicle, true)
        return
    end
    Vehicle = vehicle
end)

function GiveBackVehicle()
    local health = GetEntityHealth(Vehicle)
    TriggerServerEvent("fizzfau-rental:giveback", health)
    Vehicle = nil
end

function OpenRentMenu(k, v)
    currentStore = k
    SendNUIMessage({ key = k, value = v })
    SetNuiFocus(true, true)
end

function DrawText3Ds(coords, text)
    local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	ClearDrawOrigin()
end

function GeneratePlate()
	return string.upper('fzf ' ..math.random(100,999))
end