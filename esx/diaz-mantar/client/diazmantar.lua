local spawnedmantars = 0
local mantarPlants = {}
local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.mantarField.coords, true) < 50 then
			SpawnmantarPlants()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.mantarProcessing.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('mantar_processprompt'))
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							Processmantar()
						else
							OpenBuyLicenseMenu('mantar_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'mantar_processing')
				else
					Processmantar()
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function Processmantar()
	isProcessing = true

	ESX.ShowNotification(_U('mantar_processingstarted'))
	TriggerServerEvent('diaz_mantar:processCannabis')
	local timeLeft = Config.Delays.mantarProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.mantarProcessing.coords, false) > 4 then
			ESX.ShowNotification(_U('mantar_processingtoofar'))
			TriggerServerEvent('diaz_mantar:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #mantarPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(mantarPlants[i]), false) < 1 then
				nearbyObject, nearbyID = mantarPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
			if not isPickingUp then
				ESX.ShowHelpNotification(_U('mantar_pickupprompt'))
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('diaz_mantar:canPickUp', function(canPickUp)
					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(mantarPlants, nearbyID)
						spawnedmantars = spawnedmantars - 1
		
						TriggerServerEvent('diaz_mantar:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('mantar_inventoryfull'))
					end

					isPickingUp = false
				end, 'mantar')
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(mantarPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnmantarPlants()
	while spawnedmantars < 25 do
		Citizen.Wait(0)
		local mantarCoords = GeneratemantarCoords()

		ESX.Game.SpawnLocalObject('prop_stoneshroom1', mantarCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(mantarPlants, obj)
			spawnedmantars = spawnedmantars + 1
		end)
	end
end

function ValidatemantarCoord(plantCoord)
	if spawnedmantars > 0 then
		local validate = true

		for k, v in pairs(mantarPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.mantarField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratemantarCoords()
	while true do
		Citizen.Wait(1)

		local mantarCoordX, mantarCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		mantarCoordX = Config.CircleZones.mantarField.coords.x + modX
		mantarCoordY = Config.CircleZones.mantarField.coords.y + modY

		local coordZ = GetCoordZ(mantarCoordX, mantarCoordY)
		local coord = vector3(mantarCoordX, mantarCoordY, coordZ)

		if ValidatemantarCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end
