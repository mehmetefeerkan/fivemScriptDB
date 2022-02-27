--[[
    PLEASE LEAVE THIS INTACT
    Lockpicking MiniGame Coded by Chris Rogers for GTAV Use
    Original Javascript was used from CodePen https://codepen.io/anon/pen/ydOeLo
    Copyright 2019 All Rights Reserved
    Please Do not Rename the resource, i use the name to see how many people are using the resource on statistics.
]]

ESX = nil
local guiEnabled = false
local success = false
local action = nil
local trigger = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent('lsrp-lockpick:StartLockpickfo')
AddEventHandler('lsrp-lockpick:StartLockpickfo', function(cb)
    ESX.TriggerServerCallback('lsrp-lockpickfo:getBobbyPins', function(advancedlockpick)
        if advancedlockpick > 0 then
            SetNuiFocus(true)
            guiEnabled = true
            SendNUIMessage({
                type = "enableui",
                enable = true,
            })
            Citizen.CreateThread(function()
                while true do
                    if action == 'success' then
                    action = nil
                    cb(true)
                    break
                    elseif action == 'failed' then
                    action = nil
                    -- exports['mythic_notify']:SendAlert('error', 'Tel tokaların hepsi kırıldı, tekrar dene!')
                    TriggerEvent('notification', 'Tel tokaların hepsi kırıldı, tekrar dene!', 2)
                    cb(false)
                    break
                    end
                    Citizen.Wait(0)
                end
            end)
   

    else
        -- exports['mythic_notify']:SendAlert('error', 'Maymuncuğun yok!')
        TriggerEvent('notification', 'Maymuncuğun yok!', 2)        
    end
    end, source)



end)

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false)
    guiEnabled = false
    cb('ok')
end)

RegisterNUICallback('removepin', function(data, cb)
    --TriggerServerEvent('lsrp-lockpickfo:removePin')
    cb('ok')
end)

RegisterNUICallback('process', function(data, cb)
    SetNuiFocus(false)
    guiEnabled = false
    if data.state then
        action = 'success'
    else
        action = 'failed'
    end
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            --DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click",
                })
            end
        end
        Citizen.Wait(0)
    end
end)