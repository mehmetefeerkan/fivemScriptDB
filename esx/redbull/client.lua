ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_extraitems:redbull')
AddEventHandler('esx_extraitems:redbull', function()
	local playerPed  = PlayerPedId()
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 18905)
	local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

	RequestAnimDict('mp_player_intdrink')
	while not HasAnimDictLoaded('mp_player_intdrink') do
		Citizen.Wait(1)
	end
	
	ESX.Game.SpawnObject('prop_energy_drink', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		TaskPlayAnim(playerPed, "mp_player_intdrink", "loop_bottle", 1.0, -1.0, 2000, 0, 1, true, true, true)
		AttachEntityToEntity(object, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
		Citizen.Wait(3000)
		DeleteObject(object)
		ClearPedSecondaryTask(playerPed)
	end)
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Redbull Etkisi Başladı.' } )
	
	local timer = 0
	while timer < 300 do
		ResetPlayerStamina(PlayerId())
		Citizen.Wait(2000)
		timer = timer + 2
	end
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Redbull Etkisi Bitti.' } )
end)