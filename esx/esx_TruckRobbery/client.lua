--------------------------------
------- Created by Hamza -------
-------------------------------- 

ESX = nil

local PlayerData = nil
local CurrentEventNum = nil
local timing, isPlayerWhitelisted = math.ceil(1 * 60000), false

local ArmoredTruckVeh
local itemC4prop
local missionInProgress = false
local missionCompleted = false
local TruckIsExploded = false
local TruckIsDemolished = false
local KillGuardsText = false

local streetName
local _
local playerGender

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx_TruckRobbery:outlawNotify')
AddEventHandler('esx_TruckRobbery:outlawNotify', function(alert)
	if isPlayerWhitelisted then
		TriggerEvent('police:truckRobbery')
	end
end)

function refreshPlayerWhitelisted()	
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	if Config.PoliceDatabaseName == ESX.PlayerData.job.name then
		return true
	end

	return false
end

-- // Function for 3D text // --
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

-- Blip on Map for Mission Location
Citizen.CreateThread(function()
	if Config.EnableMapBlip == true then
	  for k,v in ipairs(Config.MissionSpot)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, Config.BlipSprite)
		SetBlipDisplay(blip, Config.BlipDisplay)
		SetBlipScale  (blip, Config.BlipScale)
		SetBlipColour (blip, Config.BlipColour)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.BlipNameOnMap)
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

-- Core Thread Function
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in pairs(Config.MissionSpot) do
			local distance = Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z)
			if distance <= 3.0 then
				DrawMarker(Config.MissionMarker, v.x, v.y, v.z-0.975, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MissionMarkerScale.x, Config.MissionMarkerScale.y, Config.MissionMarkerScale.z, Config.MissionMarkerColor.r,Config.MissionMarkerColor.g,Config.MissionMarkerColor.b,Config.MissionMarkerColor.a, false, true, 2, true, false, false, false)					
			else
				Citizen.Wait(1000)
			end	
			if distance <= 1.0 then
				DrawText3Ds(v.x, v.y, v.z, Config.Draw3DText)
				if IsControlJustPressed(0, Config.KeyToStartMission) then
					TriggerServerEvent("esx_TruckRobbery:missionAccepted")
					Citizen.Wait(500)
				end
			end
		end		
	end
end)

RegisterNetEvent('esx_TruckRobbery:TruckRobberyInProgress')
AddEventHandler('esx_TruckRobbery:TruckRobberyInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.PoliceBlipShow then
		local alpha = Config.PoliceBlipAlpha
		local policeNotifyBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.PoliceBlipRadius)

		SetBlipHighDetail(policeNotifyBlip, true)
		SetBlipColour(policeNotifyBlip, Config.PoliceBlipColor)
		SetBlipAlpha(policeNotifyBlip, alpha)
		SetBlipAsShortRange(policeNotifyBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceBlipTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(policeNotifyBlip, alpha)

			if alpha == 0 then
				RemoveBlip(policeNotifyBlip)
				return
			end
		end
	end
end)

RegisterNetEvent("esx_TruckRobbery:HackingMiniGame")
AddEventHandler("esx_TruckRobbery:HackingMiniGame",function()
	toggleHackGame()
end)

function toggleHackGame()
	local player = PlayerPedId()
	local anim_lib = "anim@heists@ornate_bank@hack"
		
	RequestAnimDict(anim_lib)
	while not HasAnimDictLoaded(anim_lib) do
		Citizen.Wait(0)
	end
	Citizen.Wait(100)
	if Config.EnableAnimationB4Hacking == true then
		TaskPlayAnim(player,anim_lib,"hack_loop",3.0,1.0,-1,30,1.0,0,0)
		Citizen.Wait(100)
	end
	FreezeEntityPosition(player,true)
	
	exports['progressBars']:startUI((Config.RetrieveMissionTimer * 1000), Config.Progress1)
	Citizen.Wait((Config.RetrieveMissionTimer * 1000))	
		
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",Config.HackingBlocks,Config.HackingSeconds,AtmHackSuccess) 
	FreezeEntityPosition(player,true)
end

function AtmHackSuccess(success)
	local player = PlayerPedId()
    FreezeEntityPosition(player,false)
    TriggerEvent('mhacking:hide')
    if success then
		ESX.TriggerServerCallback("esx_TruckRobbery:StartMissionNow",function()	end)
    else
		ESX.ShowNotification(Config.HackingFailed)
		ClearPedTasks(player)
		ClearPedSecondaryTask(player)
	end
	ClearPedTasks(player)
	ClearPedSecondaryTask(player)
end

-- Making sure that players don't get the same mission at the same time
RegisterNetEvent("esx_TruckRobbery:startMission")
AddEventHandler("esx_TruckRobbery:startMission",function(spot)
	local num = math.random(1,#Config.ArmoredTruck)
	local numy = 0
	while Config.ArmoredTruck[num].InUse and numy < 100 do
		numy = numy+1
		num = math.random(1,#Config.ArmoredTruck)
	end
	if numy == 100 then
		ESX.ShowNotification(Config.NoMissionsAvailable)
	else
		CurrentEventNum = num
		TriggerEvent("esx_TruckRobbery:startTheEvent",num)
		PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
		ESX.ShowNotification(Config.TruckMarkedOnMap)
	end
end)

-- Core Mission Part
RegisterNetEvent('esx_TruckRobbery:startTheEvent')
AddEventHandler('esx_TruckRobbery:startTheEvent', function(num)
	
	local loc = Config.ArmoredTruck[num]
	Config.ArmoredTruck[num].InUse = true
	local playerped = GetPlayerPed(-1)
	
	TriggerServerEvent("esx_TruckRobbery:syncMissionData",Config.ArmoredTruck)

	RequestModel(GetHashKey('stockade'))
	while not HasModelLoaded(GetHashKey('stockade')) do
		Citizen.Wait(0)
	end

	ClearAreaOfVehicles(loc.Location.x, loc.Location.y, loc.Location.z, 15.0, false, false, false, false, false) 	
	ArmoredTruckVeh = CreateVehicle(GetHashKey('stockade'), loc.Location.x, loc.Location.y, loc.Location.z, -2.436,  996.786, 25.1887, true, true)
	SetEntityAsMissionEntity(ArmoredTruckVeh)
	SetEntityHeading(ArmoredTruckVeh, 52.00)
	
	local taken = false
	local blip = CreateMissionBlip(loc.Location)
	
	RequestModel("s_m_m_security_01")
	while not HasModelLoaded("s_m_m_security_01") do
		Wait(10)
	end
	
	local TruckDriver = CreatePedInsideVehicle(ArmoredTruckVeh, 1, "s_m_m_security_01", -1, true, true)
	local TruckPassenger = CreatePedInsideVehicle(ArmoredTruckVeh, 1, "s_m_m_security_01", 0, true, true)
	
	-- Natives for Truck Driver & Passenger
	SetPedFleeAttributes(TruckDriver, 0, 0)
	SetPedFleeAttributes(TruckPassenger, 0, 0)
	SetPedCombatAttributes(TruckDriver, 46, 1)
	SetPedCombatAttributes(TruckPassenger, 46, 1)
	SetPedCombatAbility(TruckDriver, 100)
	SetPedCombatAbility(TruckPassenger, 100)
	SetPedCombatMovement(TruckDriver, 2)
	SetPedCombatMovement(TruckPassenger, 2)
	SetPedCombatRange(TruckDriver, 2)
	SetPedCombatRange(TruckPassenger, 2)
	SetPedKeepTask(TruckDriver, true)
	SetPedKeepTask(TruckPassenger, true)
	TaskEnterVehicle(TruckPassenger,ArmoredTruckVeh,-1,0,1.0,1)
	GiveWeaponToPed(TruckDriver, GetHashKey(Config.DriverWeapon),250,false,true)
	GiveWeaponToPed(TruckPassenger, GetHashKey(Config.PassengerWeapon),250,false,true)
	SetPedAsCop(TruckDriver, true)
	SetPedAsCop(TruckPassenger, true)
	SetPedDropsWeaponsWhenDead(TruckDriver, false)
	SetPedDropsWeaponsWhenDead(TruckPassenger, false)
	TaskVehicleDriveWander(TruckDriver, ArmoredTruckVeh, 80.0, 443)
	
	missionInProgress = true
	
	while not taken do
		Citizen.Wait(3)
		
		if missionInProgress == true then
			local pos = GetEntityCoords(GetPlayerPed(-1), false)
			local TruckPos = GetEntityCoords(ArmoredTruckVeh) 
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, TruckPos.x, TruckPos.y, TruckPos.z, false)

			if distance <= 30.0  then
				if KillGuardsText == false then
					ESX.ShowNotification(Config.KillTheGuards)
					KillGuardsText = true
				end
			end
			
			if distance <= 5 and TruckIsDemolished == false then
				ESX.ShowHelpNotification(Config.OpenTruckDoor)
				if IsControlJustPressed(1, Config.KeyToOpenTruckDoor) then 
					BlowTheTruckDoor()
					Citizen.Wait(500)
				end
			end
		end
		
		if TruckIsExploded == true then
			local pos = GetEntityCoords(GetPlayerPed(-1), false)
			local TruckPos = GetEntityCoords(ArmoredTruckVeh) 
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, TruckPos.x, TruckPos.y, TruckPos.z, false)

			if distance > 45.0 then
			Citizen.Wait(500)
			end
			
			if distance <= 4.5 then
				ESX.ShowHelpNotification(Config.RobFromTruck)
				if IsControlJustPressed(0, Config.KeyToRobFromTruck ) then 
					TruckIsExploded = false
					RobbingTheMoney()
					Citizen.Wait(500)
				end
			end
		end
		
		if missionCompleted == true then
			ESX.ShowNotification(Config.MissionCompleted)
			Config.ArmoredTruck[num].InUse = false
			RemoveBlip(blip)
			TriggerServerEvent("esx_TruckRobbery:syncMissionData",Config.ArmoredTruck)
			taken = true
			missionInProgress = false
			missionCompleted = false
			TruckIsExploded = false
			TruckIsDemolished = false
			KillGuardsText = false
			break
		end
		
	end
end)

-- Function for blowing the door on the truck
function BlowTheTruckDoor()
	if IsVehicleStopped(ArmoredTruckVeh) then
		if (IsVehicleSeatFree(ArmoredTruckVeh, -1) and IsVehicleSeatFree(ArmoredTruckVeh, 0) and IsVehicleSeatFree(ArmoredTruckVeh, 1)) then
			TruckIsDemolished = true
			
			RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
			while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
				Citizen.Wait(50)
			end
			
			if Config.PoliceNotfiyEnabled == true then
				TriggerServerEvent('esx_TruckRobbery:TruckRobberyInProgress',GetEntityCoords(PlayerPedId()),streetName)
			end
			
			local playerPed = GetPlayerPed(-1)
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			itemC4prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(itemC4prop, playerPed, GetPedBoneIndex(playerPed, 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
			SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"),true)
			Citizen.Wait(700)
			FreezeEntityPosition(playerPed, true)
			TaskPlayAnim(playerPed, 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
			exports['progressBars']:startUI(5500, Config.Progress2)
			Citizen.Wait(5500)
			
			ClearPedTasks(playerPed)
			DetachEntity(itemC4prop)
			AttachEntityToEntity(itemC4prop, ArmoredTruckVeh, GetEntityBoneIndexByName(ArmoredTruckVeh, 'door_pside_r'), -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
			FreezeEntityPosition(playerPed, false)
			Citizen.Wait(500)
			
			exports['progressBars']:startUI((Config.DetonateTimer * 1000), Config.Progress3)	
			Citizen.Wait((Config.DetonateTimer * 1000))
			
			local TruckPos = GetEntityCoords(ArmoredTruckVeh)
			SetVehicleDoorBroken(ArmoredTruckVeh, 2, false)
			SetVehicleDoorBroken(ArmoredTruckVeh, 3, false)
			AddExplosion(TruckPos.x,TruckPos.y,TruckPos.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
			ApplyForceToEntity(ArmoredTruckVeh, 0, TruckPos.x,TruckPos.y,TruckPos.z, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
			TruckIsExploded = true
			ESX.ShowNotification(Config.BeginToRobTruck)
		else
			ESX.ShowNotification(Config.GuardsNotKilledYet)
		end
	else
		ESX.ShowNotification(Config.TruckIsNotStopped)
	end
end

-- Function for robbing the money in the truck
function RobbingTheMoney()
	
	RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
	while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
		Citizen.Wait(50)
	end
	
	local playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(playerPed)
	
	moneyBag = CreateObject(GetHashKey('prop_cs_heist_bag_02'),pos.x, pos.y,pos.z, true, true, true)
	AttachEntityToEntity(moneyBag, playerPed, GetPedBoneIndex(playerPed, 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(playerPed, true)
	
	exports['progressBars']:startUI((Config.RobTruckTimer * 1000), Config.Progress4)
	Citizen.Wait((Config.RobTruckTimer * 1000))
	
	DeleteEntity(moneyBag)
	ClearPedTasks(playerPed)
	FreezeEntityPosition(playerPed, false)
	
	if Config.EnablePlayerMoneyBag == true then
		SetPedComponentVariation(playerPed, 5, 45, 0, 2)
	end
	
	TriggerServerEvent("esx_TruckRobbery:missionComplete")
	
	TruckIsExploded = false
	TruckIsDemolished = false
	missionInProgress = false
	Citizen.Wait(1000)
	missionCompleted = true
end

-- Thread for Police Notify
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		streetName,_ = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

-- Blip for the Armored Truck on the move
function CreateMissionBlip(location)
	local blip = AddBlipForEntity(ArmoredTruckVeh)
	SetBlipSprite(blip, Config.BlipSpriteTruck)
	SetBlipColour(blip, Config.BlipColourTruck)
	AddTextEntry('MYBLIP', Config.BlipNameForTruck)
	BeginTextCommandSetBlipName('MYBLIP')
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
	SetBlipScale(blip, Config.BlipScaleTruck) 
	SetBlipAsShortRange(blip, true)
	return blip
end

-- Sync mission data
RegisterNetEvent("esx_TruckRobbery:syncMissionData")
AddEventHandler("esx_TruckRobbery:syncMissionData",function(data)
	Config.ArmoredTruck = data
end)
