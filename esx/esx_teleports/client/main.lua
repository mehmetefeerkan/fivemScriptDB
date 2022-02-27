ESX                           = nil

local PlayerData              = {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    LoadMarkers()
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function LoadMarkers()
    Citizen.CreateThread(function()
    
        while true do
            sleep = 2000
            local playerPed = PlayerPedId()
            local playerVeh = GetVehiclePedIsIn(playerPed, 0)
            local plyCoords = GetEntityCoords(PlayerPedId())

            for location, val in pairs(Config.Teleporters) do

                local Enter = val['Enter']
                local Exit = val['Exit']
                local JobNeeded = val['Job']

                local dstCheckEnter, dstCheckExit = GetDistanceBetweenCoords(plyCoords, Enter['x'], Enter['y'], Enter['z'], true), GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true)

                if dstCheckEnter <= 2.5 then
                    sleep = 5
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then

                            DrawM(Enter['Information'], 27, Enter['x'], Enter['y'], Enter['z'])

                            if dstCheckEnter <= 1.2 then
                                if IsControlJustPressed(0, 38) then
                                    if IsPedInAnyVehicle(playerPed, 0) and (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
                                    Teleportc(val, 'enter')
                                    else 
                                    Teleport(val, 'enter')
                                    end
                                end
                            end

                        end
                    else
                        DrawM(Enter['Information'], 27, Enter['x'], Enter['y'], Enter['z'])

                        if dstCheckEnter <= 1.2 then

                            if IsControlJustPressed(0, 38) then
                                if IsPedInAnyVehicle(playerPed, 0) and (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
                                Teleportc(val, 'enter')
                                else 
                                Teleport(val, 'enter')
                                end
                            end

                        end

                    end
                end

                if dstCheckExit <= 7.5 then
                    sleep = 5
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then

                            DrawM(Exit['Information'], 27, Exit['x'], Exit['y'], Exit['z'])

                            if dstCheckExit <= 1.2 then
                                if IsControlJustPressed(0, 38) then
                                    if IsPedInAnyVehicle(playerPed, 0) and (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
                                    Teleportc(val, 'exit')
                                    else 
                                    Teleport(val, 'exit')
                                    end
                                end
                            end

                        end
                    else

                        DrawM(Exit['Information'], 27, Exit['x'], Exit['y'], Exit['z'])

                        if dstCheckExit <= 1.2 then

                            if IsControlJustPressed(0, 38) then
                                if IsPedInAnyVehicle(playerPed, 0) and (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
                                Teleportc(val, 'exit')
                                else 
                                Teleport(val, 'exit')
                                end
                            end

                        end
                    end
                end

            end
            Citizen.Wait(sleep)
        end
    end)
end


function Teleport(table, location)
    if location == 'enter' then
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Exit'])

        DoScreenFadeIn(100)
    else
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Enter'])

        DoScreenFadeIn(100)
    end
end


function Teleportc(table, location)
    if location == 'enter' then
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(GetVehiclePedIsIn(PlayerPedId(), 1), table['Exit'])

        DoScreenFadeIn(100)
    else
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(GetVehiclePedIsIn(PlayerPedId(), 1), table['Enter'])

        DoScreenFadeIn(100)
    end
end
function DrawM(hint, type, x, y, z)
    -- ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
    DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end

DrawText3D = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
	SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(x,y)
    local factor = (string.len(text)) / 500
    DrawRect(x,y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 80)
	end
end
