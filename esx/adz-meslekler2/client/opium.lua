

ESX = nil
Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
		PlayerData = ESX.GetPlayerData() 
end) 

local locationsOpium = {}


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


local MarkerSpawnedOpium = false


Citizen.CreateThread( function()
	Citizen.Wait(1000)
	while true do
	Citizen.Wait(1000)
	if GetDistanceBetweenCoords(Config.PickupBlipOpium.x,Config.PickupBlipOpium.y,Config.PickupBlipOpium.z, GetEntityCoords(GetPlayerPed(-1))) <= 200 then
		if MarkerSpawnedOpium == false then
			TriggerEvent('drc_opium:marker')
			TriggerEvent('drc_opium:marker')
			TriggerEvent('drc_opium:marker')
			TriggerEvent('drc_opium:marker')
			TriggerEvent('drc_opium:marker')
			TriggerEvent('drc_opium:marker')
			TriggerEvent('drc_opium:marker')
		end
		MarkerSpawnedOpium = true
	else
		if MarkerSpawnedOpium then
			locationsOpium = {}
		end
		MarkerSpawnedOpium = false
		
	end
end
end)		

local process = true
blip = false


Citizen.CreateThread(function()
    while true do
		local sleep = 500
			for k in pairs(locationsOpium) do
				if GetDistanceBetweenCoords(locationsOpium[k].x, locationsOpium[k].y, locationsOpium[k].z, GetEntityCoords(GetPlayerPed(-1))) < 300 and Config.Enableopium then	
					sleep = 5		
					DrawMarker(20, locationsOpium[k].x, locationsOpium[k].y, locationsOpium[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 135, 0, 5, 110, 1, 1, 0, 1)	
					if GetDistanceBetweenCoords(locationsOpium[k].x, locationsOpium[k].y, locationsOpium[k].z, GetEntityCoords(GetPlayerPed(-1))) < 3 then			
						DrawText3Ds(locationsOpium[k].x, locationsOpium[k].y, locationsOpium[k].z + 0.8, _U("pickuphelp"))
						
					if IsControlJustReleased(0, Keys['E']) then
						sleep = 5
						PickingupOpium()
						TriggerEvent('drc_opium:Refresh', k)
			

				end
			end				
		end
	end
			if GetDistanceBetweenCoords(Config.ProcessingOpium.x, Config.ProcessingOpium.y, Config.ProcessingOpium.z, GetEntityCoords(GetPlayerPed(-1))) < 300 and Config.Enableopium then			
					DrawMarker(1, Config.ProcessingOpium.x, Config.ProcessingOpium.y, Config.ProcessingOpium.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 255, 255, 255, 110, 1, 1, 0, 1)	
					
					if GetDistanceBetweenCoords(Config.ProcessingOpium.x, Config.ProcessingOpium.y, Config.ProcessingOpium.z, GetEntityCoords(GetPlayerPed(-1)), true) < 2 then			
						sleep = 5
				
						DrawText3Ds(Config.ProcessingOpium.x,Config.ProcessingOpium.y,Config.ProcessingOpium.z + 0.4, _U('processinghelp'))
						

						if IsControlJustReleased(0, Keys['E']) and not blip then
								local playerPed = PlayerPedId()
								sleep = 5
								FreezeEntityPosition(playerPed, true)
								exports['pogressBar']:drawBar(4950, _U('processing'))
								RequestAnimDict("mp_arresting")
								TaskPlayAnim(GetPlayerPed(-1),"mp_arresting", "a_uncuff", 3.0, 3.0, 5000, 51, 0, false, false, false)
								Citizen.Wait(5000)
								blip = true
								TriggerServerEvent('drc_opium:ProcessItems')
								FreezeEntityPosition(playerPed, false)
								Citizen.Wait(3000)
								blip = false
						end
					end
			
					
				end
		Citizen.Wait(sleep)				
	end			
end)



function PickingupOpium()
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
		TriggerServerEvent('drc_opium:Pickup')
		ClearPedTasks(ped)
		FreezeEntityPosition(ped,false)
	end
end

RegisterNetEvent('drc_opium:marker')
AddEventHandler('drc_opium:marker', function()
	local set = false
	Citizen.Wait(10)
	local rnX = Config.PickupBlipOpium.x + math.random(-35, 35)
	local rnY = Config.PickupBlipOpium.y + math.random(-35, 35)	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	table.insert(locationsOpium,{x=rnX, y=rnY, z=Z + 0.3});
end)


RegisterNetEvent('drc_opium:Refresh')
AddEventHandler('drc_opium:Refresh', function(id)
	local set = false
	Citizen.Wait(10)
	local rnX = Config.PickupBlipOpium.x + math.random(-35, 35)
	local rnY = Config.PickupBlipOpium.y + math.random(-35, 35)
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	locationsOpium[id].x = rnX
	locationsOpium[id].y = rnY
	locationsOpium[id].z = Z + 0.3
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




