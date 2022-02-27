--------------------------------
------- Created by Hamza -------
-------------------------------- 

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	ESX.UI.Menu.CloseAll()
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

-- // Function for 3D text // --
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

local time = 0
local menuData = {open = false, id = nil}

-- // CORE THREAD // --
Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
		if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police') then
			for k,v in pairs(Config.PoliceGarage) do
				local ped = GetPlayerPed(-1)
				local pos = GetEntityCoords(ped)
				local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[1], v[2], v[3],false)
				if distance <= 20.0 then
					DrawMarker(Config.PoliceGarageMarker, v[1], v[2], v[3]-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 1.5, 1.5, 1.5, Config.PoliceGarageMarkerColor.r,Config.PoliceGarageMarkerColor.g,Config.PoliceGarageMarkerColor.b,Config.PoliceGarageMarkerColor.a, false, true, 2, true, false, false, false)						
					if distance <= 3 then
						DrawText3Ds(v[1], v[2], pos.z, "~y~Polis Garajına~s~ erismek ~g~[E]~s~ tusuna bas.")
						if IsControlJustPressed(0, 38) then
							PoliceGarage()
						end
					end
				end
			end
			for k,v in pairs(Config.ExtraPositions) do 
				local ped = GetPlayerPed(-1)
				local pos = GetEntityCoords(ped)
				if IsPedInAnyVehicle(ped, true) then
					local veh = GetVehiclePedIsIn(ped, false)
					local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[1], v[2], v[3], true)
					if distance <= 20.0 then
						DrawMarker(Config.PoliceGarageMarker, v[1], v[2], v[3]-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 2.5, 2.5, 1.5, Config.PoliceGarageMarkerColor.r,Config.PoliceGarageMarkerColor.g,Config.PoliceGarageMarkerColor.b,Config.PoliceGarageMarkerColor.a, false, true, 2, true, false, false, false)
						if distance <= 3 then
							if not menuData.open then
								DrawText3Ds(v[1], v[2], pos.z, "~y~Polis Ekstra Menüsüne~s~ erismek için ~g~[E]~s~ tusuna bas.")
								if IsControlJustPressed(1, 46) then
									if GetVehicleClass(veh) == 18 then
										if time == 0 then
											time = 2
											OpenMainMenu()
											menuData.id = tonumber(k)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(5)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if menuData.open == true and menuData.id ~= nil then
			local ped = GetPlayerPed(-1)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.ExtraPositions[menuData.id][1], Config.ExtraPositions[menuData.id][2], Config.ExtraPositions[menuData.id][3], true) > 7 then
				ESX.UI.Menu.CloseAll()
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		 Citizen.Wait(1000)
		 if time > 0 then
			  time = time - 1
		 end
	end
end)

-- Garage Menu
PoliceGarage = function()
	local elements = {
		{ label = "Aracı Depoya Koy", action = "store_vehicle" },
		{ label = "Araç Al", action = "get_vehicle" },
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_policeGarage_menu",
		{
			title    = "Polis Garajı",
			align    = "center",
			elements = elements
		},
	function(data, menu)
		local action = data.current.action
		if action == "get_vehicle" then
			VehicleMenu()	
		elseif data.current.action == 'store_vehicle' then
			local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)
			if dist < 3 then
				DeleteEntity(veh)
				exports['mythic_notify']:SendAlert('inform', 'Araç park edildi.')
			else
				exports['mythic_notify']:SendAlert('inform', 'Yakında araç yok.')
			end
		end
	end, function(data, menu)
		menu.close()
	end, function(data, menu)
	end)
end

-- Vehicle Spawn Menu
VehicleMenu = function()
	local storage = nil
	local elements = {}
	local ped = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(ped)
		
	for k,v in pairs(Config.PoliceVehicles) do
		table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_policeGarage_vehicle_garage",
		{
			title    = "Araç Garajı",
			align    = "center",
			elements = elements
		},
	function(data, menu)
		menu.close()
		local plate = exports['esx_vehicleshop']:GeneratePlate()
		VehicleLoadTimer(data.current.model)
		local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,GetEntityHeading(playerPed),true,false)
		SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		SetVehicleNumberPlateText(veh,plate)
		exports['mythic_notify']:SendAlert('inform', 'Polis garajından araç çıkarttın.')
		TriggerEvent("fuel:setFuel",veh,100.0)
		SetVehicleDirtLevel(veh, 0.1)		
	end, function(data, menu)
		menu.close()
	end, function(data, menu)
	end)
end

-- Load Timer Function for Vehicle Spawn
function VehicleLoadTimer(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)

			drawLoadingText("Aracın spawnlanması bekleniyor...", 255, 255, 255, 255)
		end
	end
end

-- Loading Text for Vehicles
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

-- // FIX POLICE VEHICLE \\ ---

RegisterCommand('tamiret', function(source, args)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police') then
		policeFix()
	end
end,false)

function policeFix()
	local ped = GetPlayerPed(-1)
	for k,v in pairs(Config.PoliceGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				exports['mythic_notify']:SendAlert('inform', 'Aracın tamir ediliyor, lütfen bekle.')
				FreezeEntityPosition(veh, true)
				exports['progressBars']:startUI(5000, "Araç tamir ediliyor...")
				Citizen.Wait(5000)
				exports['mythic_notify']:SendAlert('inform', 'Aracın tamir edildi.')
				SetVehicleFixed(veh)
				FreezeEntityPosition(veh, false)
			end
		end
	end
end

-- // CLEAN POLICE VEHICLE \\ ---

RegisterCommand('temizle', function(source, args)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police') then
		policeClean()
	end
end,false)

function policeClean()
	local ped = GetPlayerPed(-1)
	for k,v in pairs(Config.PoliceGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				exports['mythic_notify']:SendAlert('inform', 'Aracın temizleniyor, lütfen bekle.')
				FreezeEntityPosition(veh, true)
				exports['progressBars']:startUI(3500, "Araç temizleniyor....")
				Citizen.Wait(3500)
				exports['mythic_notify']:SendAlert('inform', 'Aracın temizlendi.')
				SetVehicleDirtLevel(veh, 0.1)
				FreezeEntityPosition(veh, false)
			end
		end
	end
end

-- // POLICE EXTRA VEHICLE MENU \\ ---

function OpenExtraMenu()
	local elements = {}
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) 

			if state then
				table.insert(elements, {
					label = "Ekstra: "..id.." "..('<span style="color:green;">%s</span>'):format("On"),
					value = id,
					state = not state
				})
			else
				table.insert(elements, {
					label = "Ekstra: "..id.." "..('<span style="color:red;">%s</span>'):format("Off"),
					value = id,
					state = not state
				})
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = "Ekstra",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleExtra(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Ekstra: "..data.current.value.." "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Ekstra: "..data.current.value.." "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)
		menu.refresh()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMainMenu()
	menuData.open = true
	local elements = {
		{label = "Birincil",value = 'primary'},
		{label = "İkincil",value = 'secondary'},
		{label = "Ekstra",value = 'extra'}
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'color_menu', {
		title    = "Ana Menü",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value ~= 'extra' then
			OpenMainColorMenu(data.current.value)
		else
			OpenExtraMenu()
		end
	end, function(data, menu)
		menu.close()
		menuData.open = false
		menuData.id = nil
	end)
end

function OpenMainColorMenu(colortype)
	local elements = {}
	for k,v in pairs(Config.Colors) do
		table.insert(elements, {
			label = v.label,
			value = v.value
		})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_color_menu', {
		title    = "Renk Tipi",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		OpenColorMenu(data.current.type, data.current.value, colortype)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenColorMenu(type, value, colortype)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = "Değer",
		align    = 'top-left',
		elements = GetColors(value)
	}, function(data, menu)
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
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
