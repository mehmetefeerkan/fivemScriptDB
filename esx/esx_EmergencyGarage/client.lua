--------------------------------
------- Created by Hamza -------
-------------------------------- 

ESX = nil

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end


local insideMarker = false

-- Core Thread Function:
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(PlayerPedId())
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
		
		if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDatabaseName  then
			for k,v in pairs(Config.CarZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 8.0) and insideMarker == false then
						DrawMarker(Config.PoliceCarMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceCarMarkerScale.x, Config.PoliceCarMarkerScale.y, Config.PoliceCarMarkerScale.y, Config.PoliceCarMarkerColor.r,Config.PoliceCarMarkerColor.g,Config.PoliceCarMarkerColor.b,Config.PoliceCarMarkerColor.a, false, true, 2, true, false, false, false)						
					end
					if (distance < 8.0 ) and insideMarker == false then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.CarDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenCarGarage) then
							PoliceGarage('car')
							insideMarker = true
							Citizen.Wait(500)
						end
					end
				end
			
			end
		else
			if  ESX.PlayerData.job and ESX.PlayerData.job.name == Config.AmbulanceDatabaseName  then

				for k,v in pairs(Config.AmbulanceCar) do
					for i = 1, #v.Pos, 1 do
						local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
						if (distance < 8.5) and insideMarker == false then
							DrawMarker(Config.AmbulanceCarMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.AmbulanceCarMarkerScale.x, Config.AmbulanceCarMarkerScale.y, Config.AmbulanceCarMarkerScale.z, Config.AmbulanceCarMarkerColor.r,Config.AmbulanceCarMarkerColor.g,Config.AmbulanceCarMarkerColor.b,Config.AmbulanceCarMarkerColor.a, false, true, 2, true, false, false, false)						
						end
						if (distance < 8.0 ) and insideMarker == false then
							DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.AmbulanceDraw3DText)
							if IsControlJustPressed(0, Config.KeyToOpenCarGarage2) then
								PoliceGarage('ambulance')
								insideMarker = true
								Citizen.Wait(900)
							end
						end
					end
				end
			end

	
			if  ESX.PlayerData.job and ESX.PlayerData.job.name == Config.AmbulanceDatabaseName  then

			for k,v in pairs(Config.HeliZones2) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 8.0) and insideMarker == false then
						DrawMarker(Config.PoliceHeliMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.95, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceHeliMarkerScale.x, Config.PoliceHeliMarkerScale.y, Config.PoliceHeliMarkerScale.z, Config.PoliceHeliMarkerColor.r,Config.PoliceHeliMarkerColor.g,Config.PoliceHeliMarkerColor.b,Config.PoliceHeliMarkerColor.a, false, true, 2, true, false, false, false)						
					end
					if (distance < 8.0 ) and insideMarker == false then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.HeliDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenHeliGarage) then
							PoliceGarage('helicopter')
							insideMarker = true
							Citizen.Wait(700)
						end
					end
				end
			end
		end
		if  ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDatabaseName  then

			for k,v in pairs(Config.BoatZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 8.0) and insideMarker == false then
						DrawMarker(Config.PoliceBoatMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceBoatMarkerScale.x, Config.PoliceBoatMarkerScale.y, Config.PoliceBoatMarkerScale.z, Config.PoliceBoatMarkerColor.r,Config.PoliceBoatMarkerColor.g,Config.PoliceBoatMarkerColor.b,Config.PoliceBoatMarkerColor.a, false, true, 2, true, false, false, false)						
					end
					if (distance < 8.0 ) and insideMarker == false then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.BoatDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenBoatGarage) then
							PoliceGarage('boat')
							insideMarker = true
							Citizen.Wait(800)
						end
					end
				end
			end
			end
			if  ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDatabaseName  then

			for k,v in pairs(Config.ExtraZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					
					if (distance < 2.4 ) and insideMarker == false and pedInVeh then
						DrawMarker(Config.PoliceExtraMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceExtraMarkerScale.x, Config.PoliceExtraMarkerScale.y, Config.PoliceExtraMarkerScale.z, Config.PoliceExtraMarkerColor.r,Config.PoliceExtraMarkerColor.g,Config.PoliceExtraMarkerColor.b,Config.PoliceExtraMarkerColor.a, false, true, 2, true, false, false, false)
					end
					if (distance < 2.4 ) and insideMarker == false and pedInVeh then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.ExtraDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenExtraGarage) and GetVehicleClass(veh) == 18 then
							OpenMainMenu()
							insideMarker = true
							Citizen.Wait(800)
						end
					end
				end
				end
			end
			if  ESX.PlayerData.job and ESX.PlayerData.job.name == Config.AmbulanceDatabaseName  then

			for k,v in pairs(Config.ExtraZones2) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					
					if (distance < 2.4) and insideMarker == false and pedInVeh then
						DrawMarker(Config.AmbulanceExtraMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.AmbulanceExtraMarkerScale.x, Config.AmbulanceExtraMarkerScale.y, Config.AmbulanceExtraMarkerScale.z, Config.AmbulanceExtraMarkerColor.r,Config.AmbulanceExtraMarkerColor.g,Config.AmbulanceExtraMarkerColor.b,Config.AmbulanceExtraMarkerColor.a, false, true, 2, true, false, false, false)
					end
					if (distance < 2.4 ) and insideMarker == false and pedInVeh then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.ExtraDraw3DText2)
						if IsControlJustPressed(0, Config.KeyToOpenExtraGarage) and GetVehicleClass(veh) == 18 then
							OpenMainMenu()
							insideMarker = true
							Citizen.Wait(800)
						end
					end
				end
			end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(PlayerPedId())
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
if  ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDatabaseName  then

	for k,v in pairs(Config.HeliZones) do
		for i = 1, #v.Pos, 1 do
			local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
			if (distance < 8.2) and insideMarker == false then
				DrawMarker(Config.AmbulanceHeliMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.95, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.AmbulanceHeliMarkerScale.x, Config.AmbulanceHeliMarkerScale.y, Config.AmbulanceHeliMarkerScale.z, Config.AmbulanceHeliMarkerColor.r,Config.AmbulanceHeliMarkerColor.g,Config.AmbulanceHeliMarkerColor.b,Config.AmbulanceHeliMarkerColor.a, false, true, 2, true, false, false, false)						
			end
			if (distance < 8.0 ) and insideMarker == false then
				DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.AmbulanceHeliDraw3DText)
				if IsControlJustPressed(0, Config.KeyToOpenHeliGarage) then
					PoliceGarage('helicopter')
					insideMarker = true
					Citizen.Wait(800)
				end
			end
		end
	end
	end
end
end)



-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5)
-- 		local coords = GetEntityCoords(PlayerPedId())
-- 		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
-- 		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
		
-- 			if  ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDatabaseName  then

-- 			for k,v in pairs(Config.ExtraZones) do
-- 				for i = 1, #v.Pos, 1 do
-- 					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					
-- 					if (distance < 8.2) and insideMarker == false and pedInVeh then
-- 						DrawMarker(Config.PoliceExtraMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceExtraMarkerScale.x, Config.PoliceExtraMarkerScale.y, Config.PoliceExtraMarkerScale.z, Config.PoliceExtraMarkerColor.r,Config.PoliceExtraMarkerColor.g,Config.PoliceExtraMarkerColor.b,Config.PoliceExtraMarkerColor.a, false, true, 2, true, false, false, false)
-- 					end
-- 					if (distance < 8.0 ) and insideMarker == false and pedInVeh then
-- 						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.ExtraDraw3DText)
-- 						if IsControlJustPressed(0, Config.KeyToOpenExtraGarage) and GetVehicleClass(veh) == 18 then
-- 							OpenMainMenu()
-- 							insideMarker = true
-- 							Citizen.Wait(800)
-- 						end
-- 					end
-- 				end
-- 				end
-- 			end
-- 			if  ESX.PlayerData.job and ESX.PlayerData.job.name == Config.AmbulanceDatabaseName  then

-- 			for k,v in pairs(Config.ExtraZones2) do
-- 				for i = 1, #v.Pos, 1 do
-- 					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					
-- 					if (distance < 8.2) and insideMarker == false and pedInVeh then
-- 						DrawMarker(Config.AmbulanceExtraMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.AmbulanceExtraMarkerScale.x, Config.AmbulanceExtraMarkerScale.y, Config.AmbulanceExtraMarkerScale.z, Config.AmbulanceExtraMarkerColor.r,Config.AmbulanceExtraMarkerColor.g,Config.AmbulanceExtraMarkerColor.b,Config.AmbulanceExtraMarkerColor.a, false, true, 2, true, false, false, false)
-- 					end
-- 					if (distance < 8.0 ) and insideMarker == false and pedInVeh then
-- 						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.ExtraDraw3DText2)
-- 						if IsControlJustPressed(0, Config.KeyToOpenExtraGarage) and GetVehicleClass(veh) == 18 then
-- 							OpenMainMenu()
-- 							insideMarker = true
-- 							Citizen.Wait(800)
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)








-- Police Garage Menu:
PoliceGarage = function(type)
	local elements = {
		{ label = Config.LabelGetVeh, action = "get_vehicle" },
		{ label = Config.LabelStoreVeh, action = "store_vehicle" },
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_policeGarage_menu",
		{
			title    = Config.TitlePoliceGarage,
			align    = "center",
			elements = elements
		},
	function(data, menu)
		menu.close()
		local action = data.current.action
		if action == "get_vehicle" then
			if type == 'car' then
				VehicleMenu('car')
			elseif type == 'ambulance' then
				VehicleMenu('ambulance')
			elseif type == 'helicopter' then
				VehicleMenu('helicopter')
			elseif type == 'boat' then
				VehicleMenu('boat')
			end
		elseif data.current.action == 'store_vehicle' then
			local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)
			if dist < 3 then
				DeleteEntity(veh)
				exports['mythic_notify']:DoHudText('inform', Config.VehicleParked)

			else
				exports['mythic_notify']:DoHudText('inform', Config.NoVehicleNearby)

			end
			insideMarker = false
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Vehicle Spawn Menu:
VehicleMenu = function(type)
	local storage = nil
	local elements = {}
	local ped = PlayerPedId()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(ped)
	
	if type == 'car' then
		for k,v in pairs(Config.PoliceVehicles) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})
		end
	elseif type == 'ambulance' then
			for k,v in pairs(Config.AmbulanceVehicles) do
				table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'ambulance'})
			end
	elseif type == 'helicopter' then
		for k,v in pairs(Config.PoliceHelicopters) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'helicopter'})
		end
	elseif type == 'helicopter' then
		for k,v in pairs(Config.AmbulanceHelicopters) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'helicopter'})
		end
	elseif type == 'boat' then
		for k,v in pairs(Config.PoliceBoats) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'boat'})
		end
	end
		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_policeGarage_vehicle_garage",
		{
			title    = Config.TitlePoliceGarage,
			align    = "center",
			elements = elements
		},
	function(data, menu)
		menu.close()
		insideMarker = false
		VehicleLoadTimer(data.current.model)
		local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,GetEntityHeading(playerPed),true,false)
		SetPedIntoVehicle(PlayerPedId(),veh,-1)
		local plate = SetVehicleNumberPlateText(veh, string.char(math.random(65, 90), math.random(65, 90), math.random(65, 90)) .. " " .. math.random(100,999))
		local localVehLockStatus = GetVehicleDoorLockStatus(veh)
		TriggerEvent("ls:newVehicle", veh, plate, localVehLockStatus)
        TriggerServerEvent("ls:addOwner", plate)
		
		if type == 'car' then
			exports['mythic_notify']:DoHudText('inform', Config.CarOutFromPolGar)
		elseif type == 'ambulance' then
				exports['mythic_notify']:DoHudText('inform', Config.CarOutFromAmbGar)

		elseif type == 'helicopter' then
			exports['mythic_notify']:DoHudText('inform', Config.HeliOutFromPolGar)

		elseif type == 'boat' then
			exports['mythic_notify']:DoHudText('inform', Config.BoatOutFromPolGar)

		end
		
		TriggerEvent("fuel:setFuel",veh,100.0)
		SetVehicleDirtLevel(veh, 0.1)		
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Load Timer Function for Vehicle Spawn:
function VehicleLoadTimer(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)

			drawLoadingText(Config.VehicleLoadText, 255, 255, 255, 255)
		end
	end
end

-- Loading Text for Vehicles Function:
function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end



-- Police Extra Menu:
function OpenExtraMenu()
	local elements = {}
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) 

			if state then
				table.insert(elements, {
					label = "Ekstra: "..id.." | "..('<span style="color:green;">%s</span>'):format("On"),
					value = id,
					state = not state
				})
			else
				table.insert(elements, {
					label = "Ekstra: "..id.." | "..('<span style="color:red;">%s</span>'):format("Off"),
					value = id,
					state = not state
				})
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = Config.TitlePoliceExtra,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleExtra(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Ekstra: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Ekstra: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)
		menu.refresh()
	end, function(data, menu)
		menu.close()
	end)
end

-- Police Livery Menu:
function OpenLiveryMenu()
	local elements = {}
	
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local liveryCount = GetVehicleLiveryCount(vehicle)
			
	for i = 1, liveryCount do
		local state = GetVehicleLivery(vehicle) 
		local text
		
		if state == i then
			text = "Livery: "..i.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			text = "Livery: "..i.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		
		table.insert(elements, {
			label = text,
			value = i,
			state = not state
		}) 
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'livery_menu', {
		title    = Config.TitlePoliceLivery,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleLivery(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Livery: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Livery: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state
		menu.update({value = data.current.value}, newData)
		menu.refresh()
		menu.close()	
	end, function(data, menu)
		menu.close()		
	end)
end

-- Police Extra Main Menu:
function OpenMainMenu()
	local elements = {
		{label = Config.LabelPrimaryCol,value = 'primary'},
		{label = Config.LabelSecondaryCol,value = 'secondary'},
		{label = Config.LabelExtra,value = 'extra'},
		{label = Config.LabelLivery,value = 'livery'}
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'color_menu', {
		title    = Config.TitlePoliceExtra,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'extra' then
			OpenExtraMenu()
		elseif data.current.value == 'livery' then
			OpenLiveryMenu()
		elseif data.current.value == 'primary' then
			OpenMainColorMenu('primary')
		elseif data.current.value == 'secondary' then
			OpenMainColorMenu('secondary')
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end)
end

-- Police Color Main Menu:
function OpenMainColorMenu(colortype)
	local elements = {}
	for k,v in pairs(Config.Colors) do
		table.insert(elements, {
			label = v.label,
			value = v.value
		})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_color_menu', {
		title    = Config.TitleColorType,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		OpenColorMenu(data.current.type, data.current.value, colortype)
	end, function(data, menu)
		menu.close()
	end)
end

-- Police Color Menu:
function OpenColorMenu(type, value, colortype)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = Config.TitleValues,
		align    = 'top-left',
		elements = GetColors(value)
	}, function(data, menu)
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local pr,sec = GetVehicleColours(vehicle)
		if colortype == 'primary' then
			SetVehicleColours(vehicle, data.current.index, sec)
		elseif colortype == 'secondary' then
			SetVehicleColours(vehicle, pr, data.current.index)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end
