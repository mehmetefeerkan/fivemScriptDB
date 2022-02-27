ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local clicked = false
local lagaySaCar = false

---------------------------[[MEAT/BAKA]]---------------------------
local PatayAngBaka = false
local AnimalsInSession = {}
local counter = 5
local meatFull = false
RegisterNetEvent('Meat:Full')
AddEventHandler('Meat:Full', function(stat)
	meatFull = stat
end)

RegisterNetEvent('dd_jobs:AMeats')
AddEventHandler('dd_jobs:AMeats', function(x,y,z,h)
	if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_MACHETE') then
		SetEntityCoords(PlayerPedId(),x,y,z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		while (not HasAnimDictLoaded("creatures@rottweiler@tricks@")) do
			RequestAnimDict("creatures@rottweiler@tricks@")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "creatures@rottweiler@tricks@", "petting_franklin", 2.0, -8, -1, 49, 0, 0, 0, 0)
		local finished = exports["skillbar"]:taskBar(6000,math.random(5,15))
		if finished ~= 100 then 
			ClearPedTasks(PlayerPedId()) 	
			TriggerEvent('isClicked.status', false)					
		else
			local rdm = math.random(2,4)
			TriggerServerEvent('dd_jobs:startHarvest','cowmeat','Meat', rdm )
			ClearPedTasks(PlayerPedId())
			while (not HasAnimDictLoaded("creatures@rottweiler@tricks@")) do
				RequestAnimDict("creatures@rottweiler@tricks@")
				Citizen.Wait(5)
			end
			TaskPlayAnim(PlayerPedId(), "creatures@rottweiler@tricks@", "petting_franklin", 2.0, -8, -1, 18, 0, 0, 0, 0)		
			local finished2 = exports["skillbar"]:taskBar(6000,math.random(5,15))
			if finished2 ~= 100 then 
				ClearPedTasks(PlayerPedId()) 
				TriggerEvent('isClicked.status', false)						
			else
				local rdm = math.random(2,4)
				TriggerServerEvent('dd_jobs:startHarvest','cowmeat','Meat', rdm )
				ClearPedTasks(PlayerPedId())
				while (not HasAnimDictLoaded("creatures@rottweiler@tricks@")) do
					RequestAnimDict("creatures@rottweiler@tricks@")
					Citizen.Wait(5)
				end
				TaskPlayAnim(PlayerPedId(), "creatures@rottweiler@tricks@", "petting_franklin", 2.0, -8, -1, 18, 0, 0, 0, 0)		
				local finished3 = exports["skillbar"]:taskBar(6000,math.random(5,15))
				if finished3 ~= 100 then 
					ClearPedTasks(PlayerPedId()) 
					TriggerEvent('isClicked.status', false)						
				else
					local rdm = math.random(2,4)
					TriggerServerEvent('dd_jobs:startHarvest','cowmeat','Meat', rdm )
					ClearPedTasks(PlayerPedId())
					while (not HasAnimDictLoaded("creatures@rottweiler@tricks@")) do
						RequestAnimDict("creatures@rottweiler@tricks@")
						Citizen.Wait(5)
					end
					TaskPlayAnim(PlayerPedId(), "creatures@rottweiler@tricks@", "petting_franklin", 2.0, -8, -1, 18, 0, 0, 0, 0)		
					local finished4 = exports["skillbar"]:taskBar(6000,math.random(5,15))
					if finished4 ~= 100 then 
						ClearPedTasks(PlayerPedId()) 
						TriggerEvent('isClicked.status', false)						
					else
						local rdm = math.random(2,4)
						TriggerServerEvent('dd_jobs:startHarvest','cowmeat','Meat', rdm )
						ClearPedTasks(PlayerPedId())
						while (not HasAnimDictLoaded("creatures@rottweiler@tricks@")) do
							RequestAnimDict("creatures@rottweiler@tricks@")
							Citizen.Wait(5)
						end
						TaskPlayAnim(PlayerPedId(), "creatures@rottweiler@tricks@", "petting_franklin", 2.0, -8, -1, 18, 0, 0, 0, 0)		
						local finished5 = exports["skillbar"]:taskBar(6000,math.random(5,15))
						if finished5 ~= 100 then 
							ClearPedTasks(PlayerPedId()) 
							TriggerEvent('isClicked.status', false)						
						else
							ClearPedTasks(PlayerPedId())
							local rdm = math.random(2,4)
							TriggerServerEvent('dd_jobs:startHarvest','cowmeat','Meat', rdm )
							TriggerEvent('isClicked.status', false)
						end	
					end		
				end		
			end	
		end	
	else
		TriggerEvent('isClicked.status', false)
		exports['okokNotify']:Alert("RAVENS", "You need a long knife", 5000, 'info')
	end
end)

RegisterNetEvent('dd_jobs:CMeat')
AddEventHandler('dd_jobs:CMeat', function()
	TriggerServerEvent('dd_jobs:startCheck', 'cowmeat', 'PackMeat')
end)
RegisterNetEvent('dd_jobs:startPackMeat')
AddEventHandler('dd_jobs:startPackMeat', function()
	while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
		RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
	SetEntityHeading(PlayerPedId(), 271.33)

	local PedCoords = GetEntityCoords(PlayerPedId())
	local box = CreateObject(GetHashKey('hei_prop_heist_box'),-100.29, 6211.48, 30.91, true, true, true)
	SetEntityRotation(box,90.0, 0.0, 45.0, 1,true)

	local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
	if finished ~= 100 then
		ClearPedTasks(PlayerPedId()) 
		DeleteEntity(box)  	
		TriggerEvent('isClicked.status', false)					
	else       
		TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
		local finished2 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished2 ~= 100 then
			DeleteEntity(box) 
			ClearPedTasks(PlayerPedId()) 
			StopPackingMeat()
									
		else       
			TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
			local finished3 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
			if finished3 ~= 100 then
				DeleteEntity(box) 
				ClearPedTasks(PlayerPedId()) 
				StopPackingMeat()
											
			else       
				TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
				local finished4 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished4 ~= 100 then
					DeleteEntity(box) 
					ClearPedTasks(PlayerPedId())  	
					StopPackingMeat()					
							
				else       
					TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
					local finished5 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
					if finished5 ~= 100 then
						DeleteEntity(box) 
						ClearPedTasks(PlayerPedId())  
						StopPackingMeat()						
						
					else       
						TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
						local finished6 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
						if finished6 ~= 100 then
							DeleteEntity(box) 
							ClearPedTasks(PlayerPedId()) 
							StopPackingMeat()
															
						else       
							TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
							local finished7 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
							if finished7 ~= 100 then
								DeleteEntity(box) 
								ClearPedTasks(PlayerPedId()) 
								StopPackingMeat()
															
							else       
								TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
								local finished8 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
								if finished8 ~= 100 then
									DeleteEntity(box) 
									ClearPedTasks(PlayerPedId()) 
									StopPackingMeat()
															
								else       
									TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
									local finished9 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
									if finished9 ~= 100 then
										DeleteEntity(box) 
										ClearPedTasks(PlayerPedId()) 
										StopPackingMeat()
																		
									else    
										TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
										local finished10 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
										if finished10 ~= 100 then
											DeleteEntity(box) 
											ClearPedTasks(PlayerPedId()) 
											StopPackingMeat() 
																			
										else       
											TriggerServerEvent('dd_jobs:startProcess','cowmeat','cowmeat_packed',1)
											Citizen.Wait(0)
											DeleteEntity(box) 
											ClearPedTasks(PlayerPedId())
											StopPackingMeat()		
										end	
									end	
								end	
							end	
						end	
					end	
				end	
			end	
		end	
	end		
end)
function StopPackingMeat()
	exports['okokNotify']:Alert("RAVENS", "Go put box into your vehicle", 15000, 'info')
	lagaySaCar = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local box2 = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(box2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	while lagaySaCar do
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(PlayerPedId())
		LoadDict('anim@heists@box_carry@')

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3 ) and lagaySaCar == true then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		
		if DoesEntityExist(vehicle) then
			lagaySaCar = false
			LoadDict('anim@heists@narcotics@trash')
			TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(900)
			ClearPedTasks(PlayerPedId())
			DeleteEntity(box2)
			TriggerEvent('isClicked.status', false)
		end
	end
end
RegisterNetEvent('dd_jobs:DMeat')
AddEventHandler('dd_jobs:DMeat', function()
	TriggerServerEvent('dd_jobs:startCheck', 'cowmeat_packed', 'SellMeat')
end)
RegisterNetEvent('dd_jobs:startSellMeat')
AddEventHandler('dd_jobs:startSellMeat', function()
	if PatayAngBaka == true then
		PatayAngBaka = false
		counter = 5
	end
	lagaySaCar = true
	while lagaySaCar and not clicked do
		clicked = true
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(PlayerPedId())
		if DoesEntityExist(vehicle) then
			local hashKey = 'ig_chef2'
			RequestModel(hashKey)
			while not HasModelLoaded(hashKey) do
				RequestModel(hashKey)
				Citizen.Wait(100)
			end
			local Buyer = CreatePed(4, hashKey, 54.73, -1730.11, 29.31 - 1.0, 51.56, true, false)
			local sellCow = CreateObject(GetHashKey('hei_prop_heist_box'), 50.86, -1735.63, 29.3-1.00,  true,  true, true)
			SetEntityRotation(sellCow,0.0, 0.0, 134.99, 1,true)
			
			goToLocation(Buyer, 51.27, -1736.05, 29.31, 0.1, 10000, 56.36, 1.0)
			exports['okokNotify']:Alert("BUYER", "Please wait while Buyer is checking meat quality", 5000, 'info')
			local rndmqlty = math.random(2,3)
			while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
				RequestAnimDict("amb@medic@standing@kneel@base")
				Citizen.Wait(5)
			end
			TaskPlayAnim(Buyer, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
			Citizen.Wait(5)
			while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
				RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
				Citizen.Wait(5)
			end
			TaskPlayAnim(Buyer, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
			Citizen.Wait(5000)
			ClearPedTasks(Buyer)
			exports['okokNotify']:Alert("BUYER", 'Meats quality was checked. Price per meat: '..rndmqlty, 5000, 'info')
			Citizen.Wait(5000)
			TriggerServerEvent('dd_jobs:startResell', 'cowmeat_packed', rndmqlty)
			DeleteEntity(sellCow)
			lagaySaCar = false

			local x,y,z = table.unpack(GetEntityCoords(Buyer))
			local box3 = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(box3, Buyer, GetPedBoneIndex(Buyer, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
			LoadDict('anim@heists@box_carry@')

			if not IsEntityPlayingAnim(Buyer, "anim@heists@box_carry@", "idle", 3 ) then
				TaskPlayAnim(Buyer, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			end

			goToLocation(Buyer, 55.58, -1738.6, 29.58, 0.1, 10000, 221.38, 1.0)
			-- Citizen.Wait(1000)
			-- goToLocation(Buyer, 110.66, -1799.29, 27.08, 0.1, 10000, 332.72, 1.0)
			DeletePed(Buyer)
			DeleteEntity(box3)
			clicked = false
			TriggerEvent('isClicked.status', false)
		else
			clicked = false
			lagaySaCar = false
			exports['okokNotify']:Alert("BUYER", "Task not available, SERVICE CAR maybe too far.", 5000, 'info')
			TriggerEvent('isClicked.status', false)
		end
	end
end)

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
function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end