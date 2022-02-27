ESX = nil
local IsHandcuffed = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


RegisterNetEvent('kelepcele:getarrested')
AddEventHandler('kelepcele:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = PlayerPedId()
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)	
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	IsHandcuffed = true
	TriggerEvent("disc-inventoryhud:setHandcuff",IsHandcuffed)
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	TriggerEvent("esx_cuffs:cuffStatus",IsHandcuffed)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'Cuff', 0.1)
	--exports['mythic_notify']:DoHudText('black', "Kelepçelendin")
end)

RegisterNetEvent('kelepcele:doarrested')
AddEventHandler('kelepcele:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
end)

RegisterNetEvent('kelepcele:douncuffing')
AddEventHandler('kelepcele:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('kelepcele:getuncuffed')
AddEventHandler('kelepcele:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = false
	TriggerEvent("disc-inventoryhud:setHandcuff",IsHandcuffed)
	ClearPedTasks(PlayerPedId())
	TriggerEvent("esx_cuffs:cuffStatus",IsHandcuffed)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'Uncuff', 0.1)
	exports['mythic_notify']:DoHudText('black', "Kelepçen Çözüldü")
end)

RegisterNetEvent("kelepce:kirmaBaslat")
AddEventHandler("kelepce:kirmaBaslat",function(targetid, playerheading, playerCoords,  playerlocation)
	TriggerEvent('possibleprogbar:client:progress',{
		name = 'kelepce_kiriliyor',
		duration = 10000,
		label = 'Kelepçeler kırılıyor...',
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			anim = "machinic_loop_mechandplayer",
			flags = 49,
		},
		}, function(status)
			if not status then
				TriggerServerEvent("kelepce:zorlaDone",targetid, playerheading, playerCoords,  playerlocation)
			end
	end)
end)

function specialMenu(menuname,callback)
	local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
	local elements = {}
	local serverIds = {}
	for i = 1, #players, 1 do
		if players[i] ~= PlayerId() then
			table.insert(serverIds, GetPlayerServerId(players[i]))
		end
	end
	ESX.TriggerServerCallback("esx_policejob:getMeNames",function(identities)
		for k,v in pairs(identities) do
			table.insert(elements, {
				player = k,
				label = v
			})
		end		
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'special_cop_menu',
		{
			title = menuname,
			align = 'top-left',
			elements = elements,
		},
		function(data, menu)
			menu.close()
			print(data.current.player)
			callback(data.current.player)
		end,
		function(data, menu)
			menu.close()
		end)
	end,serverIds)		
end

RegisterNetEvent('kelepcele:menuAc')
AddEventHandler('kelepcele:menuAc', function()
	specialMenu("Yakındaki Kişiler",function(player)
		playerheading = GetEntityHeading(PlayerPedId())
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(PlayerPedId())
		TriggerServerEvent("kelepcele:kelepce",player,playerheading,playerlocation,playerCoords)
	end)			
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			--DisableControlAction(0, 1, true) -- Disable pan
			--DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			--DisableControlAction(0, 32, true) -- W
			--DisableControlAction(0, 34, true) -- A
			--DisableControlAction(0, 31, true) -- S
			--DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 157, true) -- 1
			DisableControlAction(0, 158, true) -- 2
			DisableControlAction(0, 160, true) -- 3
			DisableControlAction(0, 164, true) -- 4
			DisableControlAction(0, 165, true) -- 5
			DisableControlAction(1, 157, true) -- 1
			DisableControlAction(1, 158, true) -- 2
			DisableControlAction(1, 160, true) -- 3
			DisableControlAction(1, 164, true) -- 4
			DisableControlAction(1, 165, true) -- 5
			DisableControlAction(2, 157, true) -- 1
			DisableControlAction(2, 158, true) -- 2
			DisableControlAction(2, 160, true) -- 3
			DisableControlAction(2, 164, true) -- 4
			DisableControlAction(2, 165, true) -- 5

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


function loadanimdict(dictname)
      if not HasAnimDictLoaded(dictname) then
          RequestAnimDict(dictname) 
          while not HasAnimDictLoaded(dictname) do 
              Citizen.Wait(1)
          end
      end
end