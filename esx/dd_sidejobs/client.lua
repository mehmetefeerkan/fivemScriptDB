ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local clicked = false
local lagaySaCar = false
------------[[selinggggggg]]--------------
RegisterNetEvent('sidejobs.unloading')
AddEventHandler('sidejobs.unloading', function()
	TriggerServerEvent('sidejobs.cansell')
end)
RegisterNetEvent('sidejobs.cansell')
AddEventHandler('sidejobs.cansell', function()
	lagaySaCar = true
	while lagaySaCar and not clicked do
		clicked = true
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(PlayerPedId())
		if DoesEntityExist(vehicle) then
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			boxToSell = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(boxToSell, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
			LoadDict('anim@heists@box_carry@')

			if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3 ) then
				TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			end
			-- lagaySaCar = false
			-- clicked = false
			TriggerEvent('isClicked.status', false)
		else
			clicked = false
			lagaySaCar = false
			exports['okokNotify']:Alert("BUYER", "Task not available, SERVICE CAR maybe too far.", 5000, 'info')
			TriggerEvent('isClicked.status', false)
		end
	end
end)
RegisterNetEvent('sidejobs.selling')
AddEventHandler('sidejobs.selling', function(product)
	ClearPedTasks(PlayerPedId())
	DeleteEntity(boxToSell)
	exports['okokNotify']:Alert("BUYER", "Please wait while Buyer is checking products quality", 5000, 'info')
	local rndmqlty = math.random(153,225)
	Citizen.Wait(8000)
	exports['okokNotify']:Alert("BUYER", 'Product quality was checked. Price per piece: '..rndmqlty, 5000, 'info')
	TriggerServerEvent('dd_jobs:startResell', product, rndmqlty)
	lagaySaCar = false
	clicked = false
	TriggerEvent('isClicked.status', false)
end)



--------------------[[MANUKAN/CHICKEN]]------------------------
-- local clicked = false
local counter1 = 10
local counter2 = 10
local counter3 = 10
local counter4 = 10
local nakatakas = false
-- local lagaySaCar = false
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

------------------------[[WOODS]]--------------------------------
local woodOnCar = false
local woodFull = false
local woodCounter1 = 10
local woodCounter2 = 10
local woodCounter3 = 10
local woodCounter4 = 10
local woodCounter5 = 10
local woodCounter6 = 10
local woodCounter7 = 10
local woodCounter8 = 10

RegisterNetEvent('Wood:Full')
AddEventHandler('Wood:Full', function(stat)
	woodFull = stat
end)
RegisterNetEvent('dd_jobs:SyncSmoke')
AddEventHandler('dd_jobs:SyncSmoke', function(x,y,z,bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end--ent_dst_wood_chunky  ent_amb_smoke_scrap
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("ent_amb_smoke_gaswork", x,y,z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.5)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 3)
		Citizen.Wait(10000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

RegisterNetEvent('dd_jobs:AWood1')
AddEventHandler('dd_jobs:AWood1', function()

	if not Clicked and not woodFull and woodCounter1 ~= 0 then	
		Clicked = true	
		TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'chainsaw', 0.3) 
		addTrimmer()
		-- GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"),0, true, false)
		-- SetCurrentPedWeapon(PlayerPedId(), "WEAPON_MINIGUN",true)
		while (not HasAnimDictLoaded("random@mugging4")) do
			RequestAnimDict("random@mugging4")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		SetEntityHeading(PlayerPedId(), 104.09)
		Citizen.Wait(10000)
		if woodCounter1 ~= 0 then
			woodCounter1 = woodCounter1 - 1
			exports['okokNotify']:Alert("", 'You have '..woodCounter1..' wood to cut', 3000, 'info')
		end
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"), true, true)
		SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootWoods()
	else
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AWood2')
AddEventHandler('dd_jobs:AWood2', function()
	if not Clicked and not woodFull and woodCounter2 ~= 0 then	
		Clicked = true	
		TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'chainsaw', 0.3) 
		addTrimmer()
		-- GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"),0, true, false)
		-- SetCurrentPedWeapon(PlayerPedId(), "WEAPON_MINIGUN",true)
		while (not HasAnimDictLoaded("random@mugging4")) do
			RequestAnimDict("random@mugging4")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), 331.12)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x + 1.25,y,z)
		Citizen.Wait(10000)
		if woodCounter2 ~= 0 then
			woodCounter2 = woodCounter2 - 1
			exports['okokNotify']:Alert("", 'You have '..woodCounter2..' wood to cut', 3000, 'info')
		end
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"), true, true)
		SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootWoods()
	else
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AWood3')
AddEventHandler('dd_jobs:AWood3', function()
	if not Clicked and not woodFull and woodCounter3 ~= 0 then	
		Clicked = true	
		TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'chainsaw', 0.3) 
		addTrimmer()
		-- GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"),0, true, false)
		-- SetCurrentPedWeapon(PlayerPedId(), "WEAPON_MINIGUN",true)
		while (not HasAnimDictLoaded("random@mugging4")) do
			RequestAnimDict("random@mugging4")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), 270.96)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x + 1.25,y,z)
		Citizen.Wait(10000)
		if woodCounter3 ~= 0 then
			woodCounter3 = woodCounter3 - 1
			exports['okokNotify']:Alert("", 'You have '..woodCounter3..' wood to cut', 3000, 'info')
		end
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"), true, true)
		SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootWoods()
	else
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AWood4')
AddEventHandler('dd_jobs:AWood4', function()
	if not Clicked and not woodFull and woodCounter4 ~= 0 then	
		Clicked = true	
		TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'chainsaw', 0.3) 
		addTrimmer()
		-- GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"),0, true, false)
		-- SetCurrentPedWeapon(PlayerPedId(), "WEAPON_MINIGUN",true)
		while (not HasAnimDictLoaded("random@mugging4")) do
			RequestAnimDict("random@mugging4")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), 314.05)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(10000)
		if woodCounter4 ~= 0 then
			woodCounter4 = woodCounter4 - 1
			exports['okokNotify']:Alert("", 'You have '..woodCounter4..' wood to cut', 3000, 'info')
		end
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"), true, true)
		SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootWoods()
	else
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AWood5')
AddEventHandler('dd_jobs:AWood5', function()
	if not Clicked and not woodFull and woodCounter5 ~= 0 then	
		Clicked = true	
		TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'chainsaw', 0.3) 
		addTrimmer()
		-- GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"),0, true, false)
		-- SetCurrentPedWeapon(PlayerPedId(), "WEAPON_MINIGUN",true)
		while (not HasAnimDictLoaded("random@mugging4")) do
			RequestAnimDict("random@mugging4")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), 81.85)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(10000)
		if woodCounter5 ~= 0 then
			woodCounter5 = woodCounter5 - 1
			exports['okokNotify']:Alert("", 'You have '..woodCounter5..' wood to cut', 3000, 'info')
		end
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"), true, true)
		SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootWoods()
	else
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AWood6')
AddEventHandler('dd_jobs:AWood6', function()
	if not Clicked and not woodFull and woodCounter6 ~= 0 then	
		Clicked = true	
		TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'chainsaw', 0.3) 
		addTrimmer()
		-- GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"),0, true, false)
		-- SetCurrentPedWeapon(PlayerPedId(), "WEAPON_MINIGUN",true)
		while (not HasAnimDictLoaded("random@mugging4")) do
			RequestAnimDict("random@mugging4")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), 351.05)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(10000)
		if woodCounter6 ~= 0 then
			woodCounter6 = woodCounter6 - 1
			exports['okokNotify']:Alert("", 'You have '..woodCounter6..' wood to cut', 3000, 'info')
		end
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"), true, true)
		SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootWoods()
	else
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AWood7')
AddEventHandler('dd_jobs:AWood7', function()
	if not Clicked and not woodFull and woodCounter7 ~= 0 then	
		Clicked = true	
		TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'chainsaw', 0.3) 
		addTrimmer()
		-- GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"),0, true, false)
		-- SetCurrentPedWeapon(PlayerPedId(), "WEAPON_MINIGUN",true)
		while (not HasAnimDictLoaded("random@mugging4")) do
			RequestAnimDict("random@mugging4")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), 330.95)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x + 1.25,y,z)
		Citizen.Wait(10000)
		if woodCounter7 ~= 0 then
			woodCounter7 = woodCounter7 - 1
			exports['okokNotify']:Alert("", 'You have '..woodCounter7..' wood to cut', 3000, 'info')
		end
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"), true, true)
		SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootWoods()
	else
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AWood8')
AddEventHandler('dd_jobs:AWood8', function()
	if not Clicked and not woodFull and woodCounter8 ~= 0 then	
		Clicked = true	
		TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'chainsaw', 0.3) 
		addTrimmer()
		-- GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"),0, true, false)
		-- SetCurrentPedWeapon(PlayerPedId(), "WEAPON_MINIGUN",true)
		while (not HasAnimDictLoaded("random@mugging4")) do
			RequestAnimDict("random@mugging4")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		SetEntityHeading(PlayerPedId(), 81.85)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(10000)
		if woodCounter8 ~= 0 then
			woodCounter8 = woodCounter8 - 1
			exports['okokNotify']:Alert("", 'You have '..woodCounter8..' wood to cut', 3000, 'info')
		end
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MINIGUN"), true, true)
		SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootWoods()
	else
		TriggerEvent('isClicked.status', false)
	end
end)
function LootWoods()
	removeTrimmer()
	woodOnCar = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local kahoy = CreateObject(GetHashKey('prop_snow_fncwood_14a'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(kahoy, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.13, 0.14, -0.08, 40.0, -10.0, -0.25, true, true, false, true, 1, true)
	while woodOnCar do
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(PlayerPedId())

		LoadDict('missfinale_c2mcs_1')
		if not IsEntityPlayingAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3 ) and woodOnCar == true then
			TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', "fin_c2_mcs_1_camman", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		if DoesEntityExist(vehicle) then
			woodOnCar = false
			LoadDict('anim@heists@narcotics@trash')
			TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(900)
			ClearPedTasks(PlayerPedId())
			local rdm = math.random(1,3)
			TriggerServerEvent('dd_jobs:startHarvest','woodlog','Wood',rdm)
			Clicked = false	
			DeleteEntity(kahoy)
			TriggerEvent('isClicked.status', false)
		end
	end
end
RegisterNetEvent('dd_jobs:BWood')
AddEventHandler('dd_jobs:BWood', function()
	TriggerServerEvent('dd_jobs:startCheck', 'woodlog', 'ProcessWood')
end)
RegisterNetEvent('dd_jobs:startProcessWood')
AddEventHandler('dd_jobs:startProcessWood', function()
	woodOnCar = true
	while woodOnCar and not clicked do
		clicked = true
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(PlayerPedId())
		if DoesEntityExist(vehicle) then
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			local kahoy = CreateObject(GetHashKey('prop_snow_fncwood_14a'), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(kahoy, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.13, 0.14, -0.08, 40.0, -10.0, -0.25, true, true, false, true, 1, true)

			LoadDict('missfinale_c2mcs_1')
			if not IsEntityPlayingAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3 ) and woodOnCar == true then
				TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', "fin_c2_mcs_1_camman", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			end
			goToLocation(PlayerPedId(), -531.57, 5291.49, 74.17, 0.1, 10000, 324.19, 1.0)
			LoadDict('random@mugging4')
			if not IsEntityPlayingAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 3 ) and woodOnCar == true then
				TaskPlayAnim(PlayerPedId(), 'random@mugging4', "struggle_loop_b_thief", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			end
			Citizen.Wait(3000)
			ClearPedTasks(PlayerPedId())

			woodOnCar = false
			TriggerServerEvent('dd_jobs:startProcess', 'woodlog','woodprocessed',1)
			DeleteEntity(kahoy)
			clicked = false
			TriggerEvent('isClicked.status', false)
		else
			TriggerEvent('isClicked.status', false)
			woodOnCar = false
			clicked = false
			exports['okokNotify']:Alert("", 'Task not available, SERVICE CAR maybe too far.', 3000, 'info')
		end
	end
end)

RegisterNetEvent('dd_jobs:DWood')
AddEventHandler('dd_jobs:DWood', function()
	TriggerServerEvent('dd_jobs:startCheck', 'woodprocessed', 'SellWood')
end)
RegisterNetEvent('dd_jobs:startSellWood')
AddEventHandler('dd_jobs:startSellWood', function()
	woodOnCar = true
	while woodOnCar and not clicked do
		clicked = true
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(PlayerPedId())
		if DoesEntityExist(vehicle) then
			local hashKey = 'cs_old_man2'
			RequestModel(hashKey)
			while not HasModelLoaded(hashKey) do
				RequestModel(hashKey)
				Citizen.Wait(100)
			end
			local Buyer = CreatePed(4, hashKey, -159.38, -964.99, 21.28 - 1.0, 0.0, true, false)
			local sellkahoy = CreateObject(GetHashKey('prop_woodpile_02a'), -156.55, -974.94, 21.28-1.25,  true,  true, true)
			SetEntityRotation(sellkahoy,0.0, 0.0, 270.0, 1,true)
			goToLocation(Buyer, -154.92, -973.35, 21.28, 0.1, 10000, 161.89, 1.0)
			exports['okokNotify']:Alert("BUYER", 'Please wait while Buyer is checking woods quality', 3000, 'info')
			local rndmqlty = math.random(3,5)
			while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
				RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
				Citizen.Wait(5)
			end
			TaskPlayAnim(Buyer, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
			Citizen.Wait(5000)
			ClearPedTasks(Buyer)
			exports['okokNotify']:Alert("BUYER", 'Woods quality was checked. Price per wood: '..rndmqlty, 3000, 'info')
			Citizen.Wait(5000)
			TriggerServerEvent('dd_jobs:startResell', 'woodprocessed', rndmqlty)
			DeleteEntity(sellkahoy)
			woodOnCar = false
			goToLocation(Buyer, -159.38, -964.99, 21.28, 0.1, 10000, 161.89, 1.0)
			DeletePed(Buyer)
			clicked = false
			woodCounter1 = 10
			woodCounter2 = 10
			woodCounter3 = 10
			woodCounter4 = 10
			woodCounter5 = 10
			woodCounter6 = 10
			woodCounter7 = 10
			woodCounter8 = 10
			TriggerEvent('isClicked.status', false)
		else
			TriggerEvent('isClicked.status', false)
			clicked = false
			woodOnCar = false
			exports['okokNotify']:Alert("", 'Task not available, SERVICE CAR maybe too far.', 3000, 'info')
		end
	end
end)
function addTrimmer()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    trimmer = CreateObject(GetHashKey('prop_hedge_trimmer_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(trimmer, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.02, 0.01, -121.0, 181.0, 187.0, true, true, false, true, 1, true)
end

function removeTrimmer()
    local ped = PlayerPedId()

    DeleteEntity(trimmer)
end

------------------------[[WOODS]]--------------------------------
local stoneOnCar = false
local stoneFull = false
local stoneCounter1 = 10
local stoneCounter2 = 10
local stoneCounter3 = 10
local stoneCounter4 = 10
local stoneCounter5 = 10
local stoneCounter6 = 10
local stoneCounter7 = 10
local stoneCounter8 = 10

RegisterNetEvent('Mining:Full')
AddEventHandler('Mining:Full', function(stat)
	stoneFull = stat
end)
RegisterNetEvent('dd_jobs:SyncSmoke')
AddEventHandler('dd_jobs:SyncSmoke', function(x,y,z,bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end--ent_dst_wood_chunky  ent_amb_smoke_scrap
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("ent_amb_smoke_gaswork", x,y,z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.5)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 3)
		Citizen.Wait(10000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

RegisterNetEvent('dd_jobs:AMining1')
AddEventHandler('dd_jobs:AMining1', function()

	if not Clicked and not stoneFull and stoneCounter1 ~= 0 then	
		Clicked = true	
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)       
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(20000)
		if stoneCounter1 ~= 0 then
			stoneCounter1 = stoneCounter1 - 1
			exports['okokNotify']:Alert("", 'You have '..stoneCounter1..' stone to work', 3000, 'info')
		end
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootStone()
	else
        Clicked = false
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AMining2')
AddEventHandler('dd_jobs:AMining2', function()

	if not Clicked and not stoneFull and stoneCounter2 ~= 0 then	
		Clicked = true	
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)       
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(20000)
		if stoneCounter2 ~= 0 then
			stoneCounter2 = stoneCounter2 - 1
			exports['okokNotify']:Alert("", 'You have '..stoneCounter2..' stone to work', 3000, 'info')
		end
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootStone()
	else
        Clicked = false
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AMining3')
AddEventHandler('dd_jobs:AMining3', function()

	if not Clicked and not stoneFull and stoneCounter3 ~= 0 then	
		Clicked = true	
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)       
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(20000)
		if stoneCounter3 ~= 0 then
			stoneCounter3 = stoneCounter3 - 1
			exports['okokNotify']:Alert("", 'You have '..stoneCounter3..' stone to work', 3000, 'info')
		end
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootStone()
	else
        Clicked = false
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AMining4')
AddEventHandler('dd_jobs:AMining4', function()

	if not Clicked and not stoneFull and stoneCounter4 ~= 0 then	
		Clicked = true	
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)       
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(20000)
		if stoneCounter4 ~= 0 then
			stoneCounter4 = stoneCounter4 - 1
			exports['okokNotify']:Alert("", 'You have '..stoneCounter4..' stone to work', 3000, 'info')
		end
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootStone()
	else
        Clicked = false
		TriggerEvent('isClicked.status', false)
	end
end)
RegisterNetEvent('dd_jobs:AMining5')
AddEventHandler('dd_jobs:AMining5', function()

	if not Clicked and not stoneFull and stoneCounter5 ~= 0 then	
		Clicked = true	
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)       
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		TriggerServerEvent('dd_jobs:SyncSmoke',x - 1.25,y,z)
		Citizen.Wait(20000)
		if stoneCounter5 ~= 0 then
			stoneCounter5 = stoneCounter5 - 1
			exports['okokNotify']:Alert("", 'You have '..stoneCounter5..' stone to work', 3000, 'info')
		end
		Citizen.Wait(0)
		ClearPedTasks(PlayerPedId())
		LootStone()
	else
        Clicked = false
		TriggerEvent('isClicked.status', false)
	end
end)
function LootStone()
	stoneOnCar = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    local bato = CreateObject(GetHashKey('rock_4_cl_2_2'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(bato, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	while stoneOnCar do
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(PlayerPedId())

        LoadDict('anim@heists@box_carry@')
		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3 ) and stoneOnCar == true then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		if DoesEntityExist(vehicle) then
			stoneOnCar = false
			LoadDict('anim@heists@narcotics@trash')
			TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(900)
			ClearPedTasks(PlayerPedId())
            local rdm = math.random(1,3)
			TriggerServerEvent('dd_jobs:startHarvest','stone','Mining', rdm)
			Clicked = false	
			DeleteEntity(bato)
			TriggerEvent('isClicked.status', false)
		end
	end
end
RegisterNetEvent('dd_jobs:unloadStone')
AddEventHandler('dd_jobs:unloadStone', function()
    ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
        if quantity >= 5 then
            TriggerServerEvent('dd_jobs:startCheck', 'stone', 'WashStone')
        else
			exports['okokNotify']:Alert("", 'Not enough stone to wash. You need at least 5 stones to perform a task', 3000, 'info')
            TriggerEvent('isClicked.status', false)
        end
    end, 'stone')
end)
RegisterNetEvent('dd_jobs:startWashStone')
AddEventHandler('dd_jobs:startWashStone', function()
	stoneOnCar = true
	while stoneOnCar and not clicked do
		clicked = true
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(PlayerPedId())
		if DoesEntityExist(vehicle) then
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			local bato1 = CreateObject(GetHashKey('rock_4_cl_2_2'), 2837.2, -673.24, 0.63 - 1.00,  true,  true, true)
            SetEntityRotation(bato1,0.0, 0.0, 270.0, 1,true)
			local bato2 = CreateObject(GetHashKey('rock_4_cl_2_2'), 2836.89, -672.57, 0.63 - 1.00,  true,  true, true)
            SetEntityRotation(bato2,0.0, 0.0, 90.0, 1,true)
            local bato3 = CreateObject(GetHashKey('rock_4_cl_2_2'), 2837.67, -673.42, 0.63 - 1.00,  true,  true, true)
            SetEntityRotation(bato3,0.0, 0.0, 180.0, 1,true)
            local bato4 = CreateObject(GetHashKey('rock_4_cl_2_2'), 2837.11, -674.27, 0.63 - 1.00,  true,  true, true)
            SetEntityRotation(bato4,0.0, 0.0, 0.0, 1,true)
            local bato5 = CreateObject(GetHashKey('rock_4_cl_2_2'), 2836.37, -673.07, 0.63 - 1.00,  true,  true, true)
            SetEntityRotation(bato5,0.0, 0.0, 270.0, 1,true)
            goToLocation(PlayerPedId(), 2835.76, -673.03, 0.8, 0.1, 10000, 275.55, 1.0)
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

			stoneOnCar = false
            local qty = 5
			TriggerServerEvent('dd_jobs:startProcess', 'stone','washed_stone', qty)
			DeleteEntity(bato1)
            DeleteEntity(bato2)
            DeleteEntity(bato3)
            DeleteEntity(bato4)
            DeleteEntity(bato5)
			clicked = false
			TriggerEvent('isClicked.status', false)
		else
			TriggerEvent('isClicked.status', false)
			stoneOnCar = false
			clicked = false
			exports['okokNotify']:Alert("", 'Task not available, SERVICE CAR maybe too far.', 3000, 'info')
		end
	end
end)

RegisterNetEvent('dd_jobs:meltStone')
AddEventHandler('dd_jobs:meltStone', function()
    ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
        if quantity >= 2 then
            TriggerServerEvent('dd_jobs:startCheck', 'washed_stone', 'MeltStone')
        else
			exports['okokNotify']:Alert("", 'Not enough stone to melt. You need at least 3 washed stones', 3000, 'info')
            TriggerEvent('isClicked.status', false)
        end
    end, 'washed_stone')
end)
RegisterNetEvent('dd_jobs:startMeltStone')
AddEventHandler('dd_jobs:startMeltStone', function()
	stoneOnCar = true
	while stoneOnCar and not clicked do
		clicked = true
		Citizen.Wait(250)

        while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
            RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
            Citizen.Wait(5)
        end
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
        local finished = exports["taskbar"]:taskBar(10000,"Melting stones")
        if (finished == 100) then
            ClearPedTasks(PlayerPedId())

            stoneOnCar = false
            TriggerServerEvent('dd_jobs:startProcess1', 'washed_stone',2)

            clicked = false
            TriggerEvent('isClicked.status', false)
        end
	end
end)

RegisterNetEvent('dd_jobs:SellMining')
AddEventHandler('dd_jobs:SellMining', function(product,a,b)
	TriggerServerEvent('dd_jobs:startCheck', product, a,b, 'SellMining')
end)
RegisterNetEvent('dd_jobs:startSellMining')
AddEventHandler('dd_jobs:startSellMining', function(product,a,b)
	stoneOnCar = true
	while stoneOnCar and not clicked do
        Seller()
		clicked = true
		Citizen.Wait(250)
		exports['okokNotify']:Alert("BUYER", 'Please wait while agent is checking '..product..'s quality', 3000, 'info')
        local rndmqlty = math.random(a,b)
        Citizen.Wait(10000)
		exports['okokNotify']:Alert("BUYER", 'Price per '..product..'s: '..rndmqlty, 3000, 'info')
        Citizen.Wait(5000)
        TriggerServerEvent('dd_jobs:startResell', product, rndmqlty)
        stoneOnCar = false
        clicked = false
        stoneCounter1 = 10
        stoneCounter2 = 10
        stoneCounter3 = 10
        stoneCounter4 = 10
        stoneCounter5 = 10
        TriggerEvent('isClicked.status', false)
	end
end)
function Seller()
    local dict = 'mp_safehouselost@'
    local anim = 'package_dropoff'
    local ped = PlayerPedId()
    local time = 3000

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    Citizen.Wait(time)
    ClearPedTasks(ped)
end

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