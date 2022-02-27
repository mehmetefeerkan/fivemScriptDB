ESX = nil
obj = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



RegisterNetEvent('m3:weed:client:usedSeed')
AddEventHandler('m3:weed:client:usedSeed', function(loctable)
	if not DoesEntityExist(obj) then
		local pPed = PlayerPedId()
		local pCoord = GetEntityCoords(pPed)
		local forward = GetEntityForwardVector(pPed)
		x, y, z   = table.unpack(pCoord + forward * 1.0)
		local bolge = vector3(2211.52, 5577.89, 53.8639)
		local distance = #(bolge - pCoord)
		local grow = {2.24, 1.95, 1.65, 1.45, 1.20, 1.10}
		if distance <= 30 then
			TriggerServerEvent('m3:weed:server:removeSeed')
			TaskStartScenarioInPlace(pPed, 'world_human_gardener_plant', 0, false)
			RequestModel('prop_weed_01')
			while not HasModelLoaded('prop_weed_01') do
				Citizen.Wait(1)
			end
			obj = CreateObject(GetHashKey('prop_weed_01'), x, y, z - 2.35, 0, 0, 0)
			for k, v in pairs(grow) do
				local result = exports["reload-skillbar"]:taskBar(6000,math.random(5,15))
				if result == 100 then
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Bitki büyüyor!', length = 5000})
					SetEntityCoords(obj, x, y, z - v, 0, 0, 0, 0)
					Citizen.Wait(5000)
					if v == 1.10 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Bitkinin büyümesi tamamlandı!', length = 5000})
						TriggerServerEvent('m3:weed:server:giveWeed')
						ClearPedTasks(pPed)
						Citizen.Wait(7000)
						if DoesEntityExist(obj) then
							SetEntityCollision(obj, false, false)
							SetEntityAlpha(obj, 0.0, true)
							SetEntityAsMissionEntity(obj, false, true)
							DeleteEntity(obj)
						end
						obj = nil
						return
					end
				else
					ClearPedTasks(pPed)
					if DoesEntityExist(obj) then
						SetEntityCollision(obj, false, false)
						SetEntityAlpha(obj, 0.0, true)
						SetEntityAsMissionEntity(obj, false, true)
						DeleteEntity(obj)
					end
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Bitki soldu!', length = 5000})
					obj = nil
					return
				end
			end
		else
		TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Burası ekmeye elverişli değil!', length = 5000})
		end
	else
		TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Mevcut bir bitkin var!', length = 5000})
	end
end)

RegisterNetEvent('m3:weed:client:usedSeedForSeed')
AddEventHandler('m3:weed:client:usedSeedForSeed', function(loctable)
	if not DoesEntityExist(obj) then
		local pPed = PlayerPedId()
		local pCoord = GetEntityCoords(pPed)
		local forward = GetEntityForwardVector(pPed)
		x, y, z   = table.unpack(pCoord + forward * 1.0)
		local distance = #(loctable.coord - pCoord)
		local grow = {2.24, 1.95, 1.65, 1.45, 1.20, 1.10}
		if distance <= loctable.radius then
			TriggerServerEvent('m3:weed:server:removeSeedForSeed')
			TaskStartScenarioInPlace(pPed, 'world_human_gardener_plant', 0, false)
			RequestModel('prop_weed_01')
			while not HasModelLoaded('prop_weed_01') do
				Citizen.Wait(1)
			end
			obj = CreateObject(GetHashKey('prop_weed_01'), x, y, z - 2.35, 0, 0, 0)
			for k, v in pairs(grow) do
				local result = exports["skillbar"]:oneSkillbar()
				if result then
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Bitki büyüyor!', length = 5000})
					SetEntityCoords(obj, x, y, z - v, 0, 0, 0, 0)
					Citizen.Wait(5000)
					if v == 1.10 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Bitkinin büyümesi tamamlandı!', length = 5000})
						TriggerServerEvent('m3:weed:server:giveSeed')
						ClearPedTasks(pPed)
						Citizen.Wait(7000)
						if DoesEntityExist(obj) then
							SetEntityCollision(obj, false, false)
							SetEntityAlpha(obj, 0.0, true)
							SetEntityAsMissionEntity(obj, false, true)
							DeleteEntity(obj)
						end
						obj = nil
						return
					end
				else
					ClearPedTasks(pPed)
					if DoesEntityExist(obj) then
						SetEntityCollision(obj, false, false)
						SetEntityAlpha(obj, 0.0, true)
						SetEntityAsMissionEntity(obj, false, true)
						DeleteEntity(obj)
					end
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Bitki soldu!', length = 5000})
					obj = nil
					return
				end
			end
		else
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Burası ekmeye elverişli değil!', length = 5000})
		end
	else
		TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Mevcut bir bitkin var!', length = 5000})
	end
end)

RegisterCommand('tarlayiyak', function()
	ESX.TriggerServerCallback('m3:weed:server:getFieldCoord', function(loctable)
		if loctable ~= nil then
			local pPed = PlayerPedId()
			local pCoord = GetEntityCoords(pPed)
			local distance = #(loctable.coord - pCoord)
			if distance <= loctable.radius then
				TriggerServerEvent('m3:weed:server:burnField')
			end
		end
	end)
end)

RegisterNetEvent('m3:weed:client:burnFX')
AddEventHandler('m3:weed:client:burnFX', function(coord)

	for i = 1, 15, 1 do
		StartScriptFire(coord.x + i, coord.y - i, coord.z - 0.7, 25, 1)
		StartScriptFire(coord.x - i, coord.y + i, coord.z - 0.7, 25, 1)
		StartScriptFire(coord.x - i, coord.y - i, coord.z - 0.7, 25, 1)
		StartScriptFire(coord.x + i, coord.y + i, coord.z - 0.7, 25, 1)
	end

	Citizen.Wait(120000)

	StopFireInRange(coord.x, coord.y, coord.z, 30.0)
end)