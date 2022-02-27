ESX          = nil
local IsDead = false
local IsAnimated = false
local drunk = false
local drunkeffected = false
local drunklevel = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
	TriggerEvent('esx_status:set', 'stress', 10)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst & stress
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'stress', 10)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return true
	end, function(status)
		status.remove(75)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name, posx, posy, posz, rotx, roty, rotz)
	local ped = GetPlayerPed(-1)
	if not IsPedInVehicle(ped, false, false) then
		if not IsAnimated then
			IsAnimated = true
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			if prop_name ~= nil then
				RequestModel(GetHashKey(prop_name))
				while not HasModelLoaded(GetHashKey(prop_name)) do
					Citizen.Wait(1)
				end

				prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, posx or 0.12, posy or 0.028, posz or 0.001, rotx or 10.0, roty or 175.0, rotz or 0.0, true, true, false, true, 1, true)
			end

			-- prop_name = prop_name or 'prop_cs_burger_01'

			exports['mythic_progbar']:Progress({
				name = "eat",
				duration = 7000,
				label = 'Yeniliyor...',
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_inteat@burger",
					anim = "mp_player_int_eat_burger_fp",
					flags = 49,
				},
			}, function(cancelled)
				if not cancelled then
					DeleteObject(prop)
					prop = nil
					IsAnimated = false
				end
			end)
		end
	else
		exports['mythic_progbar']:Progress({
			name = "eat",
			duration = 7000,
			label = 'Yeniliyor...',
			useWhileDead = false,
			canCancel = false,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
		})
	end
end)

RegisterNetEvent('esx_basicneeds:onEatdildo')
AddEventHandler('esx_basicneeds:onEatdildo', function(prop_name, posx, posy, posz, rotx, roty, rotz)
	local ped = GetPlayerPed(-1)
	if not IsPedInVehicle(ped, false, false) then
		if not IsAnimated then
			IsAnimated = true
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			if prop_name ~= nil then
				RequestModel(GetHashKey(prop_name))
				while not HasModelLoaded(GetHashKey(prop_name)) do
					Citizen.Wait(1)
				end

				prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, posx or 0.12, posy or 0.028, posz or 0.001, rotx or 10.0, roty or 175.0, rotz or 0.0, true, true, false, true, 1, true)
			end

			-- prop_name = prop_name or 'prop_cs_burger_01'

			exports['mythic_progbar']:Progress({
				name = "eat",
				duration = 22000,
				label = 'Dildoya Sakso Çekiliyor...',
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_inteat@burger",
					anim = "mp_player_int_eat_burger_fp",
					flags = 49,
				},
			}, function(cancelled)
				if not cancelled then
					DeleteObject(prop)
					prop = nil
					IsAnimated = false
				end
			end)
		end
	else
		exports['mythic_progbar']:Progress({
			name = "eat",
			duration = 22000,
			label = 'Dildoya Sakso Çekiliyor...',
			useWhileDead = false,
			canCancel = false,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
		})
	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name, posx, posy, posz, rotx, roty, rotz)
	local ped = GetPlayerPed(-1)
	if not IsPedInVehicle(ped, false, false) then
		if not IsAnimated then
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))

			if prop_name ~= nil then
				RequestModel(GetHashKey(prop_name))
				while not HasModelLoaded(GetHashKey(prop_name)) do
					Citizen.Wait(1)
				end

				prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, posx or 0.12, posy or 0.006, posz or 0.03, rotx or 240.0, roty or -65.0, rotz or 0.0, true, true, false, true, 1, true)
			end

			-- prop_name = prop_name or 'prop_ld_flow_bottle'
			IsAnimated = true

			exports['mythic_progbar']:Progress({
				name = "drink",
				duration = 10000,
				label = 'İçiliyor...',
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "friends@frl@ig_1",
					anim = "drink_lamar",
					flags = 49,
				},
			}, function(cancelled)
				if not cancelled then
					DeleteObject(prop)
					prop = nil
					IsAnimated = false
				end
			end)
		end
	else
		exports['mythic_progbar']:Progress({
			name = "eat",
			duration = 7000,
			label = 'İçiliyor...',
			useWhileDead = false,
			canCancel = false,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
		})
	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkAlcohol')
AddEventHandler('esx_basicneeds:onDrinkAlcohol', function(prop_name, posx, posy, posz, rotx, roty, rotz)
	local ped = GetPlayerPed(-1)
	if not IsPedInVehicle(ped, false, false) then
		if not IsAnimated then
			if prop_name ~= nil then
				RequestModel(GetHashKey(prop_name))
				while not HasModelLoaded(GetHashKey(prop_name)) do
					Citizen.Wait(1)
				end
			end

			-- prop_name = prop_name or 'prop_ld_flow_bottle'
			IsAnimated = true

			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, posx or 0.12, posy or 0.006, posz or 0.03, rotx or 240.0, roty or -65.0, rotz or 0.0, true, true, false, true, 1, true)

			exports['mythic_progbar']:Progress({
				name = "drink",
				duration = 10000,
				label = 'İçiliyor...',
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "amb@code_human_wander_drinking@beer@male@base",
					anim = "static",
					flags = 49,
				},
			}, function(cancelled)
				if not cancelled then
					DeleteObject(prop)
					prop = nil
					IsAnimated = false
				end
			end)
		end
	else
		exports['mythic_progbar']:Progress({
			name = "eat",
			duration = 7000,
			label = 'İçiliyor...',
			useWhileDead = false,
			canCancel = false,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
		})
	end
end)

RegisterNetEvent('esx_basicneeds:onSmoke')
AddEventHandler('esx_basicneeds:onSmoke', function()
	local ped = GetPlayerPed(-1)
	if not IsPedInVehicle(ped, false, false) then
		prop_name = 'ng_proc_cigarette01a' ---used cigarett prop for now. Tired of trying to place object.
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 64017)
				
		if not IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) then
			RequestAnimDict("amb@world_human_smoking@male@male_b@idle_a")
			while not HasAnimDictLoaded("amb@world_human_smoking@male@male_b@idle_a") do
				Citizen.Wait(100)
			end
			
			AttachEntityToEntity(prop, ped, boneIndex, 0.015, 0.0100, 0.0250, 0.024, -100.0, 40.0, true, true, false, true, 1, true)
			TaskPlayAnim(ped, 'amb@world_human_smoking@male@male_b@idle_a', 'idle_a', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
			while true do
				Citizen.Wait(3)
				if IsControlJustPressed(0, 73) then -- key x
					ClearPedSecondaryTask(ped)
					DeleteObject(prop)
					break
				end
			end
		end
	end
end)

RegisterNetEvent('esx_basicneeds:onPill')
AddEventHandler('esx_basicneeds:onPill', function()
	local ped = GetPlayerPed(-1)
	if not IsPedInVehicle(ped, false, false) then
		if not IsAnimated then
			exports['mythic_progbar']:Progress({
				name = "drink",
				duration = 3000,
				label = 'İçiliyor...',
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_suicide",
					anim = "pill_fp",
					flags = 49,
				},
			}, function(cancelled)
				if not cancelled then
					IsAnimated = false
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_basicneeds:addDrunkLevel')
AddEventHandler('esx_basicneeds:addDrunkLevel', function(level)
	drunk = true
	drunklevel = drunklevel + level
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		if drunk then
			drunklevel = drunklevel - 15
			if drunklevel <= 0 then
				drunk = false
				drunklevel = 0
				removeDrunkEffect()
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if drunk then
			if drunklevel >= 30 then
				drunkEffect()
			end
		end
	end
end)

function drunkEffect()
	if not drunkeffected then
		local playerPed = PlayerPedId()
		RequestAnimSet("move_m@drunk@moderatedrunk")
		
		while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
			Citizen.Wait(0)
		end
		SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)
		drunkeffected = true
	end
end

function removeDrunkEffect()
	local playerPed = PlayerPedId()
	ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
	SetPedMotionBlur(playerPed, false)
	drunkeffected = false
end