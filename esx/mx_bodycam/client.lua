    local PlayerData = {}
ESX = nil
bodycama = false

local bodycamProp = 0
local bodycamModel = "prop_spycam"

local currentStatus = 'out'
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)







RegisterNetEvent("mx_bodycam:show")
AddEventHandler("mx_bodycam:show", function(daner, job)
    local year , month, day , hour , minute , second  = GetLocalTime()

    if bodycama == true then
        if string.len(tostring(minute)) < 2 then
            minute = '0' .. minute
        end
        if string.len(tostring(second)) < 2 then
            second = '0' .. second
        end
        SendNUIMessage({
            date = day .. '/'.. month .. '/' .. year .. ' ' .. hour .. ':' .. minute .. ':' .. second,
            daneosoby = daner,
            ranga = job,
            open = true,
        })
    end
end)

RegisterCommand("bodycam", function()
    ESX.TriggerServerCallback('sove:item', function(qtty)
        if qtty > 0 then
            if not bodycama then
                bodycama = true
                --BodycamPlayText()
                --newBodycamProp()
                --exports['mythic_notify']:SendAlert('inform', 'Bodycam kaydı başlatıldı', 2500)
                TriggerEvent('mx_bodycam:show')
                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'bodycam', 0.02)
                Citizen.Wait(1000)
                --BodycamPlayOut()
                --deleteBodycam()
                Citizen.Wait(1000)
                --ExecuteCommand('e kravatbağla')
                exports['mythic_notify']:SendAlert('inform', 'Bodycam Kaydı Başlatıldı', 2500)
                Citizen.Wait(3000)
                --SetPedComponentVariation(PlayerPedId(), 9, 13, 0, 2)
            else
                bodycama = false
                --ExecuteCommand('e kravatbağla')
                --exports['mythic_notify']:SendAlert('inform', 'Bodycami vücudundan çıkarttın', 2500)
                Citizen.Wait(1000)
                --SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 2)
                Citizen.Wait(1000)
                --BodycamPlayText()
                --newBodycamProp()
                exports['mythic_notify']:SendAlert('error', 'Bodycam Çıkarıldı', 2500)
                TriggerEvent('mx_bodycam:close')
                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'bodycam', 0.02)
                Citizen.Wait(1000)
                --BodycamPlayOut()
                --deleteBodycam()
            end
        else
            exports['mythic_notify']:SendAlert('inform', 'Bir Bodycam in yok', 2500)
        end
    end, 'bodycam')
end, false)

RegisterNetEvent("mx_bodycam:close")
AddEventHandler("mx_bodycam:close", function()
    SendNUIMessage({
        open = false
    })
    --SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 2)
end)

RegisterNetEvent('mx_bodycam:bodycam')
AddEventHandler('mx_bodycam:bodycam', function()
    TriggerServerEvent('mx_bodycam:getPlayerData')
    ExecuteCommand('bodycam')
end)
