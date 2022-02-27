local holdingup,hackholdingup,bombholdingup = false,false,false
local loc,secondsRobRemaining,secondsHackRemaining,secondsBombRemaining,blipRobbery = "",0,0,30,nil
globalcoords,globalrotation,globalDoortype,globalbombcoords,globalbombrotation,globalbombDoortype = nil,nil,nil,nil,nil,nil
local gateOpen = false
local doorOpen = false
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
function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('dd_tunnelheist:closedoor')
AddEventHandler('dd_tunnelheist:closedoor', function()
	doorOpen = false
	gateOpen = false
	holdingup = false
	hackholdingup = false
	bombholdingup = false
	TriggerEvent('tunnel:holdingup', false)
	TriggerEvent('tunnel:hackholdingup', false)
	TriggerEvent('tunnel:bombholdingup', false)
end)

RegisterNetEvent('dd_tunnelheist:robberycomplete')
AddEventHandler('dd_tunnelheist:robberycomplete', function(reward)
	exports['okokNotify']:Alert("", 'Successfuly robbed '..reward, 5000, 'warning')
	loc = ""
	secondsRobRemaining = 0
	TriggerServerEvent('dd_tunnelheist:closedoor')
end)

-- ROBBING --
local span = Config.robbingVault
RegisterNetEvent('dd_tunnelheist:startblowtorch')
AddEventHandler('dd_tunnelheist:startblowtorch', function()
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
	Citizen.Wait(span*1000)
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('dd_tunnelheist:currentlyrobbing')
AddEventHandler('dd_tunnelheist:currentlyrobbing', function()
	holdingup = true
	TriggerEvent('tunnel:holdingup', true)
	secondsRobRemaining = span
	if holdingup then
		Citizen.Wait(1000)
		if(secondsRobRemaining > 0)then
			secondsRobRemaining = secondsRobRemaining - 1
		end
	end
end)
RegisterNetEvent('tunnel:vaultposition')
AddEventHandler('tunnel:vaultposition', function()
	if not holdingup then
		TriggerServerEvent('dd_tunnelheist:rob')
	end
end)
RegisterNetEvent('tunnel:hackposition')
AddEventHandler('tunnel:hackposition', function()
	if not hackholdingup then
		ESX.TriggerServerCallback('dd_news:CanStartRobbery', function(CanRob)
			if CanRob then	
				TriggerServerEvent('dd_tunnelheist:hack')
			else
				exports['okokNotify']:Alert("NEWS", "A Global Cooldown has been implemented", 5000, 'warning')
			end
		end)
	end
end)

RegisterNetEvent('tunnel:bombposition')
AddEventHandler('tunnel:bombposition', function()
	if not bombholdingup then
		ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
			if quantity >= 1 then 
				while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
					RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
					Citizen.Wait(5)
					end
					TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
					SetEntityHeading(PlayerPedId(), 174.32)
					bombholdingup = true
					TriggerEvent('tunnel:bombholdingup', true)
				local finished = exports["skillbar"]:taskBar(math.random(1500,6000),math.random(5,15))
				if finished ~= 100 then
					Citizen.Wait(2000)
					ClearPedTasks(PlayerPedId())
					bombholdingup = false
					TriggerEvent('tunnel:bombholdingup', false)
				else
					local finished2 = exports["skillbar"]:taskBar(math.random(1500,6000),math.random(5,15))
					if finished2 ~= 100 then
						Citizen.Wait(2000)
						ClearPedTasks(PlayerPedId())
						bombholdingup = false
						TriggerEvent('tunnel:bombholdingup', false)
					else
						local finished3 = exports["skillbar"]:taskBar(math.random(1500,6000),math.random(5,15))
						if finished3 ~= 100 then
							Citizen.Wait(2000)
							ClearPedTasks(PlayerPedId())
							bombholdingup = false
							TriggerEvent('tunnel:bombholdingup', false)
						else
							local finished4 = exports["skillbar"]:taskBar(math.random(1500,6000),math.random(5,15))
							if finished4 ~= 100 then
								Citizen.Wait(2000)
								ClearPedTasks(PlayerPedId())
								bombholdingup = false
								TriggerEvent('tunnel:bombholdingup', false)
							else
								TriggerServerEvent('dd_tunnelheist:plantbomb')
								Citizen.Wait(2000)
								ClearPedTasks(PlayerPedId())
							end
						end
					end
				end
			else
				exports['okokNotify']:Alert("", "You need a C4", 5000, 'warning')
			end			
		end, 'c4_bank')
	end
end)

-- HACKING --
RegisterNetEvent('dd_tunnelheist:opendoors')
AddEventHandler('dd_tunnelheist:opendoors', function(x,y,z,doortype)
	gateOpen = true
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
RegisterNetEvent('dd_tunnelheist:currentlyhacking')
AddEventHandler('dd_tunnelheist:currentlyhacking', function()
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",7,120, opendoors)
	secondsHackRemaining = 80
end)
function opendoors(success, timeremaining)
	if success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		TriggerEvent('dd_tunnelheist:hackcomplete')
		hackholdingup = true
		TriggerEvent('tunnel:hackholdingup', true)
	else
		exports['okokNotify']:Alert("", "Your attempt at hacking the door was failed", 5000, 'warning')
		print('Failure')
		TriggerEvent('mhacking:hide')
		secondsHackRemaining = 0
		hackholdingup = false
		TriggerEvent('tunnel:hackholdingup', false)
	end
end
RegisterNetEvent('dd_tunnelheist:hackcomplete')
AddEventHandler('dd_tunnelheist:hackcomplete', function()
	exports['okokNotify']:Alert("", "Successfuly hacked the gate lock", 5000, 'warning')
	TriggerServerEvent('dd_tunnelheist:opendoor', -596.1, 2092.57, 131.43, 'v_ilev_ph_cellgate')-- { ['x'] = -596.1, ['y'] = 2092.57, ['z'] = 131.43 }
	secondsHackRemaining = 0
end)

-- BOMB PLANTING --
RegisterNetEvent('dd_tunnelheist:plantbombcomplete')
AddEventHandler('dd_tunnelheist:plantbombcomplete', function()
	exports['okokNotify']:Alert("", "You have planted the bomb, run and cover! It will explode in 20 seconds", 5000, 'warning')
	TriggerServerEvent('dd_tunnelheist:plantbombtoall', -596.17,  2088.94, 131.41, 'prop_mineshaft_door')-- ['x'] = -596.17, ['y'] = 2088.94, ['z'] = 131.41 }
	secondsBombRemaining = 0
end)

RegisterNetEvent('dd_tunnelheist:plantedbomb')
AddEventHandler('dd_tunnelheist:plantedbomb', function(x,y,z,doortype)
	doorOpen = true
	local coords = vector3(x,y,z)
	local obs, distance = ESX.Game.GetClosestObject(doortype, coords)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
	local rotation = GetEntityHeading(obs) + 47.2869
	SetEntityHeading(obs,rotation)
	globalbombcoords = coords
	globalbombrotation = rotation
	globalbombDoortype = doortype
	Citizen.CreateThread(function()
		while doorOpen do
			Wait(2000)
			local obs, distance = ESX.Game.GetClosestObject(globalbombDoortype, globalbombcoords)
			SetEntityHeading(obs, globalbombrotation)
			Citizen.Wait(0);
		end
	end)
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
-- 		AddTextComponentString('Tunnel Heist')
-- 		EndTextCommandSetBlipName(blip)
-- 	end
-- end)
RegisterNetEvent('dd_tunnelheist:killblip')
AddEventHandler('dd_tunnelheist:killblip', function()
    RemoveBlip(blipRobbery)
end)
RegisterNetEvent('dd_tunnelheist:setblip')
AddEventHandler('dd_tunnelheist:setblip', function()
    blipRobbery = AddBlipForCoord(-596.1, 2092.57, 131.43)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 1)
    PulseBlip(blipRobbery)
	PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1)
end)