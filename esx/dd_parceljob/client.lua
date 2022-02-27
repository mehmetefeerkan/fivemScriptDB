ESX = nil
local isondelivery = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(DD.Blips) do
		local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
		SetBlipSprite(blip, v.sprite)
		SetBlipScale(blip, v.scale)
		SetBlipColour(blip, v.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(v.label)
		EndTextCommandSetBlipName(blip)
	end
  end)

RegisterNetEvent('dd_jobs:Aportjob')
AddEventHandler('dd_jobs:Aportjob', function()
	only_roadwork_menu_open()
end)
function only_roadwork_menu_open()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'onlyalex_roadwork_menu',
		{
			title    = "Jobmenu",
			align    = 'right',
			elements = {
				{ label = "Clothing", value = "menu_clothing" },
				{ label = "Deliver", value = "menu_vehicles" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "menu_clothing" then
			only_roadwork_menu_clothing_open()
			menu.close()
		end

		if action == "menu_vehicles" then
			Citizen.CreateThread(function()
				for k, v in pairs(DD.SpawnVehicle) do
					ESX.Game.SpawnVehicle("suntrap", vector3(v.coords.x, v.coords.y, v.coords.z), v.coords.h, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					-- exports["onyxLocksystem"]:givePlayerKeys(plate)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
					end)
				end
			end)
			local rndm = math.random(1,3)
			startDeliveryMission(rndm)
			TriggerEvent('portjob:delactive', true)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)	
end

function only_roadwork_menu_clothing_open()
	TriggerEvent('skinchanger:change', "torso_1", 26)
	TriggerEvent('skinchanger:change', "torso_2", 0)
	TriggerEvent('skinchanger:change', "tshirt_1", 15)
	TriggerEvent('skinchanger:change', "tshirt_2", 0)
	TriggerEvent('skinchanger:change', "pants_1", 9)
	TriggerEvent('skinchanger:change', "pants_2", 3)
	TriggerEvent('skinchanger:change', "shoes_1", 24)
	TriggerEvent('skinchanger:change', "shoes_2", 0)
	TriggerEvent('skinchanger:change', "arms", 26)
end
RegisterNetEvent('dd_jobs:Bportjob')
AddEventHandler('dd_jobs:Bportjob', function()
	RemoveBlip(deleteblip)
	local playerPed = PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		if isondelivery == true then
			isondelivery = false
			RemoveBlip(deliveryblip)
		end
		DeleteVehicle(ESX.Game.GetClosestVehicle(coords))
		SetEntityCoords(playerPed, 24.21, -2771.6, 5.7)
		TriggerEvent('portjob:delactive', false)
	end
end)

startDeliveryMission = function(rndm)
	local coords = GetEntityCoords(GetPlayerPed(-1))
	if rndm == 1 then 
		isondelivery = true  
		deliveryblip = AddBlipForCoord(572.26, -3130.58, 7.91)
  		SetBlipSprite(deliveryblip, 568)
 		SetBlipDisplay(deliveryblip, 4)
  		SetBlipScale(deliveryblip, 1.0)
  		SetBlipColour(deliveryblip, 5)
  		SetBlipAsShortRange(deliveryblip, true)
 		BeginTextCommandSetBlipName("STRING")
 		AddTextComponentString("Delivery")
		 EndTextCommandSetBlipName(deliveryblip)
		 Citizen.CreateThread(function()
			if isondelivery == true then
				TriggerEvent('portjob:area', rndm)
		    end
		end)
	end
	if rndm == 2 then 
		isondelivery = true  
		deliveryblip = AddBlipForCoord(-357.52, -2414.85, 2.53)
  		SetBlipSprite(deliveryblip, 568)
 		SetBlipDisplay(deliveryblip, 4)
  		SetBlipScale(deliveryblip, 1.0)
  		SetBlipColour(deliveryblip, 5)
  		SetBlipAsShortRange(deliveryblip, true)
 		BeginTextCommandSetBlipName("STRING")
 		AddTextComponentString("Delivery")
		 EndTextCommandSetBlipName(deliveryblip)
		 Citizen.CreateThread(function()
			if isondelivery == true then
				TriggerEvent('portjob:area', rndm)
		    end
		end)
	end
	if rndm == 3 then 
		isondelivery = true  
		deliveryblip = AddBlipForCoord(102.12, -2450.64, 0.38)
  		SetBlipSprite(deliveryblip, 568)
 		SetBlipDisplay(deliveryblip, 4)
  		SetBlipScale(deliveryblip, 1.0)
  		SetBlipColour(deliveryblip, 5)
  		SetBlipAsShortRange(deliveryblip, true)
 		BeginTextCommandSetBlipName("STRING")
 		AddTextComponentString("Delivery")
		 EndTextCommandSetBlipName(deliveryblip)
		 Citizen.CreateThread(function()
			if isondelivery == true then
				TriggerEvent('portjob:area', rndm)
		    end
		end)
	end
end
RegisterNetEvent('dd_jobs:portjob.1')
AddEventHandler('dd_jobs:portjob.1', function()
	local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
	if finished == 100 then
		local box0 = CreateObject(GetHashKey('hei_prop_heist_box'),575.43, -3127.28, 6.07-0.99, true, true, true)
		SetEntityRotation(box0,90.0, 0.0, 45.0, 1,true)
		local finished1 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished1 == 100 then
			local box1 = CreateObject(GetHashKey('hei_prop_heist_box'),574.47, -3127.64, 6.07-0.99, true, true, true)
			SetEntityRotation(box1,90.0, 0.0, 45.0, 1,true)
			local finished2 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
			if finished2 == 100 then
				local hashKey = 's_m_y_airworker'
				RequestModel(hashKey)
				while not HasModelLoaded(hashKey) do
					RequestModel(hashKey)
					Citizen.Wait(100)
				end
				local Porter = CreatePed(4, hashKey, 579.9, -3125.70, 6.07-1.0, 6.07 - 1.0, 101.47, true, false)
				local box2 = CreateObject(GetHashKey('hei_prop_heist_box'),575.49, -3128.47, 6.07-0.99, true, true, true)
				SetEntityRotation(box2,90.0, 0.0, 45.0, 1,true)
			
				goToLocation(Porter, 575.69, -3126.59, 6.07, 0.1, 5000, 191.1, 1.0)
				exports['okokNotify']:Alert("PORT", "Please wait while Porter is checking parcels", 5000, 'info')
				local rndmqlty = math.random(2, 3)
				local rndmtip = math.random(0, 1)
				while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
					RequestAnimDict("amb@medic@standing@kneel@base")
					Citizen.Wait(5)
				end
				TaskPlayAnim(Porter, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
				Citizen.Wait(5)
				while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
					RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
					Citizen.Wait(5)
				end
				TaskPlayAnim(Porter, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
				Citizen.Wait(5000)
				ClearPedTasks(Porter)
				DeleteEntity(box0)
				DeleteEntity(box1)
				DeleteEntity(box2)
				exports['okokNotify']:Alert("PORT", 'Parcels are goods. Delivery fee: '..rndmqlty..' and Tip: '..rndmtip, 5000, 'info')
				TriggerServerEvent('dd_jobs:GetPaid', rndmqlty, rndmtip)
				local nextArea = math.random(0, 3)
				if nextArea == 0 then
					isondelivery = false
					activateDelBlip()
					RemoveBlip(deliveryblip)
					TriggerEvent('portjob:area', nextArea)
					exports['okokNotify']:Alert("PORT", 'Task done, return your boat delivery to Port', 5000, 'info')
				else
					RemoveBlip(deliveryblip)
					TriggerEvent('portjob:area', nextArea)
					startDeliveryMission(nextArea)
					exports['okokNotify']:Alert("PORT", 'Go to your next destination', 5000, 'info')
				end

				local x,y,z = table.unpack(GetEntityCoords(Porter))
				local box3 = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
				AttachEntityToEntity(box3, Porter, GetPedBoneIndex(Porter, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
				LoadDict('anim@heists@box_carry@')

				if not IsEntityPlayingAnim(Porter, "anim@heists@box_carry@", "idle", 3 ) then
					TaskPlayAnim(Porter, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				end
				goToLocation(Porter, 581.74, -3114.86, 6.07, 0.1, 10000, 325.36, 1.0)
				DeleteEntity(box3)
				DeletePed(Porter)
			end
		end
	end
end)
RegisterNetEvent('dd_jobs:portjob.2')
AddEventHandler('dd_jobs:portjob.2', function()
	local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
	if finished == 100 then
		local box0 = CreateObject(GetHashKey('hei_prop_heist_box'),-351.05, -2421.25, 2.65-0.99, true, true, true)
		SetEntityRotation(box0,90.0, 0.0, 45.0, 1,true)
		local finished1 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished1 == 100 then
			local box1 = CreateObject(GetHashKey('hei_prop_heist_box'),-350.27, -2420.61, 2.65-0.99, true, true, true)
			SetEntityRotation(box1,90.0, 0.0, 45.0, 1,true)
			local finished2 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
			if finished2 == 100 then
				local hashKey = 's_m_y_airworker'
				RequestModel(hashKey)
				while not HasModelLoaded(hashKey) do
					RequestModel(hashKey)
					Citizen.Wait(100)
				end
				local Porter = CreatePed(4, hashKey, -355.18, -2435.68, 2.65-1.0, 6.07 - 1.0, 343.1, true, false)
				local box2 = CreateObject(GetHashKey('hei_prop_heist_box'),-352.03, -2421.31, 2.65-0.99, true, true, true)
				SetEntityRotation(box2,90.0, 0.0, 45.0, 1,true)
			
				goToLocation(Porter, -350.46, -2421.72, 2.65, 0.1, 5000, 48.32, 1.0)
				exports['okokNotify']:Alert("PORT", 'Please wait while Porter is checking parcels', 5000, 'info')
				local rndmqlty = math.random(2, 3)
				local rndmtip = math.random(0, 1)
				while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
					RequestAnimDict("amb@medic@standing@kneel@base")
					Citizen.Wait(5)
				end
				TaskPlayAnim(Porter, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
				Citizen.Wait(5)
				while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
					RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
					Citizen.Wait(5)
				end
				TaskPlayAnim(Porter, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
				Citizen.Wait(5000)
				ClearPedTasks(Porter)
				DeleteEntity(box0)
				DeleteEntity(box1)
				DeleteEntity(box2)
				exports['okokNotify']:Alert("PORT", 'Parcels are goods. Delivery fee: '..rndmqlty..' and Tip: '..rndmtip, 5000, 'info')
				TriggerServerEvent('dd_jobs:GetPaid', rndmqlty, rndmtip)
				local nextArea = math.random(0, 3)
				if nextArea == 0 then
					isondelivery = false
					activateDelBlip()
					RemoveBlip(deliveryblip)
					TriggerEvent('portjob:area', nextArea)
					exports['okokNotify']:Alert("PORT", 'Task done, return your boat delivery to Port', 5000, 'info')
				else
					RemoveBlip(deliveryblip)
					TriggerEvent('portjob:area', nextArea)
					startDeliveryMission(nextArea)
					exports['okokNotify']:Alert("PORT", 'Go to your next destination', 5000, 'info')
				end

				local x,y,z = table.unpack(GetEntityCoords(Porter))
				local box3 = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
				AttachEntityToEntity(box3, Porter, GetPedBoneIndex(Porter, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
				LoadDict('anim@heists@box_carry@')

				if not IsEntityPlayingAnim(Porter, "anim@heists@box_carry@", "idle", 3 ) then
					TaskPlayAnim(Porter, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				end
				goToLocation(Porter, -355.18, -2435.68, 2.65, 0.1, 10000, 163.92, 1.0)
				DeleteEntity(box3)
				DeletePed(Porter)
			end
		end
	end
end)
RegisterNetEvent('dd_jobs:portjob.3')
AddEventHandler('dd_jobs:portjob.3', function()
	local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
	if finished == 100 then
		local box0 = CreateObject(GetHashKey('hei_prop_heist_box'),104.99, -2446.81, 2.65-0.99, true, true, true)
		SetEntityRotation(box0,90.0, 0.0, 45.0, 1,true)
		local finished1 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished1 == 100 then
			local box1 = CreateObject(GetHashKey('hei_prop_heist_box'),106.29, -2447.02, 2.65-0.99, true, true, true)
			SetEntityRotation(box1,90.0, 0.0, 45.0, 1,true)
			local finished2 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
			if finished2 == 100 then
				local hashKey = 's_m_y_airworker'
				RequestModel(hashKey)
				while not HasModelLoaded(hashKey) do
					RequestModel(hashKey)
					Citizen.Wait(100)
				end
				local Porter = CreatePed(4, hashKey, 118.31, -2448.86, 2.65-1.0, 6.07 - 1.0, 91.49, true, false)
				local box2 = CreateObject(GetHashKey('hei_prop_heist_box'),105.89, -2447.96, 2.65-0.99, true, true, true)
				SetEntityRotation(box2,90.0, 0.0, 45.0, 1,true)
			
				goToLocation(Porter, 105.37, -2445.99, 2.65, 0.1, 5000, 142.14, 1.0)
				exports['okokNotify']:Alert("PORT", 'Please wait while Porter is checking parcels', 5000, 'info')
				local rndmqlty = math.random(2, 3)
				local rndmtip = math.random(0, 1)
				while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
					RequestAnimDict("amb@medic@standing@kneel@base")
					Citizen.Wait(5)
				end
				TaskPlayAnim(Porter, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
				Citizen.Wait(5)
				while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
					RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
					Citizen.Wait(5)
				end
				TaskPlayAnim(Porter, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
				Citizen.Wait(5000)
				ClearPedTasks(Porter)
				DeleteEntity(box0)
				DeleteEntity(box1)
				DeleteEntity(box2)
				exports['okokNotify']:Alert("PORT", 'Parcels are goods. Delivery fee: '..rndmqlty..' and Tip: '..rndmtip, 5000, 'info')
				TriggerServerEvent('dd_jobs:GetPaid', rndmqlty, rndmtip)
				local nextArea = math.random(0, 3)
				if nextArea == 0 then
					isondelivery = false
					activateDelBlip()
					RemoveBlip(deliveryblip)
					TriggerEvent('portjob:area', nextArea)
					exports['okokNotify']:Alert("PORT", 'Task done, return your boat delivery to Port', 5000, 'info')
				else
					RemoveBlip(deliveryblip)
					TriggerEvent('portjob:area', nextArea)
					startDeliveryMission(nextArea)
					exports['okokNotify']:Alert("PORT", 'Go to your next destination', 5000, 'info')
				end

				local x,y,z = table.unpack(GetEntityCoords(Porter))
				local box3 = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
				AttachEntityToEntity(box3, Porter, GetPedBoneIndex(Porter, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
				LoadDict('anim@heists@box_carry@')

				if not IsEntityPlayingAnim(Porter, "anim@heists@box_carry@", "idle", 3 ) then
					TaskPlayAnim(Porter, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				end
				goToLocation(Porter, 118.31, -2448.86, 2.65, 0.1, 10000, 263.91, 1.0)
				DeleteEntity(box3)
				DeletePed(Porter)
			end
		end
	end
end)
activateDelBlip = function()
	deleteblip = AddBlipForCoord(34.21, -2777.55, 1.0)
	SetBlipSprite(deleteblip, 455)
	SetBlipDisplay(deleteblip, 4)
	SetBlipScale(deleteblip, 1.0)
	SetBlipColour(deleteblip, 1)
	SetBlipAsShortRange(deleteblip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Delete")
	EndTextCommandSetBlipName(deleteblip)
end

---------[[ped movement]]---------------
goToLocation = function(ped, x,y,z, speed, timeout, heading, distanceToSlide)
    TaskGoStraightToCoord(ped, x, y, z, speed, timeout, heading, distanceToSlide)
    while GetScriptTaskStatus(ped, 0x7d8f4411) ~= 7 do
        Citizen.Wait(0)
    end
    return true
end
function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end
