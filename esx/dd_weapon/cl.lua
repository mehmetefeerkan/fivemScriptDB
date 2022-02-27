ESX = nil
local hasShot 	  					= false
local GunpowderSaveTime 			= 15 * 60 * 1000 -- krutstänk sparas 15 minuter standard
local cl = inLoops.CreateLoop

local ct = Citizen.CreateThread

ct(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)
 
-------[[no reticle]]-------------
-- local scopedWeapons = 
-- {
--     100416529,  -- WEAPON_SNIPERRIFLE
--     205991906,  -- WEAPON_HEAVYSNIPER
--     3342088282  -- WEAPON_MARKSMANRIFLE
-- }

-- function HashInTable( hash )
--     for k, v in pairs( scopedWeapons ) do 
--         if ( hash == v ) then 
--             return true 
--         end 
--     end 

--     return false 
-- end 

-- function ManageReticle()
--     local ped = GetPlayerPed( -1 )

--     if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
--         local _, hash = GetCurrentPedWeapon( ped, true )

--         if ( GetFollowPedCamViewMode() ~= 4 and IsPlayerFreeAiming() and not HashInTable( hash ) ) then 
--             HideHudComponentThisFrame( 14 )
--         end 
--     end 
-- end 

-- Citizen.CreateThread( function()
--     while true do 
	
-- 		HideHudComponentThisFrame( 14 )		
-- 		Citizen.Wait( 0 )

--     end 
-- end )
---------------[[weapon damage]]------------------------------
CreateThread(function()
    while true do
        Wait(0)
        
        local playerPed = GetPlayerPed(-1)
        local weaponsConfig = Config.WeaponsDamn[GetSelectedPedWeapon(playerPed)]
        
        if weaponsConfig then
            if weaponsConfig.enableCritical then
                SetPedSuffersCriticalHits(playerPed, true)
            end
            N_0x4757f00bc6323cfe(weaponsConfig.model, weaponsConfig.modifier)
        else
            Wait(500)
        end
    end
end)
--------------------[[gsr]]-----------------
RegisterNetEvent('guntest:checkGun')
AddEventHandler('guntest:checkGun', function(source)
	local player, distance = ESX.Game.GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then	
		TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		
		Citizen.Wait(10000)
		
		ClearPedTasksImmediately(PlayerPedId())

		ESX.TriggerServerCallback('guntest:hasPlayerRecentlyFiredAGun', function(hasGunpowder)
			if hasGunpowder then
				exports['dd_core']:notify('inform', 'TARGET IS POSITIVE, ARREST NOW!', 5000)
			else
				exports['dd_core']:notify('inform', 'TARGET IS NEGATIVE, No traces of gunpowder were found.', 5000)

			end
		end, GetPlayerServerId(player))
	else
		exports['dd_core']:notify('inform', 'No person nearby.', 5000)
	end
end)

-- Citizen.CreateThread(function()
-- 	cl(0, gunshot1)
-- end )

-- gunshot1 = function()
		
-- 		if IsPedShooting(PlayerPedId()) then
			-- hasShot = true
			-- TriggerServerEvent('guntest:storePlayerGunpowderStatus')
-- 		end

		-- if hasShot then
		-- 	Citizen.Wait(GunpowderSaveTime)
		-- 	hasShot = false
		-- 	TriggerServerEvent('guntest:removePlayerGunpowderStatus')
		-- end

-- 	end
---------------[[DELETE WEAPON REWARD]]----------------------
local vehWeapons = {
	0x1D073A89, -- ShotGun
	0x83BF0278, -- Carbine
	0x5FC3C11, -- Sniper
}

local hasBeenInPoliceVehicle = false
local alreadyHaveWeapon = {}

RegisterNetEvent('isInPoliceCar')
AddEventHandler('isInPoliceCar', function()
	if(not hasBeenInPoliceVehicle) then
		hasBeenInPoliceVehicle = true
	else
		if(hasBeenInPoliceVehicle) then
			for i,k in pairs(vehWeapons) do
				if(not alreadyHaveWeapon[i]) then
					TriggerServerEvent("PoliceVehicleWeaponDeleter:askDropWeapon",k)
				end
			end
			hasBeenInPoliceVehicle = false
		end
		for i=1,#vehWeapons do
			if(HasPedGotWeapon(PlayerPedId(), vehWeapons[i], false)==1) then
				alreadyHaveWeapon[i] = true
			else
				alreadyHaveWeapon[i] = false
			end
		end
	end
end)

RegisterNetEvent("PoliceVehicleWeaponDeleter:drop")
AddEventHandler("PoliceVehicleWeaponDeleter:drop", function(wea)
	RemoveWeaponFromPed(PlayerPedId(), wea)
end)

Citizen.CreateThread(function()
	cl(1, weapon_delete3)
end)

weapon_delete3 = function()
	id = PlayerId()
	DisablePlayerVehicleRewards(id)	
end

--PISTOL WHIPPING
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
			DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)