--[[------------------------------------------------------------------------

	sup_wallet - İtemli Cüzdan Scripti (actionmenu script edit)

------------------------------------------------------------------------]]--

local menuEnabled = false 
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function ToggleActionMenu()

	menuEnabled = not menuEnabled

	if ( menuEnabled ) then 

		SetNuiFocus( true, true )

		SendNUIMessage({
			showmenu = true 
		})
	else 

		SetNuiFocus( false )

		SendNUIMessage({
			hidemenu = true 
		})
	end 
end 

RegisterNUICallback( "ButtonClick", function( data, cb ) 
	if ( data == "button1" ) then 
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		
	elseif ( data == "button2" ) then 
		
		local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
			  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
			else
			-- exports['mythic_notify']:SendAlert('inform', 'Yakında birisi yok', 2500)
			TriggerEvent('notification', 'Yakında birisi yok', 2)
			end
		
	elseif ( data == "button3" ) then 
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		
	elseif ( data == "button4" ) then 
		
	local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
			  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
			else
			-- exports['mythic_notify']:SendAlert('inform', 'Yakında birisi yok', 2500)
			TriggerEvent('notification', 'Yakında birisi yok', 2)
			end
		
	elseif ( data == "button5" ) then 
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
	elseif ( data == "button6" ) then 
		
		local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
			  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
			else
			-- exports['mythic_notify']:SendAlert('inform', 'Yakında birisi yok', 2500)
			TriggerEvent('notification', 'Yakında birisi yok', 2)
			end
	
	elseif ( data == "exit" ) then 
		ToggleActionMenu()
		return 
	end 

	ToggleActionMenu()
end )

Citizen.CreateThread( function()
	SetNuiFocus( false )

	while true do 
		-- Menü açıldığında devre dışı bırakılan tuşlar
		-- Farklı bir tuş eklemek için https://wiki.fivem.net/wiki/Controls sitesinden tuş koduna bakabilirsin 

	    if ( menuEnabled ) then
            local ped = GetPlayerPed( -1 )	

            DisableControlAction( 0, 1, true ) -- Sağa sola bakma
            DisableControlAction( 0, 2, true ) -- Yukarı aşağı bakma
            DisableControlAction( 0, 24, true ) -- Vurma
            DisablePlayerFiring( ped, true ) -- Silah Sıkması
            DisableControlAction( 0, 142, true ) -- Yakın Dövüş
            DisableControlAction( 0, 106, true ) -- Araç Faresi
        end

		Citizen.Wait( 0 )
	end 
end )

RegisterNetEvent("sup_wallet:ToggleMenu") -- Başka bir scriptte bu menüyü açmak için kullanabilirsin
AddEventHandler("sup_wallet:ToggleMenu", function()
    ToggleActionMenu()
end)