ESX = nil

local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterCommand('onduty', function()
    if ESX.PlayerData.job.name == "offpolice" or ESX.PlayerData.job.name == "offambulance" then
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)

        for k,v in pairs(Config.Zone) do
            local distance = #(pedCoords - v)
            if distance < 10 then
                TriggerServerEvent('sup-duty:onduty')
            else
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Burada duty hizmetini kullanamazsın!'})
                return
            end
        end
    end

    if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" then
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Zaten görevdesin!'})
        return
    end
end)

RegisterCommand('offduty', function()
    if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" then
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)

        for k,v in pairs(Config.Zone) do
            local distance = #(pedCoords - v)
            if distance < 10 then
                TriggerServerEvent('sup-duty:offduty')
            else
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Burada duty hizmetini kullanamazsın!'})
                return
            end
        end
    end

    if ESX.PlayerData.job.name == "offpolice" or ESX.PlayerData.job.name == "offambulance" then
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Zaten görevde değilsin!'})
        return
    end
end)