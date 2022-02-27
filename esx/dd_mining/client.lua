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