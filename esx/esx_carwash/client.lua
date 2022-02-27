ESX = nil

-- Get the ESX library
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Registering net events
RegisterNetEvent('esx_pun_carwash:clean')
AddEventHandler('esx_pun_carwash:clean', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local dirtLevel = GetVehicleDirtLevel(vehicle)
    local displayPrice = math.floor(dirtLevel * Config.Price)
    local timer = Config.Timer * 1000
    FreezeEntityPosition(vehicle, true)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(_U('cleaning_vehicle'))
    EndTextCommandThefeedPostTicker(true, true)
    Citizen.Wait(timer)
    SetVehicleDirtLevel(vehicle, 0.0)
    FreezeEntityPosition(vehicle, false)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(_U('cleaned_vehicle') .. displayPrice)
    EndTextCommandThefeedPostTicker(true, true)
end)

RegisterNetEvent('esx_pun_carwash:cancel')
AddEventHandler('esx_pun_carwash:cancel', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local dirtLevel = GetVehicleDirtLevel(vehicle)
    local displayPrice = math.floor(dirtLevel * Config.Price)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(_U('not_enough_money') .. displayPrice)
    EndTextCommandThefeedPostTicker(true, true)
end)

-- Main thread
Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.Locations) do
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.location.x, v.location.y, v.location.z, true) <= v.extents and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() and GetEntitySpeed(PlayerPedId()) <= 0.5 do
                local pauseThread = 8
                local dirtLevel = GetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(), false))
                pricePreFormat = math.floor(dirtLevel * Config.Price)
                price = pricePreFormat - 0.01
                if price >= 1.0 then
                    SetTextComponentFormat("STRING")
                    AddTextComponentString(_U('press_button') .. pricePreFormat)
                    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                    if IsControlJustReleased(0, 350) then
                        TriggerServerEvent('esx_pun_carwash:checkMoney', price)
                        pauseThread = Config.Timer * 1000
                    end
                else
                    SetTextComponentFormat("STRING")
                    AddTextComponentString(_U('no_wash_needed'))
                    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                end
                Citizen.Wait(pauseThread)
            end
        end
        Citizen.Wait(1000)
    end
end)

-- Create blips
Citizen.CreateThread(function()
    if Config.ShowBlips == true then
        for k, v in pairs(Config.Locations) do
            local blip = AddBlipForCoord(v.location.x, v.location.y, v.location.z)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, Config.BlipColor)
            SetBlipDisplay(blip, Config.BlipDisplay)
            SetBlipScale(blip, Config.BlipScale)
            SetBlipSprite(blip, Config.BlipSprite)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(_U('blipname'))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Create markers
Citizen.CreateThread(function()
    if Config.ShowMarkers == true then
        while true do
            local player = PlayerPedId()
            for k, v in pairs(Config.Locations) do
                while GetDistanceBetweenCoords(v.location.x, v.location.y, v.location.z, GetEntityCoords(player), true) <= Config.DrawDistance and GetPedInVehicleSeat(GetVehiclePedIsIn(player, false), -1) == player do
                    -- Floating markers
                    if Config.MarkerType == 0 or (Config.MarkerType >= 2 and Config.MarkerType <= 7) or (Config.MarkerType >= 10 and Config.MarkerType <= 22) or Config.MarkerType == 24 or (Config.MarkerType >= 28 and Config.MarkerType <= 31) then
                        DrawMarker(Config.MarkerType, v.location.x, v.location.y, v.location.z + 1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                    -- Slightly under the ground markers
                    elseif Config.MarkerType == 1 then
                        DrawMarker(Config.MarkerType, v.location.x, v.location.y, v.location.z - 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.extents, v.extents, v.extents / 10, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                    -- Slightly above the ground markers, fixed
                    elseif Config.MarkerType == 8 or Config.MarkerType == 9 or Config.MarkerType == 23 or Config.MarkerType == 25 then
                        DrawMarker(Config.MarkerType, v.location.x, v.location.y, v.location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.extents, v.extents, v.extents, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, false, 2, nil, nil, false)
                    -- Slightly above the ground markers, rotating
                    elseif Config.MarkerType == 26 or Config.MarkerType == 27 then
                        DrawMarker(Config.MarkerType, v.location.x, v.location.y, v.location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.extents, v.extents, v.extents, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                    -- In case user specified an out-of-range marker value
                    else
                        DrawMarker(1, v.location.x, v.location.y, v.location.z - 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.extents, v.extents, v.extents / 10, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                    end
                    Citizen.Wait(7)
                end
            end
            Citizen.Wait(2500)
        end
    end
end)