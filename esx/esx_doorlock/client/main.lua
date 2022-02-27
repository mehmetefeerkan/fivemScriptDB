ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	-- Update the door list
	ESX.TriggerServerCallback('esx_doorlock:getDoorInfo', function(doorInfo)
		for doorID,state in pairs(doorInfo) do
			Config.DoorList[doorID].locked = state
		end
	end)
end)

function DrawText3DTest(coords, text, size)

    local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
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


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Get objects every second, instead of every frame
Citizen.CreateThread(function()
	while true do
		for _,doorID in ipairs(Config.DoorList) do
			if doorID.doors then
				for k,v in ipairs(doorID.doors) do
					if not v.object or not DoesEntityExist(v.object) then
						v.object = GetClosestObjectOfType(v.objCoords, 1.0, GetHashKey(v.objName), false, false, false)
					end
				end
			else
				if not doorID.object or not DoesEntityExist(doorID.object) then
					doorID.object = GetClosestObjectOfType(doorID.objCoords, 1.0, GetHashKey(doorID.objName), false, false, false)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true

		for k,doorID in ipairs(Config.DoorList) do
			local distance

			if doorID.doors then
				distance = #(playerCoords - doorID.doors[1].objCoords)
			else
				distance = #(playerCoords - doorID.objCoords)
			end

			local maxDistance = 1.25
			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < 50 then
				letSleep = false

				if doorID.doors then
					for _,v in ipairs(doorID.doors) do
						FreezeEntityPosition(v.object, doorID.locked)

						if doorID.locked and v.objYaw and GetEntityRotation(v.object).z ~= v.objYaw then
							SetEntityRotation(v.object, 0.0, 0.0, v.objYaw, 2, true)
						end
					end
				else
					FreezeEntityPosition(doorID.object, doorID.locked)

					if doorID.locked and doorID.objYaw and GetEntityRotation(doorID.object).z ~= doorID.objYaw then
						SetEntityRotation(doorID.object, 0.0, 0.0, doorID.objYaw, 2, true)
					end
				end
			end

			if distance < maxDistance then
				local isAuthorized = IsAuthorized(doorID)

				local size = 1
				if doorID.size then
					size = doorID.size
				end
				if doorID.locked then
					if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
					closestString = "[E] - Kilitli"
					DrawText3DTest(doorID.textCoords, closestString, size)
					else
					closestString = "Kilitli"
					DrawText3DTest(doorID.textCoords, closestString, size)
					end
				elseif doorID.locked == false then
					if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
					closestString = "[E] - Kilidi Açık"
					DrawText3DTest(doorID.textCoords, closestString, size)
					else
					closestString = "Kilidi Açık"
					DrawText3DTest(doorID.textCoords, closestString, size)
					end
				end
				

				if IsControlJustReleased(0, 38) then
					if isAuthorized then
						doorID.locked = not doorID.locked
						TriggerEvent("dooranim")

						TriggerServerEvent('esx_doorlock:updateState', k, doorID.locked) -- Broadcast new state of the door to everyone
					end
				end
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent( 'dooranim' )
AddEventHandler( 'dooranim', function()
    
    ClearPedSecondaryTask(GetPlayerPed(-1))
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(50)
    ClearPedTasks(GetPlayerPed(-1))

end)

function IsAuthorized(doorID)
	if ESX.PlayerData.job == nil then
		return false
	end

	for _,job in pairs(doorID.authorizedJobs) do
		if job == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

-- Set state for a door
RegisterNetEvent('esx_doorlock:setState')
AddEventHandler('esx_doorlock:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)

RegisterNetEvent('esx_doorlock:currentlyhacking')
AddEventHandler('esx_doorlock:currentlyhacking', function(mycb)
			mycb = true
			TriggerEvent("mhacking:show") --This line is where the hacking even starts
			TriggerEvent("mhacking:start",7,19,mycb1) --This line is the difficulty and tells it to start. First number is how long the blocks will be the second is how much time they have is.
end)