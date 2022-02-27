

ESX = nil
Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
		PlayerData = ESX.GetPlayerData() 
end) 

local locationsWeed = {}


local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local MarkerSpawnedWeed = false


Citizen.CreateThread( function()
	Citizen.Wait(1000)
	while true do
	Citizen.Wait(1000)
	if GetDistanceBetweenCoords(Config.PickupBlipWeed.x,Config.PickupBlipWeed.y,Config.PickupBlipWeed.z, GetEntityCoords(GetPlayerPed(-1))) <= 200 then
		if MarkerSpawnedWeed == false then
			TriggerEvent('drc_weed:marker')
			TriggerEvent('drc_weed:marker')
			TriggerEvent('drc_weed:marker')
			TriggerEvent('drc_weed:marker')
			TriggerEvent('drc_weed:marker')
			TriggerEvent('drc_weed:marker')
			TriggerEvent('drc_weed:marker')
		end
		MarkerSpawnedWeed = true
	else
		if MarkerSpawnedWeed then
			locationsWeed = {}
		end
		MarkerSpawnedWeed = false
		
	end
end
end)		

local process = true
blip = false


Citizen.CreateThread(function()
    while true do
		local sleep = 500
			for k in pairs(locationsWeed) do
				if GetDistanceBetweenCoords(locationsWeed[k].x, locationsWeed[k].y, locationsWeed[k].z, GetEntityCoords(GetPlayerPed(-1))) < 300 and Config.Enableweed then	
					sleep = 5		
					DrawMarker(20, locationsWeed[k].x, locationsWeed[k].y, locationsWeed[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 135, 0, 5, 110, 1, 1, 0, 1)	
					if GetDistanceBetweenCoords(locationsWeed[k].x, locationsWeed[k].y, locationsWeed[k].z, GetEntityCoords(GetPlayerPed(-1))) < 3 then			
						DrawText3Ds(locationsWeed[k].x, locationsWeed[k].y, locationsWeed[k].z + 0.8, _U("pickuphelp"))
						
					if IsControlJustReleased(0, Keys['E']) then
						sleep = 5
						PickingupWeed()
						TriggerEvent('drc_weed:Refresh', k)
				end
			end				
		end
	end
		Citizen.Wait(sleep)				
	end			
end)



function PickingupWeed()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		exports['mythic_notify']:DoHudText('error', _U("notinveh"))
	else
		RequestAnimDict("amb@world_human_gardener_plant@male@idle_a")
		Citizen.Wait(100)
		FreezeEntityPosition(ped,true)
		TaskPlayAnim(ped,'amb@world_human_gardener_plant@male@idle_a', 'idle_b', 8.0, 8.0, -1, 0, 0, 0, 0, 0)
		exports['pogressBar']:drawBar(2700, _U("pickup"))
		Citizen.Wait(2700)
		TriggerServerEvent('drc_weed:Pickup')
		ClearPedTasks(ped)
		FreezeEntityPosition(ped,false)
	end
end

RegisterNetEvent('drc_weed:marker')
AddEventHandler('drc_weed:marker', function()
	local set = false
	Citizen.Wait(10)
	local rnX = Config.PickupBlipWeed.x + math.random(-35, 35)
	local rnY = Config.PickupBlipWeed.y + math.random(-35, 35)	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	table.insert(locationsWeed,{x=rnX, y=rnY, z=Z + 0.3});
end)


RegisterNetEvent('drc_weed:Refresh')
AddEventHandler('drc_weed:Refresh', function(id)
	local set = false
	Citizen.Wait(10)
	local rnX = Config.PickupBlipWeed.x + math.random(-35, 35)
	local rnY = Config.PickupBlipWeed.y + math.random(-35, 35)
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	locationsWeed[id].x = rnX
	locationsWeed[id].y = rnY
	locationsWeed[id].z = Z + 0.3
end)





