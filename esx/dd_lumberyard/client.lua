ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local clicked = false
local lagaySaCar = false

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