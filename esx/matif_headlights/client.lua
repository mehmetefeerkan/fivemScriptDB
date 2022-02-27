local display = false
local v = 'n'
local lastplate = 1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        local playerPed = PlayerPedId()
        if v == 'n' and IsPedSittingInAnyVehicle(playerPed) then
            v = 's'
            checkluzes()
        elseif v == 's' and IsPedOnFoot(playerPed) then
            v = 'n'
        end
    end
end)

function checkluzes()
        Citizen.Wait(200)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed,false)
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
        if plate ~= nil then
                ESX.TriggerServerCallback('matif_headlights:check', function(result)
                        if result ~= nil and result ~= 'NOT' then
                            lastplate = plate
                            --local vehicle = GetVehiclePedIsIn(playerPed,false)
                            ToggleVehicleMod(vehicle, 22, true)
                            SetVehicleHeadlightsColour(vehicle, tonumber(result))    
                        end
                end, plate)
        end
end

RegisterNetEvent('rgbfar:tak')
AddEventHandler('rgbfar:tak', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if IsPedSittingInAnyVehicle(playerPed) then
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
        TriggerServerEvent('matif_headlights:install', plate)
    else
        -- exports['mythic_notify']:SendAlert('error', 'Bu işlemi yapabilecek için aracın içerisinde olmanız gerekiyor!')
        TriggerEvent('notification', 'Bu işlemi yapabilecek için aracın içerisinde olmanız gerekiyor!', 2)
    end
end)

RegisterNetEvent('rgbfar:kullan')
AddEventHandler('rgbfar:kullan', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if IsPedSittingInAnyVehicle(playerPed) then
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

        if plate ~= lastplate then
            ESX.TriggerServerCallback('matif_headlights:check', function(result)
                if result ~= nil and result == 'NOT' then
                    print('doesnt have')
                    -- exports['mythic_notify']:SendAlert('error', 'Bu araçta xenon renkli far kiti yok')
                    TriggerEvent('notification', 'Bu araçta xenon renkli far kiti yok', 2)
                elseif result ~= nil and result ~= 'NOT' then
                    lastplate = plate
                    SetDisplay(not display)
                else
                    -- TriggerEvent('esx:showNotification', 'Something went wrong!')
                end
            end, plate)
        else
            SetDisplay(not display)
        end   
    else
        -- exports['mythic_notify']:SendAlert('error', 'Bu işlemi yapabilecek için aracın içerisinde olmanız gerekiyor!')
        TriggerEvent('notification', 'Bu işlemi yapabilecek için aracın içerisinde olmanız gerekiyor!', 2)
    end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("setcolor", function(data)
    print(data.color)
    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(),false)))
    ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 22, true)
    SetVehicleHeadlightsColour(GetVehiclePedIsIn(PlayerPedId()), tonumber(data.color))
	TriggerServerEvent('matif_headlights:set', plate, data.color)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

