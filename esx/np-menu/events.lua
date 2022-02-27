----   ____    ____         ----   
----  /\  _`\ /\  _`\       ----  
----  \ \ \/\ \ \ \L\ \     ----
----   \ \ \ \ \ \ ,  /     ----
----    \ \ \_\ \ \ \\ \    ----
----     \ \____/\ \_\ \_\  ----
----      \/___/  \/_/\/ /  ----

ESX                           = nil         -- don't touch

local PlayerData              = {}          -- don't touch

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent("walkanimation")
AddEventHandler("walkanimation", function(ad)
    local player = PlayerPedId()
    --ESX.Streaming.RequestAnimSet(lib, function()
      --  SetPedMovementClipset(PlayerPedId(), anim, true)
   -- end)
   ResetPedMovementClipset(player, 0.0)
   RequestWalking(ad)
   SetPedMovementClipset(player, ad, 0.25)
   RemoveAnimSet(ad)
end)

RegisterNetEvent("ygx:togglegas")
AddEventHandler("ygx:togglegas", function()
   -- DeleteWaypoint()

    local currentGasBlip = 0

	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords

	for k,v in pairs(GasStations) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
            closestCoords = v
        end
    end

    SetNewWaypoint(closestCoords)
	-- exports["mythic_notify"]:SendAlert("inform", "En yakın benzinci GPS'de işaretlendi.", 3500)
	TriggerEvent('notification', 'En yakın benzinci GPSte işaretlendi.', 1)

end)

RegisterNetEvent("ygx:togglebarber")
AddEventHandler("ygx:togglebarber", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords1

	for k,v in pairs(BarberShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords1 = v
		end
    end
    
    SetNewWaypoint(closestCoords1)
	-- exports["mythic_notify"]:SendAlert("inform", "En yakın berber GPS'de işaretlendi.", 3500)
	TriggerEvent('notification', 'En yakın berber GPSte işaretlendi.', 1)
end)


RegisterNetEvent("ygx:togglegaraj")
AddEventHandler("ygx:togglegaraj", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords1

	for k,v in pairs(Garages) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords1 = v
		end
    end
    
    SetNewWaypoint(closestCoords1)
	-- exports["mythic_notify"]:SendAlert("inform", "En yakın garaj GPS'de işaretlendi.", 3500)
	TriggerEvent('notification', 'En yakın garaj GPSte işaretlendi.', 1)
end)

RegisterNetEvent("ygx:toggleeczane")
AddEventHandler("ygx:toggleeczane", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords1

	for k,v in pairs(Eczane) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords1 = v
		end
    end
    
    SetNewWaypoint(closestCoords1)
	-- exports["mythic_notify"]:SendAlert("inform", "En yakın garaj GPS'de işaretlendi.", 3500)
	TriggerEvent('notification', 'En yakın garaj GPSte işaretlendi.', 1)
end)
RegisterNetEvent("ygx:toggletattos")
AddEventHandler("ygx:toggletattos", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(TattoShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
	-- exports["mythic_notify"]:SendAlert("inform", "En yakın dövmeci GPS'de işaretlendi.", 3500)
	TriggerEvent('notification', 'En yakın dövmeci GPSte işaretlendi.', 1)
end)

RegisterNetEvent('meslekbak')
AddEventHandler('meslekbak', function()
ExecuteCommand("meslek")
end)

Garages = {
	vector3(223.48, -761.68, 30.82),
	vector3(892.24, -1023.31, 34.97), --
	vector3(1158.05, -1478.2, 34.69), --
	vector3(-163.26, -1306.34, 31.31), --
	vector3(-1913.91, 2028.61, 140.74), --
	vector3(472.42, -1112.46, 29.2), --
	vector3(1306.91, 1192.32, 107.43),
	vector3(1068.21, 244.31, 80.86), --
	vector3(-6.43, -1082.5, 26.67), --
	vector3(-358.6, -100.21, 45.66), --
	vector3(1737.59, 3710.2, 34.14), --
	vector3(-733.62, -71.04, 41.75),  --
	vector3(1854.73, 2579.05, 45.37), --
	vector3(1212.32, 339.94, 81.99), --
	vector3(282.01, 68.41, 94.37), --
	vector3(273.35, -343.33, 44.92), --
	vector3(-1594.85, -873.94, 9.94), --
	vector3(45.84, -1732.4, 29.3), --
	vector3(361.12, -1690.49, 32.53), --
	vector3(421.99, -1326.06, 46.05), --
	vector3(-569.87, 316.27, 84.46), --
	vector3(-1977.68, -291.78, 44.11), --
	vector3(-693.9, -738.11, 29.36), --
	vector3(113.75, 6607.77, 31.89), --

}

Eczane = {
	vector3(319.9, -1073.85, 29.48),
	vector3(96.9, -226.22, 54.68),
}


TattoShops = {
	vector3(1322.6, -1651.9, 51.2),
	vector3(-1153.6, -1425.6, 4.9),
	vector3(322.1, 180.4, 103.5),
	vector3(-3170.0, 1075.0, 20.8),
	vector3(1864.6, 3747.7, 33.0),
	vector3(-293.7, 6200.0, 31.4)
}

BarberShops = {
	vector3(-814.308, -183.823, 37.568),
	vector3(136.826, -1708.373, 29.291),
	vector3(-1282.604, -1116.757, 6.990),
	vector3(1931.513, 3729.671, 32.844),
	vector3(1212.840, -472.921, 66.208),
	vector3(-32.885, -152.319, 57.0769),
	vector3(-278.077, 6228.463, 31.695)
}

GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

RegisterNetEvent("walkanimation:default")
AddEventHandler("walkanimation:default", function()
    local player = PlayerPedId()
    --ESX.Streaming.RequestAnimSet(lib, function()
      --  SetPedMovementClipset(PlayerPedId(), anim, true)
   -- end)
   ResetPedMovementClipset(player, 0.0)
   RemoveAnimSet(ad)
end)

RegisterNetEvent("carcontrol:opens")
AddEventHandler("carcontrol:opens", function()
	exports["carcontrol"]:OpenUI()
end)

function engine(player)
	local vehicle = GetVehiclePedIsIn(player,false)

	local IsEngineOn = GetIsVehicleEngineRunning(vehicle)
	print(IsEngineOn)
	if (IsPedSittingInAnyVehicle(player)) then 
		
		if IsEngineOn == 1 then
			--IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,true)
		else
			--IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,true)
		end
		
		while (IsEngineOn == 0) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end

local windowup = true

function camlariAc()
	local player = PlayerPedId()
    		local vehicle = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
			
			
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			local camAcikMi1 = IsVehicleWindowIntact(vehicle, 0)
			local camAcikMi2 = IsVehicleWindowIntact(vehicle, 1)
			
	if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(PlayerId())) then
		
		if windowup then
				
					
				RollDownWindows(vehicle)
				windowup = false
			else
				RollUpWindow(vehicle, 0)
				RollUpWindow(vehicle, 1)
				RollUpWindow(vehicle, 2)
				RollUpWindow(vehicle, 3)
				windowup = true
			end
		end
end

function neon()
	
    	
	local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
	local ped = GetPlayerPed(PlayerId())
	
	
	
	
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(veh, 1))
	local acikMi0 = IsVehicleNeonLightEnabled(veh, 0)
	local acikMi1 = IsVehicleNeonLightEnabled(veh, 1)
	local acikMi2 = IsVehicleNeonLightEnabled(veh, 2)
	local acikMi3 = IsVehicleNeonLightEnabled(veh, 3)
	
	if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
	
		if IsPedSittingInAnyVehicle(ped, false) then
		
			if acikMi0 or acikMi1 or acikMi2 or acikMi3 then

			SetVehicleNeonLightEnabled(veh, 0, false)
			SetVehicleNeonLightEnabled(veh, 1, false)
			SetVehicleNeonLightEnabled(veh, 2, false)
			SetVehicleNeonLightEnabled(veh, 3, false)
			
			else 
			
			SetVehicleNeonLightEnabled(veh, 0, true)
			SetVehicleNeonLightEnabled(veh, 1, true)
			SetVehicleNeonLightEnabled(veh, 2, true)
			SetVehicleNeonLightEnabled(veh, 3, true)
			
			end

	else
		ShowNotification("~r~Aracının Yanında Olmalısın!")
	end
	
end	
end

RegisterNetEvent("vehfunc")
AddEventHandler("vehfunc", function(arg)
local playerId = PlayerPedId()
print(arg)
	if arg == "engine" then
		engine(playerId)
	elseif arg == "neon" then
neon()
	elseif arg == "window" then 
		camlariAc()
		if windowup == true then
		
		end
	end
end)
RegisterNetEvent("kimlikmenu")
AddEventHandler("kimlikmenu", function(arg)

if arg == "gor" then
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))

elseif arg == "goster" then

local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
			  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
			else
			  ESX.ShowNotification('Yakında oyuncu yok')
			end
		elseif arg == "ehliyetgor" then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')

		elseif arg == "ehliyetver" then
			
		local player, distance = ESX.Game.GetClosestPlayer()
			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
			  else
				ESX.ShowNotification('Yakında oyuncu yok')
			  end
		end

end)

function RequestWalking(ad)
	RequestAnimSet( ad )
	while ( not HasAnimSetLoaded( ad ) ) do 
		Citizen.Wait( 500 )
	end 
end

RegisterNetEvent("expressions")
AddEventHandler("expressions", function(emote)
    SetFacialIdleAnimOverride(PlayerPedId(), emote)
end)

RegisterNetEvent('esx_mechanic1job:onHijack')
AddEventHandler('esx_mechanic1job:onHijack', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)

		end
	end
end)


RegisterNetEvent('esx_mechanic1job:onCarokit')
AddEventHandler('esx_mechanic1job:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanic1job:onFixkit')
AddEventHandler('esx_mechanic1job:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
	end
end)
RegisterNetEvent('esx_mechanicjob:clean')
AddEventHandler('esx_mechanicjob:clean', function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		Citizen.CreateThread(function()
			Citizen.Wait(10000)

			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(playerPed)


			exports['b1g_notify']:SendAlert('inform', 'Araç Tamir Edildi.', 3000)
			isBusy = false
		end)
	else
		-- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yakında Araç Yok', length = 2500})
		TriggerEvent('notification', 'Yakında Araç Yok', 2)
	end
end)


RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)





local holdingCam = false
local usingCam = false
local holdingMic = false
local usingMic = false
local camModel = "prop_v_cam_01"
local camanimDict = "missfinale_c2mcs_1"
local camanimName = "fin_c2_mcs_1_camman"
local micModel = "p_ing_microphonel_01"
local micanimDict = "missheistdocksprep1hold_cellphone"
local micanimName = "hold_cellphone"
local mic_net = nil
local cam_net = nil
local UI = { 
	x =  0.000 ,
	y = -0.001 ,
}

---------------------------------------------------------------------------
-- Toggling Cam --
---------------------------------------------------------------------------
RegisterNetEvent("Cam:ToggleCam")
AddEventHandler("Cam:ToggleCam", function()
    if not holdingCam then
        RequestModel(GetHashKey(camModel))
        while not HasModelLoaded(GetHashKey(camModel)) do
            Citizen.Wait(100)
        end
		
        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local camspawned = CreateObject(GetHashKey(camModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local netid = ObjToNet(camspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(camspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        cam_net = netid
        holdingCam = true
		DisplayNotification("To enter News cam press ~INPUT_PICKUP~ \nTo Enter Movie Cam press ~INPUT_INTERACTION_MENU~")
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(cam_net), 1, 1)
        DeleteEntity(NetToObj(cam_net))
        cam_net = nil
        holdingCam = false
        usingCam = false
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingCam then
			while not HasAnimDictLoaded(camanimDict) do
				RequestAnimDict(camanimDict)
				Citizen.Wait(100)
			end

			if not IsEntityPlayingAnim(PlayerPedId(), camanimDict, camanimName, 3) then
				TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
				TaskPlayAnim(GetPlayerPed(PlayerId()), camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
			end
				
			DisablePlayerFiring(PlayerId(), true)
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0, 44,  true) -- INPUT_COVER
			DisableControlAction(0,37,true) -- INPUT_SELECT_WEAPON
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
		end
	end
end)

---------------------------------------------------------------------------
-- Cam Functions --
---------------------------------------------------------------------------

local fov_max = 70.0
local fov_min = 5.0
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0

local camera = false
local fov = (fov_max+fov_min)*0.5

---------------------------------------------------------------------------
-- Movie Cam --
---------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		local lPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(lPed)

		if holdingCam and IsControlJustReleased(1, 244) then
			movcamera = true

			SetTimecycleModifier("default")

			SetTimecycleModifierStrength(0.3)
			
			local scaleform = RequestScaleformMovie("security_camera")

			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end


			local lPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(lPed)
			local cam1 = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam1, lPed, 0.0,0.0,1.0, true)
			SetCamRot(cam1, 2.0,1.0,GetEntityHeading(lPed))
			SetCamFov(cam1, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "security_camera")
			PopScaleformMovieFunctionVoid()

			while movcamera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
				if IsControlJustPressed(0, 177) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					movcamera = false
				end
				
				SetEntityRotation(lPed, 0, 0, new_z,2, true)

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam1, zoomvalue)

				HandleZoom(cam1)
				HideHUDThisFrame()

				drawRct(UI.x + 0.0, 	UI.y + 0.0, 1.0,0.15,0,0,0,255) -- Top Bar
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				drawRct(UI.x + 0.0, 	UI.y + 0.85, 1.0,0.16,0,0,0,255) -- Bottom Bar
				
				local camHeading = GetGameplayCamRelativeHeading()
				local camPitch = GetGameplayCamRelativePitch()
				if camPitch < -70.0 then
					camPitch = -70.0
				elseif camPitch > 42.0 then
					camPitch = 42.0
				end
				camPitch = (camPitch + 70.0) / 112.0
				
				if camHeading < -180.0 then
					camHeading = -180.0
				elseif camHeading > 180.0 then
					camHeading = 180.0
				end
				camHeading = (camHeading + 180.0) / 360.0
				
				Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Pitch", camPitch)
				Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Heading", camHeading * -1.0 + 1.0)
				
				Citizen.Wait(10)
			end

			movcamera = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam1, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

---------------------------------------------------------------------------
-- News Cam --
---------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		local lPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(lPed)

		if holdingCam and IsControlJustReleased(1, 38) then
			newscamera = true

			SetTimecycleModifier("default")

			SetTimecycleModifierStrength(0.3)
			
			local scaleform = RequestScaleformMovie("security_camera")
			local scaleform2 = RequestScaleformMovie("breaking_news")


			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end
			while not HasScaleformMovieLoaded(scaleform2) do
				Citizen.Wait(10)
			end


			local lPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(lPed)
			local cam2 = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam2, lPed, 0.0,0.0,1.0, true)
			SetCamRot(cam2, 2.0,1.0,GetEntityHeading(lPed))
			SetCamFov(cam2, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunction(scaleform2, "breaking_news")
			PopScaleformMovieFunctionVoid()

			while newscamera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
				if IsControlJustPressed(1, 177) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					newscamera = false
				end

				SetEntityRotation(lPed, 0, 0, new_z,2, true)
					
				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam2, zoomvalue)

				HandleZoom(cam2)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				DrawScaleformMovie(scaleform2, 0.5, 0.63, 1.0, 1.0, 255, 255, 255, 255)
				Breaking("BREAKING NEWS")
				
				local camHeading = GetGameplayCamRelativeHeading()
				local camPitch = GetGameplayCamRelativePitch()
				if camPitch < -70.0 then
					camPitch = -70.0
				elseif camPitch > 42.0 then
					camPitch = 42.0
				end
				camPitch = (camPitch + 70.0) / 112.0
				
				if camHeading < -180.0 then
					camHeading = -180.0
				elseif camHeading > 180.0 then
					camHeading = 180.0
				end
				camHeading = (camHeading + 180.0) / 360.0
				
				Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Pitch", camPitch)
				Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Heading", camHeading * -1.0 + 1.0)
				
				Citizen.Wait(10)
			end

			newscamera = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam2, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

---------------------------------------------------------------------------
-- Events --
---------------------------------------------------------------------------

-- Activate camera
RegisterNetEvent('camera:Activate')
AddEventHandler('camera:Activate', function()
	camera = not camera
end)

--FUNCTIONS--
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = PlayerPedId()
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,241) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	end
end


---------------------------------------------------------------------------
-- Toggling Mic --
---------------------------------------------------------------------------
RegisterNetEvent("Mic:ToggleMic")
AddEventHandler("Mic:ToggleMic", function()
    if not holdingMic then
        RequestModel(GetHashKey(micModel))
        while not HasModelLoaded(GetHashKey(micModel)) do
            Citizen.Wait(100)
        end
		
		while not HasAnimDictLoaded(micanimDict) do
			RequestAnimDict(micanimDict)
			Citizen.Wait(100)
		end

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local micspawned = CreateObject(GetHashKey(micModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local netid = ObjToNet(micspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(micspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), micanimDict, micanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        mic_net = netid
        holdingMic = true
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(mic_net), 1, 1)
        DeleteEntity(NetToObj(mic_net))
        mic_net = nil
        holdingMic = false
        usingMic = false
    end
end)

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function Breaking(text)
		SetTextColour(255, 255, 255, 255)
		SetTextFont(8)
		SetTextScale(1.2, 1.2)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(0.2, 0.85)
end

function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end

function DisplayNotification(string)
	SetTextComponentFormat("STRING")
	AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()

  IsHandcuffed = not IsHandcuffed;
  local playerPed = PlayerPedId()

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(50)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed, true)

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed, true)
      FreezeEntityPosition(playerPed, false)
    end
  end)
end)

RegisterNetEvent("dp:RecieveMenu") -- For opening the emote menu from another resource.
AddEventHandler("dp:RecieveMenu", function()
    OpenEmoteMenu() 
end)

RegisterNetEvent("neon:on")
AddEventHandler("neon:on", function()	
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(PlayerPedId(), false)
	
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(veh, 1))
	local acikMi0 = IsVehicleNeonLightEnabled(veh, 0)
	local acikMi1 = IsVehicleNeonLightEnabled(veh, 1)
	local acikMi2 = IsVehicleNeonLightEnabled(veh, 2)
	local acikMi3 = IsVehicleNeonLightEnabled(veh, 3)
	
	if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
	
		if distanceToVeh <= 3.5 then
		
			if acikMi0 or acikMi1 or acikMi2 or acikMi3 then

			SetVehicleNeonLightEnabled(veh, 0, false)
			SetVehicleNeonLightEnabled(veh, 1, false)
			SetVehicleNeonLightEnabled(veh, 2, false)
			SetVehicleNeonLightEnabled(veh, 3, false)
			
			else 
			
			SetVehicleNeonLightEnabled(veh, 0, true)
			SetVehicleNeonLightEnabled(veh, 1, true)
			SetVehicleNeonLightEnabled(veh, 2, true)
			SetVehicleNeonLightEnabled(veh, 3, true)
			
			end

		else
			ShowNotification("~r~Aracının Yanında Olmalısın!")
		end
	
	end
end)	

