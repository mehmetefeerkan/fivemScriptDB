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


RegisterNetEvent('kimlikgör')
AddEventHandler('kimlikgör', function()
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end, false)

RegisterNetEvent('ehliyetgör')
AddEventHandler('ehliyetgör', function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
end, false)




-----------------------------------------------------------------------------------------------------------------------

--KIMLIKLERI KARSI OYUNCUYA GOSTERIR



RegisterNetEvent('kimlikver')
AddEventHandler('kimlikver', function(showID)
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
       if showID ~= true then
       TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
       end
       else
       ESX.ShowNotification('Yakınında Oyuncu Yok!')
           exports['mythic_notify']:DoHudText('inform', "Yakında oyuncu yok", 8000)
   
       end
    end, false)

    RegisterNetEvent('ehliyetver')
AddEventHandler('ehliyetver', function(showID)
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
      if showDriver ~= true then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
      end
      else
          exports['mythic_notify']:DoHudText('inform', "Yakında oyuncu yok", 8000)
      end
    end, false)


-----------------------------------------------------------------------------------------------------------------------
 
Citizen.CreateThread(function()
    while true do
        Wait(0)
		
        if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
            SendNUIMessage({
                action = "close"
            })
            open = false
        end
    end
end)