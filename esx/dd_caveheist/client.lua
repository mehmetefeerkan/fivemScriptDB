local looting,drilling,bombplanted = false,false,false
local loc,secondsRobRemaining,secondsHackRemaining,secondsBombRemaining,blipRobbery = "",0,0,30,nil
globalcoords,globalrotation,globalDoortype,globalbombcoords,globalbombrotation,globalbombDoortype = nil,nil,nil,nil,nil,nil
local gateOpen = false
-- local doorOpen = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('dd_caveheist:closedoor')
AddEventHandler('dd_caveheist:closedoor', function()
	-- doorOpen = false
	gateOpen = false
	looting = false
	drilling = false
	bombplanted = false
	TriggerEvent('cave:looting', false)
	TriggerEvent('cave:drilling', false)
	TriggerEvent('cave:bombplanted', false)
end)

RegisterNetEvent('dd_caveheist:robberycomplete')
AddEventHandler('dd_caveheist:robberycomplete', function(reward)
	exports['okokNotify']:Alert("", 'Successfuly robbed '..reward, 3000, 'success')
	loc = ""
	secondsRobRemaining = 0
	TriggerServerEvent('dd_caveheist:closedoor')
end)

RegisterNetEvent('cave:lootposition')
AddEventHandler('cave:lootposition', function()
	if looting then
		TriggerServerEvent('dd_caveheist:rob')
	end
end)
RegisterNetEvent('cave:drillposition')
AddEventHandler('cave:drillposition', function()
	if not drilling then
		ESX.TriggerServerCallback('dd_news:CanStartRobbery', function(CanRob)
			if CanRob then	
				TriggerServerEvent('dd_caveheist:drill')
			else
				exports['okokNotify']:Alert("NEWS", 'A Global Cooldown has been implemented', 3000, 'info')
			end
		end)
	end
end)

RegisterNetEvent('cave:bombposition1')
AddEventHandler('cave:bombposition1', function()
	if bombplanted then
		ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
			if quantity >= 1 then 
				while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
					RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
					Citizen.Wait(5)
					end
					TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
					SetEntityHeading(PlayerPedId(), 354.43)
					bombplanted = false
					TriggerEvent('cave:bombplanted', false)
				local finished = exports["skillbar"]:taskBar(math.random(1500,6000),math.random(5,15))
				if finished ~= 100 then
					Citizen.Wait(2000)
					ClearPedTasks(PlayerPedId())
					bombplanted = true
					TriggerEvent('cave:bombplanted', true)
				else
					local finished2 = exports["skillbar"]:taskBar(math.random(1500,6000),math.random(5,15))
					if finished2 ~= 100 then
						Citizen.Wait(2000)
						ClearPedTasks(PlayerPedId())
						bombplanted = true
						TriggerEvent('cave:bombplanted', true)
					else
						local finished3 = exports["skillbar"]:taskBar(math.random(1500,6000),math.random(5,15))
						if finished3 ~= 100 then
							Citizen.Wait(2000)
							ClearPedTasks(PlayerPedId())
							bombplanted = true
							TriggerEvent('cave:bombplanted', true)
						else
							local finished4 = exports["skillbar"]:taskBar(math.random(1500,6000),math.random(5,15))
							if finished4 ~= 100 then
								Citizen.Wait(2000)
								ClearPedTasks(PlayerPedId())
								bombplanted = true
								TriggerEvent('cave:bombplanted', true)
							else
								TriggerServerEvent('dd_caveheist:plantbomb')
								Citizen.Wait(2000)
								ClearPedTasks(PlayerPedId())
							end
						end
					end
				end
			else
				exports['okokNotify']:Alert("", 'You need a C4', 3000, 'info')
			end			
		end, 'c4_bank')
	end
end)

-- HACKING --
RegisterNetEvent('dd_caveheist:opendoors')
AddEventHandler('dd_caveheist:opendoors', function(x,y,z,doortype)
	gateOpen = true
	drilling = true
	TriggerEvent('cave:drilling', true)
	bombplanted = true
	TriggerEvent('cave:bombplanted', true)
	local coords = vector3(x,y,z) -- fix for vectors
	local obs, distance = ESX.Game.GetClosestObject(doortype, coords) -- instant open for people already in site

	local pos = GetEntityCoords(obs);

	local rotation = GetEntityHeading(obs) + 70
	globalcoords = coords
	globalrotation = rotation
	globalDoortype = doortype
	Citizen.CreateThread(function()
		while gateOpen do
			Wait(2000)
			local obs, distance = ESX.Game.GetClosestObject(globalDoortype, globalcoords)
			SetEntityHeading(obs, globalrotation)
		end
	end)
end)
RegisterNetEvent('dd_caveheist:currentlydrilling')
AddEventHandler('dd_caveheist:currentlydrilling', function()
	SetEntityCoords(PlayerPedId(), 3069.61, 2191.02, 1.11-0.95)
	SetEntityHeading(PlayerPedId(), 20.46)

	while (not HasAnimDictLoaded("random@mugging4")) do
		RequestAnimDict("random@mugging4")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "random@mugging4", "struggle_loop_b_thief", 8.0, -8, -1, 49, 0, 0, 0, 0)
	FreezeEntityPosition(PlayerPedId(), true)

	local PedCoords = GetEntityCoords(PlayerPedId())
	local prop = CreateObject(GetHashKey('prop_tool_drill'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.05, 0.0, 0.15, 95.0, 90.0, 90.0, false, false, false, false, 2, true)

	local finished = exports["taskbar"]:taskBar(60000,"Drilling door")
    if (finished == 100) then
		FreezeEntityPosition(PlayerPedId(), false)
		DeleteEntity(prop)
		TriggerEvent('dd_caveheist:drillcomplete')
		
	end
end)

RegisterNetEvent('dd_caveheist:drillcomplete')
AddEventHandler('dd_caveheist:drillcomplete', function()
	exports['okokNotify']:Alert("", 'Successfuly hacked the gate lock', 3000, 'info')
	TriggerServerEvent('dd_caveheist:opendoor', 3070.454, 2192.382, 1.367756, 'v_ilev_ph_cellgate')-- { ['x'] = -596.1, ['y'] = 2092.57, ['z'] = 131.43 }
	secondsHackRemaining = 0
end)

-- BOMB PLANTING --
RegisterNetEvent('dd_caveheist:plantbombcomplete')
AddEventHandler('dd_caveheist:plantbombcomplete', function()
	exports['okokNotify']:Alert("", 'You have planted the bomb, run and cover! It will explode in 10 seconds', 3000, 'info')
	TriggerServerEvent('dd_caveheist:plantbombtoall', 3069.1, 2219.89, 2.48, 'prop_lev_crate_01')-- ['x'] = -596.17, ['y'] = 2088.94, ['z'] = 131.41 }
	secondsBombRemaining = 0
end)

RegisterNetEvent('dd_caveheist:plantedbomb')
AddEventHandler('dd_caveheist:plantedbomb', function(x,y,z,boxtype)
	local coords = vector3(x,y,z)
	local obs, distance = ESX.Game.GetClosestObject(boxtype, coords)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
	looting = true
	TriggerEvent('cave:looting', true)
	box0 = CreateObject(GetHashKey('hei_prop_heist_box'),3068.25, 2217.15,2.53-0.99, true, true, true)
	SetEntityRotation(box0,90.0, 0.0, 45.0, 1,true)
	box1 = CreateObject(GetHashKey('hei_prop_heist_box'),3067.5, 2216.66, 2.72-0.99, true, true, true)
	SetEntityRotation(box1,90.0, 0.0, 45.0, 1,true)
	box2 = CreateObject(GetHashKey('hei_prop_heist_box'),3069.97, 2216.55, 2.21-0.99, true, true, true)
	SetEntityRotation(box2,90.0, 0.0, 45.0, 1,true)
	box3 = CreateObject(GetHashKey('hei_prop_heist_box'),3069.69, 2217.91, 2.26-0.99, true, true, true)
	SetEntityRotation(box3,90.0, 0.0, 45.0, 1,true)
	box4 = CreateObject(GetHashKey('hei_prop_heist_box'),3068.95, 2218.04, 2.43-0.99, true, true, true)
	SetEntityRotation(box4,90.0, 0.0, 45.0, 1,true)
	box5 = CreateObject(GetHashKey('hei_prop_heist_box'),3069.1, 2216.98, 2.38-0.99, true, true, true)
	SetEntityRotation(box5,90.0, 0.0, 45.0, 1,true)
end)
-- ROBBING --
local span = Config.robbingVault
RegisterNetEvent('dd_caveheist:starLooting')
AddEventHandler('dd_caveheist:starLooting', function()
	while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
		RequestAnimDict("amb@medic@standing@kneel@base")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8, -1, 1, 0, 0, 0, 0 )
	Citizen.Wait(5)
	while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
		RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8, -1, 49, 0, 0, 0, 0 )
	local finished = exports["taskbar"]:taskBar(span*1000,"Looting box")
    if (finished == 100) then
		DeleteEntity(box0)
	end
	while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
		RequestAnimDict("amb@medic@standing@kneel@base")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8, -1, 1, 0, 0, 0, 0 )
	Citizen.Wait(5)
	while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
		RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8, -1, 49, 0, 0, 0, 0 )
	local finished1 = exports["taskbar"]:taskBar(span*1000,"Looting box")
    if (finished1 == 100) then
		DeleteEntity(box1)
	end
	while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
		RequestAnimDict("amb@medic@standing@kneel@base")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8, -1, 1, 0, 0, 0, 0 )
	Citizen.Wait(5)
	while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
		RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8, -1, 49, 0, 0, 0, 0 )
	local finished2 = exports["taskbar"]:taskBar(span*1000,"Looting box")
    if (finished2 == 100) then
		DeleteEntity(box2)
	end
	while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
		RequestAnimDict("amb@medic@standing@kneel@base")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8, -1, 1, 0, 0, 0, 0 )
	Citizen.Wait(5)
	while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
		RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8, -1, 49, 0, 0, 0, 0 )
	local finished3 = exports["taskbar"]:taskBar(span*1000,"Looting box")
    if (finished3 == 100) then
		DeleteEntity(box3)
	end
	while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
		RequestAnimDict("amb@medic@standing@kneel@base")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8, -1, 1, 0, 0, 0, 0 )
	Citizen.Wait(5)
	while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
		RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8, -1, 49, 0, 0, 0, 0 )
	local finished4 = exports["taskbar"]:taskBar(span*1000,"Looting box")
    if (finished4 == 100) then
		DeleteEntity(box4)
	end
	while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
		RequestAnimDict("amb@medic@standing@kneel@base")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8, -1, 1, 0, 0, 0, 0 )
	Citizen.Wait(5)
	while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
		RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8, -1, 49, 0, 0, 0, 0 )
	local finished5 = exports["taskbar"]:taskBar(span*1000,"Looting box")
    if (finished5 == 100) then
		DeleteEntity(box5)
		ClearPedTasks(PlayerPedId())
	end
	
end)

lootingAnim = function(box)
	while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
		RequestAnimDict("amb@medic@standing@kneel@base")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8, -1, 1, 0, 0, 0, 0 )
	Citizen.Wait(5)
	while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
		RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
		Citizen.Wait(5)
	end
	local finished = exports["taskbar"]:taskBar(span*1000,"Looting box")
    if (finished == 100) then
		DeleteEntity(box)
		ClearPedTasks(PlayerPedId())
	end
end

RegisterNetEvent('dd_caveheist:currentlyrobbing')
AddEventHandler('dd_caveheist:currentlyrobbing', function()
	secondsRobRemaining = span
	if looting then
		Citizen.Wait(1000)
		if(secondsRobRemaining > 0)then
			secondsRobRemaining = secondsRobRemaining - 1
		end
	end
end)
-- BLIP --
-- Citizen.CreateThread(function()
-- 	for k,v in pairs(Location)do
-- 		local ve = v.hackposition
-- 		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
-- 		SetBlipSprite(blip, 364)--156
-- 		SetBlipScale(blip, 1.0)
-- 		SetBlipColour(blip, 1)
-- 		SetBlipAsShortRange(blip, true)
-- 		BeginTextCommandSetBlipName("STRING")
-- 		AddTextComponentString('Cave Heist')
-- 		EndTextCommandSetBlipName(blip)
-- 	end
-- end)
RegisterNetEvent('dd_caveheist:killblip')
AddEventHandler('dd_caveheist:killblip', function()
    RemoveBlip(blipRobbery)
end)
RegisterNetEvent('dd_caveheist:setblip')
AddEventHandler('dd_caveheist:setblip', function()
    blipRobbery = AddBlipForCoord(3068.25, 2217.15,2.53)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 1)
    PulseBlip(blipRobbery)
end)