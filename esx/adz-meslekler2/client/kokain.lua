

ESX = nil
Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
		PlayerData = ESX.GetPlayerData() 
end) 

local locations = {}


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


local MarkerSpawned = false


Citizen.CreateThread( function()
	Citizen.Wait(1000)
	while true do
	Citizen.Wait(1000)
	if GetDistanceBetweenCoords(Config.PickupBlip.x,Config.PickupBlip.y,Config.PickupBlip.z, GetEntityCoords(GetPlayerPed(-1))) <= 200 then
		if MarkerSpawned == false then
			TriggerEvent('drc_coke:marker')
			TriggerEvent('drc_coke:marker')
			TriggerEvent('drc_coke:marker')
			TriggerEvent('drc_coke:marker')
			TriggerEvent('drc_coke:marker')
			TriggerEvent('drc_coke:marker')
			TriggerEvent('drc_coke:marker')
		end
		MarkerSpawned = true
	else
		if MarkerSpawned then
			locations = {}
		end
		MarkerSpawned = false
		
	end
end
end)		

local process = true
blip = false


Citizen.CreateThread(function()
    while true do
		local sleep = 500
			for k in pairs(locations) do
				if GetDistanceBetweenCoords(locations[k].x, locations[k].y, locations[k].z, GetEntityCoords(GetPlayerPed(-1))) < 300 and Config.EnableCoke then	
					sleep = 5		
					DrawMarker(32, locations[k].x, locations[k].y, locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 167, 255, 235, 110, 1, 1, 0, 1)	
					if GetDistanceBetweenCoords(locations[k].x, locations[k].y, locations[k].z, GetEntityCoords(GetPlayerPed(-1))) < 3 then			
						DrawText3Ds(locations[k].x, locations[k].y, locations[k].z + 0.8, _U("pickuphelp"))
						
					if IsControlJustReleased(0, Keys['E']) then
						sleep = 5
						Pickingup()
						TriggerEvent('drc_coke:Refresh', k)
			

				end
			end				
		end
	end
			if GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1))) < 150 and Config.EnableCoke then			
					DrawMarker(1, Config.Processing.x, Config.Processing.y, Config.Processing.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 255, 255, 255, 110, 1, 1, 0, 1)	
					
					if GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1)), true) < 2 then			
						sleep = 5
				
						DrawText3Ds(Config.Processing.x,Config.Processing.y,Config.Processing.z + 0.4, _U('processinghelp'))
						

						if IsControlJustReleased(0, Keys['E']) and not blip then
								local playerPed = PlayerPedId()
								sleep = 8
								FreezeEntityPosition(playerPed, true)
								exports['pogressBar']:drawBar(4950, _U('processing'))
								RequestAnimDict("mp_arresting")
								TaskPlayAnim(GetPlayerPed(-1),"mp_arresting", "a_uncuff", 3.0, 3.0, 5000, 51, 0, false, false, false)
								Citizen.Wait(5000)
								blip = true
								TriggerServerEvent('drc_coke:ProcessItems')
								FreezeEntityPosition(playerPed, false)
								Citizen.Wait(3000)
								blip = false
						end
					end
			
					
				end
		Citizen.Wait(sleep)				
	end			
end)



function Pickingup()
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
		TriggerServerEvent('drc_coke:Pickup')
		ClearPedTasks(ped)
		FreezeEntityPosition(ped,false)
	end
end

RegisterNetEvent('drc_coke:marker')
AddEventHandler('drc_coke:marker', function()
	local set = false
	Citizen.Wait(10)
	local rnX = Config.PickupBlip.x + math.random(-35, 35)
	local rnY = Config.PickupBlip.y + math.random(-35, 35)	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	table.insert(locations,{x=rnX, y=rnY, z=Z + 0.3});
end)


RegisterNetEvent('drc_coke:Refresh')
AddEventHandler('drc_coke:Refresh', function(id)
	local set = false
	Citizen.Wait(10)
	local rnX = Config.PickupBlip.x + math.random(-35, 35)
	local rnY = Config.PickupBlip.y + math.random(-35, 35)
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	locations[id].x = rnX
	locations[id].y = rnY
	locations[id].z = Z + 0.3
end)


function DrawText3Ds(x,y,z, text)
		local onScreen, _x, _y = World3dToScreen2d(x, y, z)
		local px, py, pz = table.unpack(GetGameplayCamCoords())
		if onScreen then
		 SetTextScale(0.55, 0.31)
		 RegisterFontFile('firesans') 
		 fontId = RegisterFontId('Fire Sans') 
		  SetTextFont(fontId)
		  SetTextDropshadow(10, 100, 100, 100, 255)
		  SetTextProportional(1)
		  SetTextColour(255, 255, 255, 215)
		  SetTextEntry("STRING")
		  SetTextCentre(1)
		  AddTextComponentString(text)
		  DrawText(_x,_y)
			  local factor = (string.len(text)) / 370
			  DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 68)
		end
 end




