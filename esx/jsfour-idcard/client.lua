local open = false
local ESX  = nil
 
-- ESX
-- Added this so you can include the rest of the Usage-stuff found on the GitHub page
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
 
-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
    open = true
    SendNUIMessage({
        action = "open",
        array  = data,
        type   = type
    })
end)
 
--KIMLIKLERI KENDI GORUR
 RegisterCommand("kimlikgör", function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end, false)
AddEventHandler("kimlikgor_f3",function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)
AddEventHandler("kimlikgoster_f3",function()
	local player, distance = ESX.Game.GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
	else
		ESX.ShowNotification('Yakınında Oyuncu Yok!')
	end
	
end)

AddEventHandler("kimlikgor2_f3",function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
end)
AddEventHandler("kimlikgoster2_f3",function()
	local player, distance = ESX.Game.GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
	else
		ESX.ShowNotification('Yakınında Oyuncu Yok!')
	end
	
end)
 RegisterCommand("ehliyetgör", function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
end, false)

 RegisterCommand("ruhsatgör", function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
end, false)

-----------------------------------------------------------------------------------------------------------------------

--KIMLIKLERI KARSI OYUNCUYA GOSTERIR
 RegisterCommand("kimlikver", function(showID)
 local player, distance = ESX.Game.GetClosestPlayer()
 if distance ~= -1 and distance <= 3.0 then
    if showID ~= nil then
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
	end
	else
	ESX.ShowNotification('Yakınında Oyuncu Yok!')
	end
end, false)

 RegisterCommand("ehliyetver", function(showDriver)
  local player, distance = ESX.Game.GetClosestPlayer()
  if distance ~= -1 and distance <= 3.0 then
    if showDriver ~= nil then
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
	end
	else
	ESX.ShowNotification('Yakınında Oyuncu Yok!')
	end
end, false)

 RegisterCommand("ruhsatver", function(showWeapon)
   local player, distance = ESX.Game.GetClosestPlayer()
   if distance ~= -1 and distance <= 3.0 then
    if showWeapon ~= nil then
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
	end
	else
	ESX.ShowNotification('Yakınında Oyuncu Yok!')
	end
end, false)


-----------------------------------------------------------------------------------------------------------------------
 
Citizen.CreateThread(function()
    while true do
        Wait(0)
		
        if IsControlJustReleased(0, 3) and open or IsControlJustReleased(0, 177) and open or IsControlJustReleased(0, 322) and open then
            SendNUIMessage({
                action = "close"
            })
            open = false
        end
    end
end)