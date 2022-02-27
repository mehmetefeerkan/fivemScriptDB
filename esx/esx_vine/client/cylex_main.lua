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

local melonQTE       			= 0
ESX 			    			= nil
local choped_melonQTE 			= 0
local sarapQTE					= 0
local sarap_poochQTE 			= 0
local myJob 					= nil
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local isInZone                  = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('antihack:hasEnteredMarker', function(zone)
	--if myJob == 'police' or myJob == 'ambulance' then
		--return
	--end

	ESX.UI.Menu.CloseAll()
	
	if zone == 'exitMarker' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('exit_marker')
		CurrentActionData = {}
	end
	
	if zone == 'MelonField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_melon')
		CurrentActionData = {}
	end

	if zone == 'MelonProcessing' then
		if melonQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_melon')
			CurrentActionData = {}
		end
	end

	if zone == 'MelonDealer' then
		if choped_melonQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_melon')
			CurrentActionData = {}
		end
	end

	if zone == 'SarapField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_sarap')
		CurrentActionData = {}
	end

	if zone == 'SarapProcessing' then
		if sarapQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_sarap')
			CurrentActionData = {}
		end
	end

	if zone == 'SarapDealer' then
		if sarap_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_sarap')
			CurrentActionData = {}
		end
	end
end)


AddEventHandler('antihack:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

	TriggerServerEvent('antihack:stopHarvestMelon')
	TriggerServerEvent('antihack:stopTransformMelon')
	TriggerServerEvent('antihack:stopSellMelon')
	TriggerServerEvent('antihack:stopHarvestSarap')
	TriggerServerEvent('antihack:stopTransformSarap')
	TriggerServerEvent('antihack:stopSellSarap')
end)

-- melon Effect
RegisterNetEvent('antihack:onmelon')
AddEventHandler('antihack:onmelon', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(PlayerPedId())
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(PlayerPedId(), true)
	SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(PlayerPedId(), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(600000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(PlayerPedId(), 0)
	SetPedIsDrunk(PlayerPedId(), false)
	SetPedMotionBlur(PlayerPedId(), false)
end)

-- Render markers
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)

        local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
                DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
        end
    end
end)

-- Create Blips
Citizen.CreateThread(function()
	if Config.DisableBlip == false then
	for i=1, #Config.Map, 1 do
		
		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipScale  (blip, Config.Map[i].scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
	end
  end
end)

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('antihack:ReturnInventory')
AddEventHandler('antihack:ReturnInventory', function(melonNbr, melonpNbr, sarapNbr, sarappNbr, jobName, currentZone)
	melonQTE	   = melonNbr
	choped_melonQTE = melonpNbr
	sarapQTE	   = sarapNbr
	sarap_poochQTE = sarappNbr
	myJob		 = jobName
	TriggerEvent('antihack:hasEnteredMarker', currentZone)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.5) then
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerServerEvent('antihack:GetUserInventory', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('antihack:hasExitedMarker', lastZone)
		end

		if isInMarker and isInZone then
			TriggerEvent('antihack:hasEnteredMarker', 'exitMarker')
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'exitMarker' then
					TriggerEvent('antihack:hasExitedMarker', lastZone)
					Citizen.Wait(1000)
				elseif CurrentAction == 'MelonField' then
					TriggerServerEvent('antihack:startHarvestMelon')
				elseif CurrentAction == 'MelonProcessing' then
					TriggerServerEvent('antihack:startTransformMelon')
				elseif CurrentAction == 'MelonDealer' then
					TriggerServerEvent('antihack:startSellMelon')
				elseif CurrentAction == 'SarapField' then
					TriggerServerEvent('antihack:startHarvestSarap')
					TriggerEvent('antihack:HarvestSarapAnimation')
				elseif CurrentAction == 'SarapProcessing' then
					TriggerServerEvent('antihack:startTransformSarap')
				elseif CurrentAction == 'SarapDealer' then
					TriggerServerEvent('antihack:startSellSarap')
				else
					isInZone = false -- not a antihack zone
				end
				CurrentAction = nil
			end
		end
	end
end)



----------------------------------------------------------
--------------------STOP HARVEST/TRANSFORM/SELL-----------
----------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
			if IsControlJustPressed(0, 32) or IsControlJustPressed(0, 33) then
	            TriggerServerEvent('antihack:stopHarvestSarap')
	            TriggerServerEvent('antihack:stopTransformSarap')
	            TriggerServerEvent('antihack:stopSellSarap')
				TriggerServerEvent('antihack:stopHarvestMelon')
	            TriggerServerEvent('antihack:stopTransformMelon')
	            TriggerServerEvent('antihack:stopSellMelon')
		end
	end
end)

RegisterNetEvent('antihack:HarvestSarapAnimation')
AddEventHandler('antihack:HarvestSarapAnimation', function()
    local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
    if not IsEntityPlayingAnim(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_stand_checkingleaves_kneeling_01_inspector", 3) then
        RequestAnimDict("anim@amb@business@weed@weed_inspecting_lo_med_hi@")
        while not HasAnimDictLoaded("anim@amb@business@weed@weed_inspecting_lo_med_hi@") do
            Citizen.Wait(100)
        end
		-- SetEntityCoords(PlayerPedId(), 1920.93, 5096.14, 41.6)
        -- SetEntityHeading(PlayerPedId(), 274.95)
        Wait(100)
        TaskPlayAnim(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_stand_checkingleaves_kneeling_01_inspector", 8.0, -8, -1, 49, 0, 0, 0, 0)
        Wait(2000)
        while IsEntityPlayingAnim(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_stand_checkingleaves_kneeling_01_inspector", 3) do
            Wait(1)
            if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
                ClearPedTasksImmediately(ped)
                break
            end
        end
    end
end)


-- Disable Controls
Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId(-1)
	Citizen.Wait(0)
		if HasAlreadyEnteredMarker then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
		else
			Citizen.Wait(500)
		end
	end
end)
