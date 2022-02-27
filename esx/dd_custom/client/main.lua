ESX = nil
local Vehicles = {}
-- local PlayerData = {}
local lsMenuIsShowed = false
local isInLSMarker = false
local myCar = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	Citizen.Wait(5000)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
RegisterNetEvent('dd_custom:installMod')
AddEventHandler('dd_custom:installMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	TriggerServerEvent('dd_custom:refreshOwnedVehicle', myCar)
end)

RegisterNetEvent('dd_custom:cancelInstallMod')
AddEventHandler('dd_custom:cancelInstallMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	ESX.Game.SetVehicleProperties(vehicle, myCar)
end)

RegisterNetEvent('dd_custom:installMod2')
AddEventHandler('dd_custom:installMod2', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	TriggerServerEvent('dd_custom:refreshOwnedVehicle2', myCar)
end)

RegisterNetEvent('dd_custom:cancelInstallMod2')
AddEventHandler('dd_custom:cancelInstallMod2', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	ESX.Game.SetVehicleProperties(vehicle, myCar)
end)

function OpenLSMenu(elems, menuName, menuTitle, parent)
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
	{
		title    = menuTitle,
		align    = 'top-right',
		elements = elems
	}, function(data, menu)
		local isRimMod, found = false, false
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end
		for k,v in pairs(Config.Menus) do

			if k == data.current.modType or isRimMod then
				
				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					exports['okokNotify']:Alert("LS CUSTOM", _U('already_own', data.current.label), 3000, 'info')
					TriggerEvent('dd_custom:installMod')
					TriggerEvent('dd_custom:installMod2')
				else
					local vehiclePrice = 50000

					if isRimMod then
						price = 1 -- 30000

						TriggerServerEvent('dd_custom:buyMod', price, data.current.modtype, myCar)
					elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
						price = 2 --100000
						TriggerServerEvent('dd_custom:buyMod', price, data.current.modtype, myCar )
					elseif v.modType == 17 then
						price = 2 --100000
						TriggerServerEvent('dd_custom:buyMod', price, data.current.modtype, myCar)
					else
						price = 1 -- 30000
						TriggerServerEvent('dd_custom:buyMod', price, data.current.modtype, myCar)
					end
				end

				menu.close()
				found = true
				break
			end

		end

		if not found then
			GetAction(data.current)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('dd_custom:cancelInstallMod')
		TriggerEvent('dd_custom:cancelInstallMod2')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDoorsShut(vehicle, false)

		if parent == nil then
			lsMenuIsShowed = false
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			FreezeEntityPosition(vehicle, false)
			myCar = {}
		end
	end, function(data, menu) -- on change
		UpdateMods(data.current)
	end)
end

function UpdateMods(data)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

	if data.modType then
		local props = {}
		
		if data.wheelType then
			props['wheels'] = data.wheelType
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'neonColor' then
			if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
				props['neonEnabled'] = { false, false, false, false }
			else
				props['neonEnabled'] = { true, true, true, true }
			end
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'tyreSmokeColor' then
			props['modSmokeEnabled'] = true
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		end

		props[data.modType] = data.modNum
		ESX.Game.SetVehicleProperties(vehicle, props)
	end
end

function GetAction(data)
	local elements  = {}
	local menuName  = ''
	local menuTitle = ''
	local parent    = nil

	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local currentMods = ESX.Game.GetVehicleProperties(vehicle)


	if data.value == 'modSpeakers' or
		data.value == 'modTrunk' or
		data.value == 'modHydrolic' or
		data.value == 'modEngineBlock' or
		data.value == 'modAirFilter' or
		data.value == 'modStruts' or
		data.value == 'modTank' then
		SetVehicleDoorOpen(vehicle, 4, false)
		SetVehicleDoorOpen(vehicle, 5, false)
	elseif data.value == 'modDoorSpeaker' then
		SetVehicleDoorOpen(vehicle, 0, false)
		SetVehicleDoorOpen(vehicle, 1, false)
		SetVehicleDoorOpen(vehicle, 2, false)
		SetVehicleDoorOpen(vehicle, 3, false)
	else
		SetVehicleDoorsShut(vehicle, false)
	end

	local vehiclePrice = 50000

	for k,v in pairs(Config.Menus) do

		if data.value == k then

			menuName  = k
			menuTitle = v.label
			parent    = v.parent

			if v.modType then
				
				if v.modType == 22 then
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
					table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
					local num = myCar[v.modType]
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
				elseif v.modType == 17 then
					table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
 				else
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
				end

				if v.modType == 14 then -- HORNS
					for j = 0, 51, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = 1 -- 30000
							_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j, modtype = 'HORN TYPE '..GetHornName(j)})
					end
				elseif v.modType == 'plateIndex' then -- PLATES
					for j = 0, 4, 1 do
						local _label = ''
						if j == currentMods.plateIndex then
							_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = 1 -- 30000
							_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j, modtype = 'LICENSE PLATE '..GetPlatesName(j)})
					end
				elseif v.modType == 22 then -- NEON
					local _label = ''
					if currentMods.modXenon then
						_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						price = 1 -- 30000
						_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true, modtype = 'NEON HEADLIGHTS'})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
					local _modtype
					if v.modType == 'neonColor' then _modtype = 'UNDER GLOW' end
					if v.modType == 'tyreSmokeColor' then _modtype = 'TYRESMOKE COLOR' end
					local neons = GetNeons()
					price = 1 -- 30000
					for i=1, #neons, 1 do
						table.insert(elements, {
							label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
							modType = k,
							modNum = { neons[i].r, neons[i].g, neons[i].b},
							modtype = _modtype..' '.. neons[i].label
						})
					end
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
					local _modtype
					if v.modType == 'color1' then _modtype = 'PRIMARY COLOR' end
					if v.modType == 'color2' then _modtype = 'SECONDARY COLOR' end
					if v.modType == 'pearlescentColor' then _modtype = 'PEARLESCENT' end
					if v.modType == 'wheelColor' then _modtype = 'WHEEL COLOR' end
					local colors = GetColors(data.color)
					for j = 1, #colors, 1 do
						local _label = ''
						price = 1 -- 30000
						_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = colors[j].index, modtype = _modtype..' '..colors[j].label})
					end
				elseif v.modType == 'windowTint' then -- WINDOWS TINT
					for j = 1, 5, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = 1 -- 30000
							_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j, modtype = 'WINDOW TINT '..GetWindowName(j)})
					end
				elseif v.modType == 23 then -- WHEELS RIM & TYPE
					local props = {}

					props['wheels'] = v.wheelType
					ESX.Game.SetVehicleProperties(vehicle, props)

					local modCount = GetNumVehicleMods(vehicle, v.modType)
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods.modFrontWheels then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = 1 -- 30000
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price, modtype = 'WHEEL TYPE '..GetLabelText(modName)})
						end
					end
				elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
					local _modtype
					if v.modType == 11 then _modtype = 'ENGINE UPGRADE LEVEL:' end
					if v.modType == 12 then _modtype = 'BRAKE UPGRADE LEVEL:' end
					if v.modType == 13 then _modtype = 'TRANSMISSION UPGRADE LEVEL:' end
					if v.modType == 15 then _modtype = 'SUSPENSION UPGRADE LEVEL:' end
					if v.modType == 16 then _modtype = 'ARMOR UPGRADE LEVEL:' end
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
					for j = 0, modCount, 1 do
						local _label = ''
						if j == currentMods[k] then
							_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = 2 --100000
							_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j, modtype = _modtype..' ' ..j+1})
						if j == modCount-1 then
							break
						end
					end
				elseif v.modType == 17 then -- TURBO
					local _label = ''
					if currentMods[k] then
						_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						_label = 'Turbo - <span style="color:green;">$' .. 2 .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true, modtype = 'TURBO'})
				else
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods[k] then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = 2 --100000
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j, modtype = 'BODYPARTS '..GetLabelText(modName)})
						end
					end
				end
			else
				if data.value == 'billing' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('UPS_create_bill')
				elseif data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
					for i=1, #Config.Colors, 1 do
						if data.value == 'primaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color1', color = Config.Colors[i].value})
						elseif data.value == 'secondaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color2', color = Config.Colors[i].value})
						elseif data.value == 'pearlescentRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'pearlescentColor', color = Config.Colors[i].value})
						elseif data.value == 'modFrontWheelsColor' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'wheelColor', color = Config.Colors[i].value})
						end
					end
				else
					for l,w in pairs(v) do
						if l ~= 'label' and l ~= 'parent' then
							table.insert(elements, {label = w, value = l})
						end
					end
				end
			end
			break
		end
	end

	table.sort(elements, function(a, b)
		return a.label < b.label
	end)

	OpenLSMenu(elements, menuName, menuTitle, parent)
end

Citizen.CreateThread(function()
	while true do
		sleep = 5000
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			sleep = 0
			local coords = GetEntityCoords(PlayerPedId())
			local currentZone, zone, lastZone

			if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic') then 
				for k,v in pairs(Config.Zones) do
					if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x and not lsMenuIsShowed then
						isInLSMarker  = true
						ESX.ShowHelpNotification(v.Hint)
						break
					else
						isInLSMarker  = false
					end
				end
			end
			-- for k,v in pairs(Config.Zones) do
				if IsControlJustReleased(0, 38) and not lsMenuIsShowed and isInLSMarker then
					if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic') then 
						lsMenuIsShowed = true
						
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						FreezeEntityPosition(vehicle, true)

						myCar = ESX.Game.GetVehicleProperties(vehicle)

						ESX.UI.Menu.CloseAll()
						local data = {value = 'main'}
						GetAction(data)
					end
				end		
			-- end
			if isInLSMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
			end

			if not isInLSMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
			end

		end
		Citizen.Wait(sleep)
	end
end)

-- Prevent Free Tunning Bug
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if lsMenuIsShowed then
			DisableControlAction(2, 288, true)
			DisableControlAction(2, 289, true)
			DisableControlAction(2, 170, true)
			DisableControlAction(2, 165, true)
			DisableControlAction(2, 168, true)
			DisableControlAction(2, 23, true)
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			
			DisableControlAction(0, 71,  true) -- Disable exit vehicle
			DisableControlAction(0, 72,  true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent('UPS_create_bill')
AddEventHandler('UPS_create_bill', function(xTarget)
	local dialog = exports['zf_dialog']:DialogInput({
	header = 'Upgrades Invoice',
		rows = {
		{
			id = 0,
			txt = 'Enter amount'
		},
		}
	})

	if dialog ~= nil then
		if dialog[1].input == nil then
			exports['okokNotify']:Alert("MECH", "Invalid input", 3000, 'info')
		else
			amount = tonumber(dialog[1].input)
			TriggerServerEvent('dd_custom:GetPlateOwner', myCar,amount)
		end      
	end
end)