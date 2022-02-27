ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
--------------------[[MANUKAN/CHICKEN]]------------------------
local clicked = false
local counter1 = 10
local counter2 = 10
local counter3 = 10
local counter4 = 10
local nakatakas = false
local lagaySaCar = false
local endSlaughter = false
local chickFull = false
RegisterNetEvent('Chick:Full')
AddEventHandler('Chick:Full', function(stat)
	chickFull = stat
end)
RegisterNetEvent('dd_jobs:AChick1')
AddEventHandler('dd_jobs:AChick1', function(x,y,z,h)
	local rdm = math.random(0, math.random(0,1))
	if counter1 ~= 0 and not chickFull then
		while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
			RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), h)

		local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished ~= 100 then
			ClearPedTasks(PlayerPedId())
			TriggerEvent('isClicked.status', false)
		else       	
			if rdm > 0 then
				counter1 = counter1 - 1
				exports['okokNotify']:Alert("", 'Chicken count: '..counter1, 3000, 'warning')
				local rdm = math.random(2,4)
				TriggerServerEvent('dd_jobs:startHarvest', 'chicken', 'Chick', rdm)
				ClearPedTasks(PlayerPedId())   
				TriggerEvent('isClicked.status', false)
			else
				counter1 = counter1 - 1
				exports['okokNotify']:Alert("", 'Chicken count: '..counter1, 3000, 'warning')
				nakatakas = true
				nakatakasEh__(x,y,z)
			end   		
		end	
	else
		exports['okokNotify']:Alert("", 'n/a, maybe no more chicken or not enough storage', 3000, 'warning')
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AChick2')
AddEventHandler('dd_jobs:AChick2', function(x,y,z,h)
	local rdm = math.random(0, math.random(0,1))	
	if counter2 ~= 0 and not chickFull then
		while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
			RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), h)

		local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished ~= 100 then
			ClearPedTasks(PlayerPedId())
			TriggerEvent('isClicked.status', false)
		else       	
			if rdm > 0 then
				counter2 = counter2 - 1
				exports['okokNotify']:Alert("", 'Chicken count: '..counter2, 3000, 'warning')
				local rdm = math.random(2,4)
				TriggerServerEvent('dd_jobs:startHarvest', 'chicken', 'Chick', rdm)
				ClearPedTasks(PlayerPedId()) 
				TriggerEvent('isClicked.status', false)  
			else
				counter2 = counter2 - 1
				exports['okokNotify']:Alert("", 'Chicken count: '..counter2, 3000, 'warning')
				nakatakas = true
				nakatakasEh__(x,y,z)
			end   		
		end	
	else
		exports['okokNotify']:Alert("", 'n/a, maybe no more chicken or not enough storage', 3000, 'warning')
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AChick3')
AddEventHandler('dd_jobs:AChick3', function(x,y,z,h)
	local rdm = math.random(0, math.random(0,1))	
	if counter3 ~= 0 and not chickFull then
		while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
			RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), h)

		local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished ~= 100 then
			ClearPedTasks(PlayerPedId())
			TriggerEvent('isClicked.status', false)
		else       	
			if rdm > 0 then
				counter3 = counter3 - 1
				exports['okokNotify']:Alert("", 'Chicken count: '..counter3, 3000, 'warning')
				local rdm = math.random(2,4)
				TriggerServerEvent('dd_jobs:startHarvest', 'chicken', 'Chick', rdm)
				ClearPedTasks(PlayerPedId())   
				TriggerEvent('isClicked.status', false)
			else
				counter3 = counter3 - 1
				exports['okokNotify']:Alert("", 'Chicken count: '..counter3, 3000, 'warning')
				nakatakas = true
				nakatakasEh__(x,y,z)
			end   		
		end	
	else
		exports['okokNotify']:Alert("", 'n/a, maybe no more chicken or not enough storage', 3000, 'warning')
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AChick4')
AddEventHandler('dd_jobs:AChick4', function(x,y,z,h)
	local rdm = math.random(0, math.random(0,1))	
	if counter4 ~= 0 and not chickFull then
		while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
			RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), h)

		local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished ~= 100 then
			ClearPedTasks(PlayerPedId())
			TriggerEvent('isClicked.status', false)
		else       	
			if rdm > 0 then
				counter4 = counter4 - 1
				exports['okokNotify']:Alert("", 'Chicken count: '..counter4, 3000, 'warning')
				local rdm = math.random(2,4)
				TriggerServerEvent('dd_jobs:startHarvest', 'chicken', 'Chick', rdm)
				ClearPedTasks(PlayerPedId()) 
				TriggerEvent('isClicked.status', false)  
			else
				counter4 = counter4 - 1
				exports['okokNotify']:Alert("", 'Chicken count: '..counter4, 3000, 'warning')
				nakatakas = true
				nakatakasEh__(x,y,z) 
			end   		
		end	
	else
		exports['okokNotify']:Alert("", "n/a, maybe no more chicken or not enough storage", 3000, 'warning')
		TriggerEvent('isClicked.status', false)
	end
end)

nakatakasEh__ = function(x,y,z)
	local hashKey = 'a_c_hen'
	RequestModel(hashKey)
	while not HasModelLoaded(hashKey) do
		RequestModel(hashKey)
		Citizen.Wait(100)
	end
	local Animal = CreatePed(5, hashKey, x, y, z - 1.0, 0.0, true, false)
	TaskWanderStandard(Animal, true, true)
	SetEntityAsMissionEntity(Animal, true, true)	
	TaskSmartFleePed(Animal, PlayerPedId(), 150.0, 30.0, false, false)
	ClearPedTasks(PlayerPedId())   
	Citizen.CreateThread(function()
		local sleep = 500
		while nakatakas do
			if DoesEntityExist(Animal) then
				local AnimalCoords = GetEntityCoords(Animal)
				local PlyCoords = GetEntityCoords(PlayerPedId())
				local AnimalHealth = GetEntityHealth(Animal)
				
				local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)
				if PlyToAnimal < 1.0 then
					AnimalHealth = 0
					FreezeEntityPosition(Animal, true)
				end
				if AnimalHealth <= 0 then
					sleep = 5
					SetEntityCoords(PlayerPedId(), AnimalCoords.x , AnimalCoords.y + 0.50, AnimalCoords.z)
					while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
						RequestAnimDict("amb@medic@standing@kneel@base")
						Citizen.Wait(5)
					end
					TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
					Citizen.Wait(5)
					while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
						RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
						Citizen.Wait(5)
					end
					TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
					Citizen.Wait(5000)
					ClearPedTasks(PlayerPedId())
					local rdm = math.random(2,4)
					TriggerServerEvent('dd_jobs:startHarvest', 'chicken', 'Chick', rdm)
					nakatakas = false
					DeleteEntity(Animal)
					TriggerEvent('isClicked.status', false)
				end
			end
			Citizen.Wait(sleep)
		end
	end)
end
RegisterNetEvent('dd_jobs:BChick')
AddEventHandler('dd_jobs:BChick', function()
	TriggerServerEvent('dd_jobs:startCheck', 'chicken', 'ProcessChick')
end)
RegisterNetEvent('dd_jobs:startProcessChick')
AddEventHandler('dd_jobs:startProcessChick', function()
	while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
		RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
	local PedCoords = GetEntityCoords(PlayerPedId())
	local prop = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
	SetEntityHeading(PlayerPedId(), 311.0)
	local chicken = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
	SetEntityRotation(chicken,90.0, 0.0, 45.0, 1,true)

	local box0 = CreateObject(GetHashKey('hei_prop_heist_box'),-95.45, 6208.08, 31.02, true, true, true)
	SetEntityRotation(box0,90.0, 0.0, 45.0, 1,true)

	local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
	if finished ~= 100 then
		ClearPedTasks(PlayerPedId()) 
		DeleteEntity(chicken)
		DeleteEntity(prop)
		DeleteEntity(box0)  	
		TriggerEvent('isClicked.status', false)					
	else       
		TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
		local finished2 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished2 ~= 100 then
			DeleteEntity(chicken)
			DeleteEntity(prop)
			DeleteEntity(box0) 
			ClearPedTasks(PlayerPedId()) 
			StopSlaughter()
									
		else       
			TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
			local finished3 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
			if finished3 ~= 100 then
				DeleteEntity(chicken)
				DeleteEntity(prop)
				DeleteEntity(box0) 
				ClearPedTasks(PlayerPedId()) 
				StopSlaughter()
											
			else       
				TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
				local finished4 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished4 ~= 100 then
					DeleteEntity(chicken)
					DeleteEntity(prop)
					DeleteEntity(box0) 
					ClearPedTasks(PlayerPedId())  	
					StopSlaughter()					
							
				else       
					TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
					local finished5 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
					if finished5 ~= 100 then
						DeleteEntity(chicken)
						DeleteEntity(prop)
						DeleteEntity(box0) 
						ClearPedTasks(PlayerPedId())  
						StopSlaughter()						
						
					else       
						TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
						local finished6 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
						if finished6 ~= 100 then
							DeleteEntity(chicken)
							DeleteEntity(prop)
							DeleteEntity(box0) 
							ClearPedTasks(PlayerPedId()) 
							StopSlaughter()
															
						else       
							TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
							local finished7 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
							if finished7 ~= 100 then
								DeleteEntity(chicken)
								DeleteEntity(prop)
								DeleteEntity(box0) 
								ClearPedTasks(PlayerPedId()) 
								StopSlaughter()
															
							else       
								TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
								local finished8 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
								if finished8 ~= 100 then
									DeleteEntity(chicken)
									DeleteEntity(prop)
									DeleteEntity(box0) 
									ClearPedTasks(PlayerPedId()) 
									StopSlaughter()
															
								else       
									TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
									local finished9 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
									if finished9 ~= 100 then
										DeleteEntity(chicken)
										DeleteEntity(prop)
										DeleteEntity(box0) 
										ClearPedTasks(PlayerPedId()) 
										StopSlaughter()
																		
									else    
										TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
										local finished10 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
										if finished10 ~= 100 then
											DeleteEntity(chicken)
											DeleteEntity(prop)
											DeleteEntity(box0) 
											ClearPedTasks(PlayerPedId()) 
											StopSlaughter() 
																			
										else       
											TriggerServerEvent('dd_jobs:startProcess','chicken','chicken_bald',1)
											Citizen.Wait(0)
											DeleteEntity(chicken)
											DeleteEntity(prop)
											DeleteEntity(box0) 
											ClearPedTasks(PlayerPedId())
											StopSlaughter()
													
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
function StopSlaughter()
	endSlaughter = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local box2 = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(box2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	while endSlaughter do
		Citizen.Wait(250)
		LoadDict('anim@heists@box_carry@')
		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3 ) and endSlaughter == true then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		Citizen.Wait(3000)
		endSlaughter = false
		Citizen.Wait(900)
		ClearPedTasks(PlayerPedId())
		DeleteEntity(box2)
		TriggerEvent('isClicked.status', false)
	end
end
RegisterNetEvent('dd_jobs:CChick')
AddEventHandler('dd_jobs:CChick', function()
	TriggerServerEvent('dd_jobs:startCheck', 'chicken_bald', 'PackChick')
end)
RegisterNetEvent('dd_jobs:startPackChick')
AddEventHandler('dd_jobs:startPackChick', function()
	while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
		RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
	SetEntityHeading(PlayerPedId(), 55.51)

	local PedCoords = GetEntityCoords(PlayerPedId())
	local box = CreateObject(GetHashKey('hei_prop_heist_box'),-100.29, 6211.48, 30.91, true, true, true)
	SetEntityRotation(box,90.0, 0.0, 45.0, 1,true)

	local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
	if finished ~= 100 then
		ClearPedTasks(PlayerPedId()) 
		DeleteEntity(box)  	
		TriggerEvent('isClicked.status', false)					
	else       
		TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
		local finished2 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
		if finished2 ~= 100 then
			DeleteEntity(box) 
			ClearPedTasks(PlayerPedId()) 
			StopPacking()
									
		else       
			TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
			local finished3 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
			if finished3 ~= 100 then
				DeleteEntity(box) 
				ClearPedTasks(PlayerPedId()) 
				StopPacking()
											
			else       
				TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
				local finished4 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished4 ~= 100 then
					DeleteEntity(box) 
					ClearPedTasks(PlayerPedId())  	
					StopPacking()					
							
				else       
					TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
					local finished5 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
					if finished5 ~= 100 then
						DeleteEntity(box) 
						ClearPedTasks(PlayerPedId())  
						StopPacking()						
						
					else       
						TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
						local finished6 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
						if finished6 ~= 100 then
							DeleteEntity(box) 
							ClearPedTasks(PlayerPedId()) 
							StopPacking()
															
						else       
							TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
							local finished7 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
							if finished7 ~= 100 then
								DeleteEntity(box) 
								ClearPedTasks(PlayerPedId()) 
								StopPacking()
															
							else       
								TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
								local finished8 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
								if finished8 ~= 100 then
									DeleteEntity(box) 
									ClearPedTasks(PlayerPedId()) 
									StopPacking()
															
								else       
									TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
									local finished9 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
									if finished9 ~= 100 then
										DeleteEntity(box) 
										ClearPedTasks(PlayerPedId()) 
										StopPacking()
																		
									else    
										TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)   
										local finished10 = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
										if finished10 ~= 100 then
											DeleteEntity(box) 
											ClearPedTasks(PlayerPedId()) 
											StopPacking() 
																			
										else       
											TriggerServerEvent('dd_jobs:startProcess','chicken_bald','chicken_dressed',1)
											Citizen.Wait(0)
											DeleteEntity(box) 
											ClearPedTasks(PlayerPedId())
											StopPacking()		
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
function StopPacking()
	exports['okokNotify']:Alert("", "Go put box into your vehicle", 15000, 'warning')
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
RegisterNetEvent('dd_jobs:DChick')
AddEventHandler('dd_jobs:DChick', function()
	TriggerServerEvent('dd_jobs:startCheck', 'chicken_dressed', 'SellChick')
end)
RegisterNetEvent('dd_jobs:startSellChick')
AddEventHandler('dd_jobs:startSellChick', function()
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
			local Buyer = CreatePed(4, hashKey, 94.85, -1810.02, 27.08 - 1.0, 224.2, true, false)
			local sellChick = CreateObject(GetHashKey('prop_cratepile_05a'), 98.63, -1809.74, 27.07-1.25,  true,  true, true)
			SetEntityRotation(sellChick,0.0, 0.0, 134.99, 1,true)
			goToLocation(Buyer, 98.15, -1810.19, 27.07, 0.1, 10000, 299.77, 1.0)
			exports['okokNotify']:Alert("BUYER", "Please wait while Buyer is checking meat quality", 3000, 'warning')
			local rndmqlty = math.random(3,5)
			while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
				RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
				Citizen.Wait(5)
			end
			TaskPlayAnim(Buyer, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
			Citizen.Wait(5000)
			ClearPedTasks(Buyer)
			exports['okokNotify']:Alert("BUYER", 'Meats quality was checked. Price per meat: '..rndmqlty, 5000, 'warning')
			Citizen.Wait(5000)
			TriggerServerEvent('dd_jobs:startResell', 'chicken_dressed', rndmqlty)
			DeleteEntity(sellChick)
			lagaySaCar = false
			goToLocation(Buyer, 94.85, -1810.02, 27.08, 0.1, 10000, 52.0, 1.0)
			DeletePed(Buyer)
			clicked = false
			TriggerEvent('isClicked.status', false)
			counter1 = 10
			counter2 = 10
			counter3 = 10
			counter4 = 10
		else
			clicked = false
			lagaySaCar = false
			exports['okokNotify']:Alert("", "Task not available, SERVICE CAR maybe too far", 3000, 'warning')
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