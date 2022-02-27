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

ESX = nil
INPUT_CONTEXT = 51

local isSentenced = false
local isJailed = false
local communityServiceFinished = false
local communityPrisonFinished = false
local actionsRemainingComServ = 0
local actionsRemainingPrison = 0
local availableActions_ComServ = {}
local availableActions_Prison = {}
local disable_actions_ComServ = false
local disable_actions_Prison = false

local vassoumodel = "prop_tool_broom"
local vassour_net = nil

local spatulamodel = "bkr_prop_coke_spatula_04"
local spatula_net = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	Citizen.Wait(2000) --Wait for mysql-async
	TriggerServerEvent('dd_prisonwork:checkIfSentenced')
end)
Citizen.CreateThread(function()
	Citizen.Wait(2000) --Wait for mysql-async
	TriggerServerEvent('dd_prisonwork:checkIfJailed')
end)

function FillActionTableComServ(last_action)

	while #availableActions_ComServ < 5 do

		local service_does_not_exist = true

		local random_selection = Config.ComServLocations[math.random(1,#Config.ComServLocations)]

		for i = 1, #availableActions_ComServ do
			if random_selection.coords.x == availableActions_ComServ[i].coords.x and random_selection.coords.y == availableActions_ComServ[i].coords.y and random_selection.coords.z == availableActions_ComServ[i].coords.z then

				service_does_not_exist = false

			end
		end

		if last_action ~= nil and random_selection.coords.x == last_action.coords.x and random_selection.coords.y == last_action.coords.y and random_selection.coords.z == last_action.coords.z then
			service_does_not_exist = false
		end

		if service_does_not_exist then
			table.insert(availableActions_ComServ, random_selection)
		end

	end

end
function FillActionTablePrison(last_action)

	while #availableActions_Prison < 5 do

		local service_does_not_exist = true

		local random_selection = Config.PrisonWorkLocations[math.random(1,#Config.PrisonWorkLocations)]

		for i = 1, #availableActions_Prison do
			if random_selection.coords.x == availableActions_Prison[i].coords.x and random_selection.coords.y == availableActions_Prison[i].coords.y and random_selection.coords.z == availableActions_Prison[i].coords.z then

				service_does_not_exist = false

			end
		end

		if last_action ~= nil and random_selection.coords.x == last_action.coords.x and random_selection.coords.y == last_action.coords.y and random_selection.coords.z == last_action.coords.z then
			service_does_not_exist = false
		end

		if service_does_not_exist then
			table.insert(availableActions_Prison, random_selection)
		end

	end

end
---------------------//COMMUNITY SERVICE//----------------------------------
RegisterNetEvent('dd_prisonwork:inCommunityService')
AddEventHandler('dd_prisonwork:inCommunityService', function(actions_remaining_ComServ)
	local playerPed = PlayerPedId()

	if isSentenced then
		return
	end

	actionsRemainingComServ = actions_remaining_ComServ

	FillActionTableComServ()
	print(":: Available Actions: " .. #availableActions_ComServ)

	ApplyComServSkin()
	ESX.Game.Teleport(playerPed, Config.Comserv)
	isSentenced = true
	communityServiceFinished = false

	while actionsRemainingComServ > 0 and communityServiceFinished ~= true do


		if IsPedInAnyVehicle(playerPed, false) then
			ClearPedTasksImmediately(playerPed)
		end

		Citizen.Wait(20000)

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.Comserv.x, Config.Comserv.y, Config.Comserv.z) > 500 then
			ESX.Game.Teleport(playerPed, Config.Comserv)
				TriggerServerEvent('dd_prisonwork:extendService')
				actionsRemainingComServ = actionsRemainingComServ + Config.ServiceExtensionOnEscape
		end

	end

	TriggerServerEvent('dd_prisonwork:finishCommunityService', -1)
	ESX.Game.Teleport(playerPed, Config.ComservDone)
	isSentenced = false
	TriggerServerEvent('checkClothes:me')
	-- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
	-- 	TriggerEvent('skinchanger:loadSkin', skin)
	-- end)
end)
-----------------------//PRISON WORKS//------------------------
RegisterNetEvent('dd_prisonwork:inPrisonService')
AddEventHandler('dd_prisonwork:inPrisonService', function(actions_remaining_Prison)
	local playerPed = PlayerPedId()

	if isJailed then
		return
	end

	actionsRemainingPrison = actions_remaining_Prison

	FillActionTablePrison()
	print(":: Available Actions: " .. #availableActions_Prison)

	ApplyPrisonSkin()
	ESX.Game.Teleport(playerPed, Config.PrisonWorks)
	isJailed = true
	communityPrisonFinished = false

	while actionsRemainingPrison > 0 and communityPrisonFinished ~= true do


		if IsPedInAnyVehicle(playerPed, false) then
			ClearPedTasksImmediately(playerPed)
		end

		Citizen.Wait(20000)

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.PrisonWorks.x, Config.PrisonWorks.y, Config.PrisonWorks.z) > 500 then
			ESX.Game.Teleport(playerPed, Config.PrisonWorks)
				TriggerServerEvent('dd_prisonwork:extendPrisonService')
				actionsRemainingPrison = actionsRemainingPrison + Config.ServiceExtensionOnEscape
		end

	end

	TriggerServerEvent('dd_prisonwork:finishPrisonService', -1)
	ESX.Game.Teleport(playerPed, Config.PrisonWorksDone)
	isJailed = false
	TriggerServerEvent('checkClothes:me')
	-- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
	-- 	TriggerEvent('skinchanger:loadSkin', skin)
	-- 	end)
end)
-----------------------------------------------------
RegisterNetEvent('dd_prisonwork:finishCommunityService')
AddEventHandler('dd_prisonwork:finishCommunityService', function(source)
	communityServiceFinished = true
	isSentenced = false
	actionsRemainingComServ = 0
end)
RegisterNetEvent('dd_prisonwork:finishPrisonService')
AddEventHandler('dd_prisonwork:finishPrisonService', function(source)
	communityPrisonFinished = true
	isJailed = false
	actionsRemainingPrison = 0
end)

Citizen.CreateThread(function()
	while true do
		:: start_over ::
		Citizen.Wait(1)

		if actionsRemainingComServ > 0 and isSentenced then
			draw2dText( 'You have ' ..ESX.Math.Round(actionsRemainingComServ).. ' more actions to complete before you can finish your service.', { 0.375, 0.955 } )
			DrawAvailableActions()
			DisableViolentActions()

			local pCoords    = GetEntityCoords(PlayerPedId())

			for i = 1, #availableActions_ComServ do
				local distance = GetDistanceBetweenCoords(pCoords, availableActions_ComServ[i].coords, true)

				if distance < 1.5 then
					DisplayHelpText('Press ~INPUT_CONTEXT~ to start.')


					if(IsControlJustReleased(1, 38))then
						tmp_action = availableActions_ComServ[i]
						RemoveActionComServ(tmp_action)
						FillActionTableComServ(tmp_action)
						disable_actions = true

						TriggerServerEvent('dd_prisonwork:completeService')
						actionsRemainingComServ = actionsRemainingComServ - 1

						if (tmp_action.type == "cleaning") then
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local vassouspawn = CreateObject(GetHashKey(vassoumodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(vassouspawn)

							ESX.Streaming.RequestAnimDict("amb@world_human_janitor@male@idle_a", function()
									TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
									AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
									vassour_net = netid
								end)

								ESX.SetTimeout(10000, function()
									disable_actions = false
									DetachEntity(NetToObj(vassour_net), 1, 1)
									DeleteEntity(NetToObj(vassour_net))
									vassour_net = nil
									ClearPedTasks(PlayerPedId())
								end)

						end

						if (tmp_action.type == "gardening") then
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local spatulaspawn = CreateObject(GetHashKey(spatulamodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(spatulaspawn)

							TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
							AttachEntityToEntity(spatulaspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,190.0,190.0,-50.0,1,1,0,1,0,1)
							spatula_net = netid

							ESX.SetTimeout(14000, function()
								disable_actions = false
								DetachEntity(NetToObj(spatula_net), 1, 1)
								DeleteEntity(NetToObj(spatula_net))
								spatula_net = nil
								ClearPedTasks(PlayerPedId())
							end)
						end

						goto start_over
					end
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)
Citizen.CreateThread(function()
	while true do
		:: start_over ::
		Citizen.Wait(1)

		if actionsRemainingPrison > 0 and isJailed then
			draw2dText( 'You have ' ..ESX.Math.Round(actionsRemainingPrison)..' more actions to complete before you can finish your service.', { 0.375, 0.955 } )
			DrawAvailableActions()
			DisableViolentActions()

			local pCoords    = GetEntityCoords(PlayerPedId())

			for i = 1, #availableActions_Prison do
				local distance = GetDistanceBetweenCoords(pCoords, availableActions_Prison[i].coords, true)

				if distance < 1.5 then
					DisplayHelpText('Press ~INPUT_CONTEXT~ to start.')


					if(IsControlJustReleased(1, 38))then
						tmp_action = availableActions_Prison[i]
						RemoveActionPrison(tmp_action)
						FillActionTablePrison(tmp_action)
						disable_actions = true



						if (tmp_action.type == "fixing") then
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local vassouspawn = CreateObject(GetHashKey(vassoumodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(vassouspawn)

							while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do
								RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
								Citizen.Wait(5)
								end
								TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
								SetEntityHeading(PlayerPedId(), 273.92)
								-------------------------------------------------------------------------------------------------------
								local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
									if finished ~= 100 then
										-- -- exports['dd_core']:notify('inform', 'Failed!')
										disable_actions = false
										Citizen.Wait(2000)
										ClearPedTasksImmediately(PlayerPedId())		   
									else
								--------------------------------------------------------
								TriggerServerEvent('dd_prisonwork:completePrisonService')
								actionsRemainingPrison = actionsRemainingPrison - 1
										disable_actions = false
										Citizen.Wait(2000)
										ClearPedTasksImmediately(PlayerPedId())
										--AnimWood()		
								--------------------------------------------------------
								end	
						end

						if (tmp_action.type == "welding") then
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local spatulaspawn = CreateObject(GetHashKey(spatulamodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(spatulaspawn)
							local ped = PlayerPedId()

							TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
								local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
									if finished ~= 100 then
										-- -- exports['dd_core']:notify('inform', 'Failed!')
										disable_actions = false
										Citizen.Wait(2000)
										ClearPedTasksImmediately(PlayerPedId())		   
									else
								--------------------------------------------------------
								TriggerServerEvent('dd_prisonwork:completePrisonService')
								actionsRemainingPrison = actionsRemainingPrison - 1
										disable_actions = false
										Citizen.Wait(2000)
										ClearPedTasksImmediately(PlayerPedId())
										--AnimWood()		
								--------------------------------------------------------
								end	
						end

						goto start_over
					end
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

function RemoveActionComServ(action)

	local action_pos = -1

	for i=1, #availableActions_ComServ do
		if action.coords.x == availableActions_ComServ[i].coords.x and action.coords.y == availableActions_ComServ[i].coords.y and action.coords.z == availableActions_ComServ[i].coords.z then
			action_pos = i
		end
	end

	if action_pos ~= -1 then
		table.remove(availableActions_ComServ, action_pos)
	else
		print("User tried to remove an unavailable action")
	end

end
function RemoveActionPrison(action)

	local action_pos = -1

	for i=1, #availableActions_Prison do
		if action.coords.x == availableActions_Prison[i].coords.x and action.coords.y == availableActions_Prison[i].coords.y and action.coords.z == availableActions_Prison[i].coords.z then
			action_pos = i
		end
	end

	if action_pos ~= -1 then
		table.remove(availableActions_Prison, action_pos)
	else
		print("User tried to remove an unavailable action")
	end

end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawAvailableActions()

	for i = 1, #availableActions_ComServ do
--{ r = 50, g = 50, b = 204 }
		--DrawMarker(21, Config.Comservs[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, true, false, false, true)
		DrawMarker(21, availableActions_ComServ[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 50, 50, 204, 100, false, true, 2, true, false, false, false)

		--DrawMarker(20, Config.Comservs[i].coords, -1, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 162, 250, 80, true, true, 2, 0, 0, 0, 0)
	end
	for i = 1, #availableActions_Prison do
		--{ r = 50, g = 50, b = 204 }
				--DrawMarker(21, Config.Comservs[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, true, false, false, true)
				DrawMarker(21, availableActions_Prison[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 50, 50, 204, 100, false, true, 2, true, false, false, false)
		
				--DrawMarker(20, Config.Comservs[i].coords, -1, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 162, 250, 80, true, true, 2, 0, 0, 0, 0)
			end
end


function DisableViolentActions()

	local playerPed = PlayerPedId()

	if disable_actions == true then
		DisableAllControlActions(0)
	end

	RemoveAllPedWeapons(playerPed, true)

	DisableControlAction(2, 37, true) 
	DisablePlayerFiring(playerPed,true) 
    DisableControlAction(0, 106, true)
    DisableControlAction(0, 140, true)
	DisableControlAction(0, 141, true)
	DisableControlAction(0, 142, true)

	if IsDisabledControlJustPressed(2, 37) then
		SetCurrentPedWeapon(playerPed,GetHashKey("WEAPON_UNARMED"),true) 
	end

	if IsDisabledControlJustPressed(0, 106) then 
		SetCurrentPedWeapon(playerPed,GetHashKey("WEAPON_UNARMED"),true)
	end

end


function ApplyComServSkin()

	local playerPed = PlayerPedId()

	if DoesEntityExist(playerPed) then

		Citizen.CreateThread(function()

			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes2', skin, Config.ComServSuit['prison_wear'].male)
				else
					TriggerEvent('skinchanger:loadClothes2', skin, Config.ComServSuit['prison_wear'].female)
				end
			end)

		SetPedArmour(playerPed, 0)
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		ResetPedMovementClipset(playerPed, 0)

		end)
	end
end
function ApplyPrisonSkin()

	local playerPed = PlayerPedId()

	if DoesEntityExist(playerPed) then

		Citizen.CreateThread(function()

			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes2', skin, Config.PrisonSuit['prison_wear'].male)
				else
					TriggerEvent('skinchanger:loadClothes2', skin, Config.PrisonSuit['prison_wear'].female)
				end
			end)

		SetPedArmour(playerPed, 0)
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		ResetPedMovementClipset(playerPed, 0)

		end)
	end
end

function draw2dText(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end
