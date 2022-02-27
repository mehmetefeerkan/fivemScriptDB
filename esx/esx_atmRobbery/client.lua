-------------------------------------
------- Created by Kavl -------
------------------------------------- 

ESX = nil
local timing, isPlayerWhitelisted = math.ceil(1 * 60000), false

local Device
local copsOnline
local RobbingATM = false
local HackingATM = false

local streetName
local _

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
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


-- Refresh police online:
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

-- Core Thread Function:
-- Citizen.CreateThread(function()
-- 	while true do
--         Citizen.Wait(7)	
-- 		local pos = GetEntityCoords(PlayerPedId())
-- 		if not RobbingATM then
-- 			if not HackingATM then
-- 				for k,v in pairs(Config.ATMs) do
-- 					if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) <= 1.5 then
-- 						--DrawText3Ds(v.x,v.y,v.z, "~g~[G]~s~ ~r~ATM Soy~s")
-- 						--if IsControlJustPressed(0, 47) then
-- 							--startRobbingATM()					
-- 							--break;	
-- 						--end
-- 					--end
-- 				end
-- 			end
-- 		end	
-- 	end
-- end)

RegisterCommand("atmsoy", function()
	local pos = GetEntityCoords(PlayerPedId())
	local notif = false
	if not RobbingATM then
	  if not HackingATM then
		for k,v in pairs(Config.ATMs) do
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) <= 1.5 then
			startRobbingATM()

				local ped = PlayerPedId()
				local playerPos = GetEntityCoords(ped)
				local gender = "Bilinmiyor"
                local model = GetEntityModel(ped)
                if (model == GetHashKey("mp_f_freemode_01")) then
                    gender = "Kadın"
                end
                if (model == GetHashKey("mp_m_freemode_01")) then
                    gender = "Erkek"
				end
			TriggerServerEvent(
                        "Brn_dispach:addCall",
                        "10-40",
                        "Atm Soygunu",
                        {{icon = "fa-venus-mars", info = gender}},
                        {playerPos[1], playerPos[2], playerPos[3]},
                        "police",
                        5000,
                        500,
                        1
                    )
					TriggerServerEvent(
                        "Brn_dispach:addCall",
                        "10-40",
                        "Atm Soygunu",
                        {{icon = "fa-venus-mars", info = gender}},
                        {playerPos[1], playerPos[2], playerPos[3]},
                        "sheriff",
                        5000,
                        500,
                        1
                    )
		else
			--
		end
	 end
	end
  end
end)
RegisterCommand("atmsoy_adm", function()
	local pos = GetEntityCoords(PlayerPedId())
	local notif = false
	if not RobbingATM then
	  if not HackingATM then
		for k,v in pairs(Config.ATMs) do
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) <= 1.5 then
			--startRobbingATM()

				local ped = PlayerPedId()
				local playerPos = GetEntityCoords(ped)
				local gender = "Bilinmiyor"
                local model = GetEntityModel(ped)
                if (model == GetHashKey("mp_f_freemode_01")) then
                    gender = "Kadın"
                end
                if (model == GetHashKey("mp_m_freemode_01")) then
                    gender = "Erkek"
				end
			TriggerServerEvent(
                        "Brn_dispach:addCall",
                        "10-40",
                        "Atm Soygunu",
                        {{icon = "fa-venus-mars", info = gender}},
                        {playerPos[1], playerPos[2], playerPos[3]},
                        "police",
                        5000,
                        500,
                        1
                    )
					TriggerServerEvent(
                        "Brn_dispach:addCall",
                        "10-40",
                        "Atm Soygunu",
                        {{icon = "fa-venus-mars", info = gender}},
                        {playerPos[1], playerPos[2], playerPos[3]},
                        "sheriff",
                        5000,
                        500,
                        1
                    )
		else
			--
		end
	 end
	end
  end
end)
-- Starting ATM Robbery:
function startRobbingATM()
	ESX.TriggerServerCallback("esx_atmRobbery:isRobbingPossible", function(cooldownATM)
		if not cooldownATM then
			ESX.TriggerServerCallback('esx_atmRobbery:getOnlinePoliceCount', function(policeCount)
				if policeCount then
					ESX.TriggerServerCallback('esx_atmRobbery:getHackerDevice', function(hackerDevice)
						if hackerDevice then
							RobbingATM = true
							TriggerServerEvent("esx_atmRobbery:CooldownATM")
							FreezeEntityPosition(player,true)
							local player = PlayerPedId()
							local playerPos = GetEntityCoords(player)
								
							-- animation 1:
							local animDict = "random@atmrobberygen@male"
							local animName = "idle_a"
							
							RequestAnimDict(animDict)
							while not HasAnimDictLoaded(animDict) do
								Citizen.Wait(0)
							end
							
							exports["np-taskbar"]:taskBar(10000, "Cihaza bağlanıyorsun")
							TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
							Citizen.Wait(7500)
							TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
							Citizen.Wait(4500)
							TriggerEvent("mhacking:show")
							TriggerEvent("mhacking:start",4,25,hackingEvent)
							HackingATM = true
						else
							RobbingATM = false
						end
					end)
				else
					RobbingATM = false
				end
			end)
		else
			RobbingATM = false
		end
	end)
end

-- Hacking Event:
function hackingEvent(success)
	local player = PlayerPedId()
    FreezeEntityPosition(player,false)
    TriggerEvent('mhacking:hide')
    if success then
		TriggerServerEvent("esx_atmRobbery:success")	
        ESX.ShowNotification("ATM'yi başarıyla hackledin!")
    else
		ESX.ShowNotification("ATM'yi hackleme işleminde başarısız oldun!")
	end
	ClearPedTasks(player)
	ClearPedSecondaryTask(player)	
	RobbingATM = false
	HackingATM = false
end

-- Draw 3D text Function:
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

