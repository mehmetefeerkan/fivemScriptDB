local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent('esx_bobbypin:use')
AddEventHandler('esx_bobbypin:use', function()

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    print(GetPlayerName(closestPlayer))

    if closestPlayer == -1 then
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Kendi kelepçeni çözemezsin.' } )
    elseif closestPlayer ~= -1 and closestDistance < 5.0 then
        if IsPedCuffed(GetPlayerPed(closestPlayer)) then

            SetTextComponentFormat('STRING')
            AddTextComponentString('Press ~INPUT_CELLPHONE_OPTION~ to cancel.')
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)

            if Config.Police then
                notifyPolice()
            end

            TriggerServerEvent('esx_bobbypin:notifyTarget', GetPlayerServerId(closestPlayer))

            TriggerEvent("mythic_progressbar:client:progress", {
                name = "Picking_Cuffs",
                duration = Config.Time * 1000,
                label = "Attempting to pick cuffs.",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, animation = {
                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                    anim = "machinic_loop_mechandplayer",
                    flags = 49,
                },
            }, function(status)
                if not status then
                    local chance = math.random(1, 100)
                    if chance < Config.Chance then
                        TriggerEvent('mythic_notify:client:SendAlert', { type = 'success', text = 'Kelepçeyi çözdün.' } )
                        TriggerServerEvent('esx_bobbypin:success', GetPlayerServerId(closestPlayer))
                    else
                        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Kelepçeyi çözemedin.' } )
                    end
                end
            end)
        end
    else
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Yakınında kimse yok.' } )
    end
end)

function notifyPolice()

    if Config.Police then
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), false))
        local plyPos = GetEntityCoords(PlayerPedId(),  true)
        local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z,
        Citizen.PointerValueInt(),
        Citizen.PointerValueInt())
        local streetName, crossing = GetStreetNameAtCoord(x, y, z)
        streetName = GetStreetNameFromHashKey(streetName)
        crossing = GetStreetNameFromHashKey(crossing)
        local coords      = GetEntityCoords(PlayerPedId())
        if crossing ~= nil then
            local coords      = GetEntityCoords(PlayerPedId())
            TriggerServerEvent('esx_phone:send', "police", "Kelepçe çözmeye çalışan birisini gördüm "
             .. streetName .. " ve " .. crossing, true, {
                x = coords.x,
                y = coords.y,
                z = coords.z
            })
        else
            TriggerServerEvent('esx_phone:send', "police", "Kelepçe çözmeye çalışan birisini gördüm "
             .. streetName, true, {
                x = coords.x,
                y = coords.y,
                z = coords.z
            })
        end
    else
        return
    end
end