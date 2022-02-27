ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
  end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local yatagitutuyorsun = false
local yatiyorsun = false

RegisterNetEvent('doktor:sedyeislemleri')
AddEventHandler('doktor:sedyecikar', function()
	local playerPed = PlayerPedId()							
	local x, y, z   = table.unpack(GetEntityCoords(playerPed))
	local xF = GetEntityForwardX(playerPed) * 1.0
	local yF = GetEntityForwardY(playerPed) * 1.0
	
	ESX.Game.SpawnObject('v_med_bed2', {
		x = x + xF + 0.5,
		y = y + yF - 0.1,
		z = z
	}, function(obj)
		-- chairs
		SetEntityHeading(obj, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
	end)
end, false)

AddEventHandler('doktor:sedyesil', function()
	local playerPed = PlayerPedId()
	local wheelchair = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('v_med_bed2'))

	if DoesEntityExist(wheelchair) then
		DeleteEntity(wheelchair)
		ClearPedTasks(playerPed)
	end
end, false)

Citizen.CreateThread(function()
	while true do
		local sleep = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed2"), false)

		if DoesEntityExist(closestObject) then
			sleep = 5

			local wheelChairCoords = GetEntityCoords(closestObject)
			local wheelChairForward = GetEntityForwardVector(closestObject)
			local wheelChairY = GetEntityForwardY(closestObject)
			
			local sitCoords = (wheelChairCoords + wheelChairForward * - 1.0)
			local pickupCoords = (wheelChairCoords + wheelChairForward * 1.2)
			local sagoturCoords = (wheelChairCoords + wheelChairForward * - 0.5)
			local soloturCoords = (wheelChairCoords + wheelChairForward * - 0.1)
			local dikyatCoords = (wheelChairCoords + wheelChairForward * 0.8 + wheelChairY * -0.2)
			
			if GetDistanceBetweenCoords(pedCoords, soloturCoords, true) <= 1.5 then
				if not yatiyorsun then
				DrawText3Ds(sitCoords, "[E] Yat", 1.0)
				end

				if IsControlJustPressed(0, 38) then
					Yat(closestObject)
				end
			end

			if GetDistanceBetweenCoords(pedCoords, sagoturCoords, true) <= 1.5 then
				if not yatiyorsun then
				DrawText3Ds(sagoturCoords, "[G] Sag Otur", 1.0)
				end

				if IsControlJustPressed(0, 47) then
					Sagotur(closestObject)
				end
			end
			if GetDistanceBetweenCoords(pedCoords, soloturCoords, true) <= 1.5 then
				if not yatiyorsun then
				DrawText3Ds(soloturCoords, "[Y] Sol Otur", 1.0)
				end

				if IsControlJustPressed(0, 246) then
					Solotur(closestObject)
				end
			end

			if GetDistanceBetweenCoords(pedCoords, soloturCoords, true) <= 1.5 then
				if not yatiyorsun and not yatagitutuyorsun then
				DrawText3Ds(dikyatCoords, "[L] Dik Yat", 1.0)
				end

				if IsControlJustPressed(0, 182) then
					Dikyat(closestObject)
				end
			end
			
			if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 1.5 then
				if PlayerData.job and PlayerData.job.name == 'ambulance' then
					if not yatagitutuyorsun then				
						DrawText3Ds(pickupCoords, "/sedyeyikullan", 1.0)
					end
				end
			end
		end

		Citizen.Wait(sleep)
	end
end)

RegisterCommand('sedyeyikullan', function()
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed2"), false)
	local wheelChairCoords = GetEntityCoords(closestObject)
	local wheelChairForward = GetEntityForwardVector(closestObject)
	local pickupCoords = (wheelChairCoords + wheelChairForward * 1.2)
	if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 1.0 then
		if PlayerData.job and PlayerData.job.name == 'ambulance' then
			PickUp(closestObject)
		end
	end
end)
	

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread( function()

	while true do
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed2"), false)
		local wheelChairCoords = GetEntityCoords(closestObject)
		local wheelChairForward = GetEntityForwardVector(closestObject)
		local soloturCoords = (wheelChairCoords + wheelChairForward * - 0.1)
		local pickupCoords = (wheelChairCoords + wheelChairForward * 1.2)
		Citizen.Wait(0)
		if yatagitutuyorsun then
			DrawText2D('F ile sedyeyi bırakabilirsin!',0,1,0.086,0.77,0.6,255,255,255,255)
		end
		if yatiyorsun then
			DrawText2D('F ile kalkabilirsin!',0,1,0.086,0.77,0.6,255,255,255,255)
		end
	end
end)

Sit = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			ShowNotification("Somebody is already using the wheelchair!")
			return
		end
	end

	LoadAnim("missfinale_c2leadinoutfin_c_int")

	AttachEntityToEntity(PlayerPedId(), wheelchairObject, 0, 0, 0.0, 0.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(wheelchairObject)

	while IsEntityAttachedToEntity(PlayerPedId(), wheelchairObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			TaskPlayAnim(PlayerPedId(), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 8.0, 8.0, -1, 69, 1, false, false, false)
			yatiyorsun = true
		end

		if IsControlPressed(0, 32) then
			local x, y, z  = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * -0.02)
			SetEntityCoords(wheelchairObject, x,y,z)
			PlaceObjectOnGroundProperly(wheelchairObject)
		end

		if IsControlPressed(1,  34) then
			heading = heading + 0.4

			if heading > 360 then
				heading = 0
			end

			SetEntityHeading(wheelchairObject,  heading)
		end

		if IsControlPressed(1,  9) then
			heading = heading - 0.4

			if heading < 0 then
				heading = 360
			end

			SetEntityHeading(wheelchairObject,  heading)
		end

		if IsControlJustPressed(0, 75) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
			yatiyorsun = false
		end
	end
end

Dikyat = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'timetable@amanda@drunk@base', 'base', 3) then
			return
		end
	end

	LoadAnim("timetable@amanda@drunk@base")

	AttachEntityToEntity(PlayerPedId(), wheelchairObject, 0, 0, 0.9, 1.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(wheelchairObject)

	while IsEntityAttachedToEntity(PlayerPedId(), wheelchairObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), 'timetable@amanda@drunk@base', 'base', 3) then
			TaskPlayAnim(PlayerPedId(), 'timetable@amanda@drunk@base', 'base', 8.0, 8.0, -1, 69, 1, false, false, false)
			yatiyorsun = true
		end
		
		if IsControlJustPressed(0, 75) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
			yatiyorsun = false
		end
	end
end

Sagotur = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'amb@prop_human_seat_chair_mp@male@generic@base', 'base', 3) then
			return
		end
	end

	LoadAnim("amb@prop_human_seat_chair_mp@male@generic@base")

	AttachEntityToEntity(PlayerPedId(), wheelchairObject, 0, -0.2, 0.0, 0.4, 0.0, 0.0, 90.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(wheelchairObject)

	while IsEntityAttachedToEntity(PlayerPedId(), wheelchairObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), 'amb@prop_human_seat_chair_mp@male@generic@base', 'base', 3) then
			TaskPlayAnim(PlayerPedId(), 'amb@prop_human_seat_chair_mp@male@generic@base', 'base', 8.0, 8.0, -1, 69, 1, false, false, false)
			yatiyorsun = true
		end

		if IsControlJustPressed(0, 75) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
			yatiyorsun = false
		end
	end
end

Solotur = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'amb@prop_human_seat_chair_mp@male@generic@base', 'base', 3) then
			return
		end
	end

	LoadAnim("amb@prop_human_seat_chair_mp@male@generic@base")

	AttachEntityToEntity(PlayerPedId(), wheelchairObject, 0, 0.2, 0.0, 0.4, 0.0, 0.0, 270.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(wheelchairObject)

	while IsEntityAttachedToEntity(PlayerPedId(), wheelchairObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), 'amb@prop_human_seat_chair_mp@male@generic@base', 'base', 3) then
			TaskPlayAnim(PlayerPedId(), 'amb@prop_human_seat_chair_mp@male@generic@base', 'base', 8.0, 8.0, -1, 69, 1, false, false, false)
			yatiyorsun = true
		end

		if IsControlJustPressed(0, 75) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
			yatiyorsun = false
		end
	end
end

Yat = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@gangops@morgue@table@', 'body_search', 3) then
			return
		end
	end

	LoadAnim("anim@gangops@morgue@table@")

	AttachEntityToEntity(PlayerPedId(), wheelchairObject, 0, 0, 0.0, 1.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(wheelchairObject)

	while IsEntityAttachedToEntity(PlayerPedId(), wheelchairObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@gangops@morgue@table@', 'body_search', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@gangops@morgue@table@', 'body_search', 8.0, 8.0, -1, 69, 1, false, false, false)
			yatiyorsun = true
		end

		if IsControlJustPressed(0, 75) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
			yatiyorsun = false
		end
	end
end
		
PickUp = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()
	local playerPed = PlayerPedId()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
			ESX.ShowNotification("Birisi zaten sedyeyi kullanıyor!")
			return
		end
	end

	NetworkRequestControlOfEntity(wheelchairObject)

	LoadAnim("anim@heists@box_carry@")

	AttachEntityToEntity(wheelchairObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.00, -1.10, -1.0, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(wheelchairObject, PlayerPedId()) do
		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
			yatagitutuyorsun = true
		end

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(wheelchairObject, true, true)
		end

		if IsControlJustPressed(0, 23) then
			local playerPed = PlayerPedId()
			DetachEntity(wheelchairObject, true, true)
			yatagitutuyorsun = false
			Citizen.Wait(100)
			ClearPedTasks(playerPed)
		end
	end
end

DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function DrawText2D(text,font,centre,x,y,scale,r,g,b,a)
	oCanSleep = false

	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.40, 0.40)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
	local factor = (string.len(text)) / 350
	DrawRect(x,y+0.0150, 0.080+ factor, 0.03, 41, 11, 41, 68)
end

GetPlayers = function()
    local players = {}

for _, player in ipairs(GetActivePlayers()) do
            table.insert(players, i)
    end

    return players
end

GetClosestPlayer = function()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

LoadAnim = function(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		
		Citizen.Wait(1)
	end
end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		
		Citizen.Wait(1)
	end
end