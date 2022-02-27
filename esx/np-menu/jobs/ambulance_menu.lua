local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy = false
local spawnedVehicles, isInShopMenu = {}, false

RegisterNetEvent('st:emsputinveh')
AddEventHandler('st:emsputinveh', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 1.0 then
		notify('error', 'Yakında oyuncu yok!')
	else
        TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent('st:emstakeoutvehicle')
AddEventHandler('st:emstakeoutvehicle', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 5.0 then
        TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
    else
        notify('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('st:emsRevive')
AddEventHandler('st:emsRevive', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local ReviveReward = 1000

	if closestPlayer == -1 or closestDistance > 1.0 then
		ESX.ShowNotification('Yakında kimse yok!')
    else
        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then
                local closestPlayerPed = GetPlayerPed(closestPlayer)

                if IsPedDeadOrDying(closestPlayerPed, 1) then
                    local playerPed = PlayerPedId()

                    ESX.ShowNotification('İlk yardım Yapılıyor!')

                    local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

                    for i=1, 15, 1 do
                        Citizen.Wait(900)

                        ESX.Streaming.RequestAnimDict(lib, function()
                            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                        end)
                    end

                    TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                    TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))

                    -- Show revive award?
                    if Config.ReviveReward > 0 then
                        exports['mythic_notify']:SendAlert('error', _U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
                    else
                        ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
                    end
                else
                   -- ESX.ShowNotification(_U('player_not_unconscious'))
                    exports['mythic_notify']:SendAlert('error', _U('player_not_unconscious'))
                end
            else
                exports['mythic_notify']:SendAlert('error', _U('not_enough_medikit'))
               -- ESX.ShowNotification(_U('not_enough_medikit'))
            end

            isBusy = false

        end, 'medikit')
    end
end)

RegisterNetEvent('st:emssmallheal')
AddEventHandler('st:emssmallheal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local ReviveReward = 1000

	if closestPlayer == -1 or closestDistance > 1.0 then
		notify('error', 'Yakında oyuncu yok!')
    else
    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
        if quantity > 0 then
            local closestPlayerPed = GetPlayerPed(closestPlayer)
            local health = GetEntityHealth(closestPlayerPed)

            if health > 0 then
                local playerPed = PlayerPedId()

                isBusy = true
                notify('error', 'İlk yardım yapılıyor!')
                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                Citizen.Wait(10000)
                ClearPedTasks(playerPed)

                TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
                TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
                notify('error', 'Kişiye yardım ettin ' ..GetPlayerName(closestPlayer))
                isBusy = false
            else
                notify('error', 'Oyuncu yaralı değil!')
            end
        else
            notify('error', 'Bandajın yok!')
        end
    end, 'bandage')
    end
end)

function notify(type, message)
    exports['mythic_notify']:SendAlert(type, message)
end

RegisterNetEvent('st:emsbigheal')
AddEventHandler('st:emsbigheal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local ReviveReward = 1000

    if closestPlayer == -1 or closestDistance > 1.0 then
		notify('error', 'Yakında oyuncu yok!')
    else
    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
        if quantity > 0 then
            local closestPlayerPed = GetPlayerPed(closestPlayer)
            local health = GetEntityHealth(closestPlayerPed)

            if health > 0 then
                local playerPed = PlayerPedId()

                isBusy = true
                notify('error', 'İlk yardım yapılıyor!')
                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                Citizen.Wait(10000)
                ClearPedTasks(playerPed)

                TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
                TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                notify('error', 'Kişiye yardım ettin ' ..GetPlayerName(closestPlayer))
                isBusy = false
            else
                notify('error', 'Oyuncu yaralı değil!')
            end
        else
            notify('error', 'Medkit yok!')
        end
    end, 'medikit')
    end
end)

RegisterNetEvent('st:emsdrag')
AddEventHandler('st:emsdrag', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('esx_policejob:drag2', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)