
local blipsMech, currentTask = {}, {}
local isDead, isBusy = false, false
local CurrentAction, CurrentAction2
local isReparing 		= false
local IsMecanoOnline 	= false
local CurrentlyTowedVehicle   = nil
show 				= false
ESX = nil
local ct = Citizen.CreateThread
ct(function()
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
	Citizen.Wait(2000)
	TriggerServerEvent('dd_mech:forceBlip')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Mechanic',
		number     = 'mechanic',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}
	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

RegisterNetEvent('dd_mech:Overhaul')
AddEventHandler('dd_mech:Overhaul', function()
	local id = '1'
	OpenOhMenu(id)
end)
function OpenOhMenu(id)
	local playerPed = PlayerPedId()
	local vehicle   = nil
	local coords    = GetEntityCoords(playerPed)

	local isopen =  GetVehicleDoorAngleRatio(vehicle,1) and GetVehicleDoorAngleRatio(vehicle,4) and GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3) and GetVehicleDoorAngleRatio(vehicle,5)
	
	if IsPedInAnyVehicle(playerPed, false) then
		exports['okokNotify']:Alert("MECH", "Task not available inside vehicle", 3000, 'info')
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		

		ct(function()
			if (isopen == 0) then
				-- SetEntityHeading(playerPed, 96.37)
				FreezeEntityPosition(playerPed, true)
				SetVehicleDoorOpen(vehicle,4,0,0)
				while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
					RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
					Citizen.Wait(5)
				end
				TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 49, 0, 0, 0, 0)

				local finished = exports["taskbar"]:taskBar(20000,"Overhauling vehicle")
				if (finished == 100) then
					SetVehicleDoorOpen(vehicle,3,0,0)
					SetVehicleDoorOpen(vehicle,2,0,0)
					SetVehicleDoorOpen(vehicle,1,0,0)
					SetVehicleDoorOpen(vehicle,5,0,0)
				end
				while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
					RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
					Citizen.Wait(5)
				end
				TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 49, 0, 0, 0, 0)

				local finished = exports["taskbar"]:taskBar(10000,"Fixing engine support")
				if (finished == 100) then
					SetVehicleDoorShut(vehicle,4,0,0)
					SetVehicleDoorShut(vehicle,3,0,0)
					SetVehicleDoorShut(vehicle,2,0,0)
					SetVehicleDoorShut(vehicle,1,0,0)
					SetVehicleDoorShut(vehicle,5,0,0)
					FreezeEntityPosition(playerPed, false)
				end
				
				Citizen.Wait(3000)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleFixed(vehicle)

				SetVehicleEngineHealth(vehicle, 1000.0)
				SetVehicleBodyHealth(vehicle, 1000.0)
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle, false, true)
				ClearPedTasks(playerPed)
				if id == '2' then
					TriggerServerEvent('dd_mech:removeItem', 'fixkit')
				end
			
				isBusy = false
			end
		end)
	end
end
RegisterNetEvent('dd_mech:repairkit')
AddEventHandler('dd_mech:repairkit', function()
	local playerPed = PlayerPedId()
	local vehicle   = nil
	local coords    = GetEntityCoords(playerPed)

	local isopen =  GetVehicleDoorAngleRatio(vehicle,1) and GetVehicleDoorAngleRatio(vehicle,4) and GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3) and GetVehicleDoorAngleRatio(vehicle,5)
	
	if IsPedInAnyVehicle(playerPed, false) then
		exports['okokNotify']:Alert("MECH", "Task not available inside vehicle", 3000, 'info')
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		

		ct(function()
			if (isopen == 0) then
				SetEntityHeading(playerPed, 96.37)
				FreezeEntityPosition(playerPed, true)
				SetVehicleDoorOpen(vehicle,4,0,0)
				while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
					RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
					Citizen.Wait(5)
				end
				TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 49, 0, 0, 0, 0)

				local finished = exports["taskbar"]:taskBar(5000,"Repairing engine")
				if (finished == 100) then
					SetVehicleDoorOpen(vehicle,3,0,0)
					SetVehicleDoorOpen(vehicle,2,0,0)
					SetVehicleDoorOpen(vehicle,1,0,0)
					SetVehicleDoorOpen(vehicle,5,0,0)
				end
				while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
					RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
					Citizen.Wait(5)
				end
				TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 49, 0, 0, 0, 0)

				local finished = exports["taskbar"]:taskBar(3000,"Fixing engine support")
				if (finished == 100) then
					SetVehicleDoorShut(vehicle,4,0,0)
					SetVehicleDoorShut(vehicle,3,0,0)
					SetVehicleDoorShut(vehicle,2,0,0)
					SetVehicleDoorShut(vehicle,1,0,0)
					SetVehicleDoorShut(vehicle,5,0,0)
					FreezeEntityPosition(playerPed, false)
				end
				
				Citizen.Wait(3000)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleFixed(vehicle)

				SetVehicleEngineHealth(vehicle, 500.0)
				-- SetVehicleBodyHealth(vehicle, 500.0)
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle, false, true)
				ClearPedTasks(playerPed)
				TriggerServerEvent('dd_mech:removeItem', 'repairkit')
				isBusy = false
			end
		end)
	end
end)
RegisterNetEvent('impounding:task')
AddEventHandler('impounding:task', function()
	exports['okokNotify']:Alert("MECH", "Impounding has been cancelled", 3000, 'info')
	ESX.ClearTimeout(currentTask.task)
	ClearPedTasks(PlayerPedId())
	exports['dd_utils']:HideXn()
	currentTask.busy = false
	TriggerEvent('impound:task', false)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)
-----------//JOB BLIPS//-----------------
-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then 
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) 
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) 
		SetBlipNameToPlayerName(blip, id) 
		SetBlipScale(blip, 0.85) 
		SetBlipAsShortRange(blip, true)

		table.insert(blipsMech, blip)
	end
end

RegisterNetEvent('dd_mech:updateBlip')
AddEventHandler('dd_mech:updateBlip', function()

	for k, existingBlip in pairs(blipsMech) do
		RemoveBlip(existingBlip)
	end

	blipsMech = {}

	if not Config.EnableJobBlip then
		return
	end

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'mechanic' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

end)

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

function GetClosestVehicleTire(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {["wheel_lf"] = 0, ["wheel_rf"] = 1, ["wheel_lm1"] = 2, ["wheel_rm1"] = 3, ["wheel_lm2"] = 45,["wheel_rm2"] = 47, ["wheel_lm3"] = 46, ["wheel_rm3"] = 48, ["wheel_lr"] = 4, ["wheel_rr"] = 5,}
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.0
	local closestTire = nil
	
	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end

RegisterCommand('killallmenu', function(source, args)
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('dd_mech:getVeh')
AddEventHandler('dd_mech:getVeh', function()
	OpenmechanicActionsMenu()
end)
function OpenmechanicActionsMenu()
	local elements = {
	{label = 'Flatbed', value = 'flatbed'},
	{label = 'Tool Truck', value = 'tooltruck'},
	
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'spawn_vehicle',
	{
		title    = 'Service Vehicle',
		align    = 'right',
		elements = elements
	},
	function(data, menu)
		for i=1, #elements, 1 do
			ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
			local playerPed = GetPlayerPed(-1)

			local vehNet = NetworkGetNetworkIdFromEntity(vehicle)
			local plate = GetVehicleNumberPlateText(vehicle) 
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
			break
		end
		menu.close()
	end,
	function(data, menu)
		menu.close()
		OpenmechanicActionsMenu()
	end)
end

RegisterNetEvent('dd_mech:ToggleAction')
AddEventHandler('dd_mech:ToggleAction', function()
	OpenMobileMenu()
end)

RegisterNetEvent('dd_mech:fixTyre')
AddEventHandler('dd_mech:fixTyre', function()
	local playerPed		= PlayerPedId()
	local coords		= GetEntityCoords(playerPed)
	local closestTire 	= GetClosestVehicleTire(vehicle)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil
	end	

	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	end

	if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) and IsPedOnFoot(playerPed) and closestTire ~= nil and IsMecanoOnline == false 
	then
		TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		
		ct(function()
			ThreadID2 = GetIdOfThisThread()
			CurrentAction2 = 'repair'
			isReparing = not isReparing
			SetTextComponentFormat('STRING')

			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			local finished = exports["taskbar"]:taskBar(Config.TyreKitTime * 1000,"Repairing tyre")
			if (finished == 100) then	
			-- Citizen.Wait(Config.TyreKitTime * 1000)

				if CurrentAction2 ~= nil then
					SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
					SetVehicleWheelHealth(vehicle, closestTire.tireIndex, 100)
					ClearPedTasks(playerPed)
					TriggerServerEvent('dd_mech:removeItem', 'tyrekit')
					Citizen.Wait(1000)
					exports['okokNotify']:Alert("", "Successfully repair tyre", 3000, 'info')
					if isReparing == true then
						isReparing = not isReparing
					end			
				end
			end
		end)
	end
end)

function ImpoundVehicle(vehicle)
	ESX.Game.DeleteVehicle(vehicle)
	exports['okokNotify']:Alert("MECH", "Successcully impound vehicle", 3000, 'info')
	exports['dd_utils']:HideXn()
	currentTask.busy = false
	TriggerEvent('impound:task', false)
end

function OpenMobileMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_mechanic_actions',
		{
      title    = 'Mechanic Menu',
      align    = 'right',
      elements = {    
		{label = 'Repair Vehicle',       	value = 'fix_vehicle'},
        {label = 'Hijack Vehicle',     		value = 'hijack_vehicle'},
		{label = 'Tow Vehicle',       		value = 'tow_vehicle'},
		{label = 'flatbed Vehicle',       	value = 'flatbed_vehicle'},      
        {label = 'Clean Vehicle',      		value = 'clean_vehicle'},
        {label = 'Impound Vehicle',     	value = 'del_vehicle'},
		{label = 'Billing', 				value = 'billing'},
      }
    },
    function(data, menu)
		if data.current.value == 'billing' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then

			else
				local dialog = exports['zf_dialog']:DialogInput({
				header = 'MECH Billing',
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
						amount = dialog[1].input
						TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', 'Mechanic Billing', amount)  
					end      
				end
			end
		end
		if data.current.value == 'hijack_vehicle' then
			local playerPed = GetPlayerPed(-1)
			local coords    = GetEntityCoords(playerPed)
			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
				local vehicle = nil
				if IsPedInAnyVehicle(playerPed, false) then
					-- vehicle = GetVehiclePedIsIn(playerPed, false)
					exports['okokNotify']:Alert("MECH", "Task not available inside vehicle", 3000, 'info')
				else
					vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				end
				if DoesEntityExist(vehicle) then
					while (not HasAnimDictLoaded("mp_arresting")) do
						RequestAnimDict("amp_arresting")
						Citizen.Wait(5)
					end
					TaskPlayAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
					local count = 4
					local speed = 0.6
					exports["mf-inventory"]:startMinigame(count,speed,function(res)
						print("Minigame complete",res)
						SetVehicleDoorsLocked(vehicle, 1)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
						ClearPedTasks(playerPed)
					end)
				end
			end
		end
		if data.current.value == 'fix_vehicle' then
			ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
				if quantity > 0 then
					local id = '2'
					OpenOhMenu(id)
				else
					exports['okokNotify']:Alert("MECH", "Not enough overhauling kit", 3000, 'info')
				end
			end, 'fixkit')
		end
		if data.current.value == 'clean_vehicle' then
			local playerPed = GetPlayerPed(-1)
			local coords    = GetEntityCoords(playerPed)
			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
				local vehicle = nil
				if IsPedInAnyVehicle(playerPed, false) then
					-- vehicle = GetVehiclePedIsIn(playerPed, false)
					exports['okokNotify']:Alert("MECH", "Task not available inside vehicle", 3000, 'info')
				else
					vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				end
				if DoesEntityExist(vehicle) then
					TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
					Citizen.CreateThread(function()
						local finished = exports["taskbar"]:taskBar(10000,"Cleaning vehicle")
						if (finished == 100) then
							SetVehicleDirtLevel(vehicle, 0)
							ClearPedTasks(playerPed)
						end
					end)
				end
			end
		end
		if data.current.value == 'del_vehicle' then
			if not IsPedInAnyVehicle(PlayerPedId(), false) then
				local id = '1'
				TriggerEvent('dropoff:vehshop', id)
			end
		end
		if data.current.value == 'tow_vehicle' then
			TriggerEvent('kuz_towing:openTowingMenu')
		end
		if data.current.value == 'flatbed_vehicle' then
			
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, true)
		
			local towmodel = GetHashKey('flatbed')
			local isVehicleTow = IsVehicleModel(vehicle, towmodel)
		
			if isVehicleTow then
				local targetVehicle = ESX.Game.GetVehicleInDirection()
		
				if CurrentlyTowedVehicle == nil then
					if targetVehicle ~= 0 then
						if not IsPedInAnyVehicle(playerPed, true) then
							if vehicle ~= targetVehicle then
								AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
								CurrentlyTowedVehicle = targetVehicle
								exports['okokNotify']:Alert("MECH", "Successfully attached vehicle", 3000, 'info')
							else
								exports['okokNotify']:Alert("MECH", "You cannot attached your own vehicle", 3000, 'info')
							end
						end
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle, true, true)
					CurrentlyTowedVehicle = nil
					exports['okokNotify']:Alert("MECH", "Successfully detached vehicle", 3000, 'info')
				end		
			else
				exports['okokNotify']:Alert("MECH", "Action impossible! You need a Flatbed to load a vehicle", 3000, 'info')
			end
		end
    end,
	function(data, menu)
		menu.close()
	end)
end
