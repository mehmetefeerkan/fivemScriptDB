ESX = nil
blip = nil
blips = {}
displayTime = 180
local isInteracting = false
local isDead = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)
------------//911//----------------------------
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/911', 'Submits a 911 call to the Emergency Services!', {
    { name="Report", help="Enter the incident/report here!" }
})
end)
RegisterNetEvent('911:setBlip')
AddEventHandler('911:setBlip', function(name, x, y, z)
    blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, 66)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('911 Call - ' .. name)
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
    Wait(displayTime * 1000)
    for i, blip in pairs(blips) do 
        RemoveBlip(blip)
    end
end)
RegisterNetEvent('911:sendtoteam')
AddEventHandler('911:sendtoteam', function(name, location, msg, x, y, z)
    if onduty then 
        TriggerServerEvent('911:sendmsg', name, location, msg, x, y, z)
    end
end)
-- RegisterCommand('911', function(source, args)
--     local name = GetPlayerName(PlayerId())
--     local ped = GetPlayerPed(PlayerId())
--     local x, y, z = table.unpack(GetEntityCoords(ped, true))
--     local street = GetStreetNameAtCoord(x, y, z)
--     local location = GetStreetNameFromHashKey(street)
--     local msg = table.concat(args, ' ')
-- 	if not IsPedDeadOrDying(ped) and isDead then
-- 		exports['dd_core']:notify('error', 'You cannot use 911 at the moment!.')
-- 		else
--     		if args[1] == nil then
--         		TriggerEvent('chatMessage', '^5911', {255,255,255}, ' ^7Please enter your ^1report/issue.')
--     		else
--         		TriggerServerEvent('911', location, msg, x, y, z, name)
--     		end
-- 	end
-- end)
--- POINT ---
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) and not isDead then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) and not isDead then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) and not isDead then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0
                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
            end
        end
    end
end)
--------------[[CROUCH]]------------------
-- local crouched = false
-- crouchKey = 36

-- Citizen.CreateThread( function()
-- 	while true do 
-- 		Citizen.Wait( 1 )
-- 		local ped = GetPlayerPed( -1 )
-- 		if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
-- 			DisableControlAction( 0, crouchKey, true ) 
-- 			if ( not IsPauseMenuActive() ) then 
-- 				if ( IsDisabledControlJustPressed( 0, crouchKey ) ) then 
-- 					RequestAnimSet( "move_ped_crouched" )
-- 					RequestAnimSet("MOVE_M@TOUGH_GUY@")
					
-- 					while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
-- 						Citizen.Wait( 100 )
-- 					end 
-- 					while ( not HasAnimSetLoaded( "MOVE_M@TOUGH_GUY@" ) ) do 
-- 						Citizen.Wait( 100 )
-- 					end 		
-- 					if ( crouched ) then 
-- 						ResetPedMovementClipset( ped )
-- 						ResetPedStrafeClipset(ped)
-- 						SetPedMovementClipset( ped,"MOVE_M@TOUGH_GUY@", 0.5)
-- 						crouched = false 
-- 					elseif ( not crouched ) then
-- 						SetPedMovementClipset( ped, "move_ped_crouched", 0.55 )
-- 						SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
-- 						crouched = true 
-- 					end 
-- 				end
-- 			end
-- 		else
-- 			crouched = false
-- 		end
-- 	end
-- end)
-- local crouched = true
-- local proned = false
-- crouchKey = 36
-- proneKey = 26
-- Citizen.CreateThread( function()
-- 	inLoops.CreateLoop(15, crouching)
-- end)

-- crouching = function()
--     local ped = GetPlayerPed( -1 )
--     if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) and not isDead then 
--         ProneMovement()
--         DisableControlAction( 0, crouchKey, true ) 
--         if ( not IsPauseMenuActive() ) then 
--             if ( IsDisabledControlJustPressed( 0, crouchKey ) and not proned ) then 
--                 RequestAnimSet( "move_ped_crouched" )
--                 RequestAnimSet("MOVE_M@TOUGH_GUY@")
                
--                 while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
--                     Citizen.Wait( 100 )
--                 end 
--                 while ( not HasAnimSetLoaded( "MOVE_M@TOUGH_GUY@" ) ) do 
--                     Citizen.Wait( 100 )
--                 end 		
--                 if ( crouched and not proned ) then 
--                     ResetPedMovementClipset( ped )
--                     ResetPedStrafeClipset(ped)
--                     SetPedMovementClipset( ped,"MOVE_M@TOUGH_GUY@", 0.5)
--                     crouched = false 
--                 elseif ( not crouched and not proned ) then
--                     SetPedMovementClipset( ped, "move_ped_crouched", 0.55 )
--                     SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
--                     crouched = true 
--                 end 
--             elseif ( IsDisabledControlJustPressed(0, proneKey) and not isDead and not crouched and not IsPedInAnyVehicle(ped, true) and not IsPedFalling(ped) and not IsPedDiving(ped) and not IsPedInCover(ped, false) and not IsPedInParachuteFreeFall(ped) and (GetPedParachuteState(ped) == 0 or GetPedParachuteState(ped) == -1) ) then
--                 if proned then
--                     ClearPedTasksImmediately(ped)
--                     proned = false
--                 elseif not proned then
--                     RequestAnimSet( "move_crawl" )
--                     while ( not HasAnimSetLoaded( "move_crawl" ) ) do 
--                         Citizen.Wait( 100 )
--                     end 
--                     ClearPedTasksImmediately(ped)
--                     proned = true
--                     if IsPedSprinting(ped) or IsPedRunning(ped) or GetEntitySpeed(ped) > 5 then
--                         TaskPlayAnim(ped, "move_jump", "dive_start_run", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
--                         Citizen.Wait(1000)
--                     end
--                     SetProned()
--                 end
--             end
--         end
--     else
--         proned = false
--         crouched = false
--     end
-- end
-- function SetProned()
-- 	ped = PlayerPedId()
-- 	ClearPedTasksImmediately(ped)
-- 	TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 0.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
-- end


-- function ProneMovement()
-- 	if proned then
-- 		ped = PlayerPedId()
-- 		DisableControlAction(0, 23)
-- 		if IsControlPressed(0, 32) or IsControlPressed(0, 33) then
-- 			DisablePlayerFiring(ped, true)
-- 		 elseif IsControlJustReleased(0, 32) or IsControlJustReleased(0, 33) then
-- 		 	DisablePlayerFiring(ped, false)
-- 		 end
-- 		if IsControlJustPressed(0, 32) and not movefwd then
-- 			movefwd = true
-- 		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
-- 		elseif IsControlJustReleased(0, 32) and movefwd then
-- 		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
-- 			movefwd = false
-- 		end		
-- 		if IsControlJustPressed(0, 33) and not movebwd then
-- 			movebwd = true
-- 		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_bwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
-- 		elseif IsControlJustReleased(0, 33) and movebwd then 
-- 		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_bwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
-- 		    movebwd = false
-- 		end
-- 		if IsControlPressed(0, 34) then
-- 			SetEntityHeading(ped, GetEntityHeading(ped)+2.0 )
-- 		elseif IsControlPressed(0, 35) then
-- 			SetEntityHeading(ped, GetEntityHeading(ped)-2.0 )
-- 		end
-- 	end
-- end
--NONPCDROP
function SetWeaponDrops()
	local handle, ped = FindFirstPed()
	local finished = false

	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished

	EndFindPed(handle)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		SetWeaponDrops()
	end
end)

---------[[anti falldown]]-----------
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(5000)
--         local playerCoords = GetEntityCoords(PlayerPedId())

--         if playerCoords.z < -50 then
--             local playerCoordsUP = GetEntityCoords(PlayerPedId())
--             playerCoordsUP = vector3(playerCoordsUP.x, playerCoordsUP.y, playerCoordsUP.z + 200)

--             local unusedBool, nearZ = GetGroundZFor_3dCoord(playerCoordsUP.x, playerCoordsUP.y, 99999.0, 1)

--             nearZ = nearZ + 2.0

--             playerCoordsUP = vector3(playerCoordsUP.x, playerCoordsUP.y, nearZ)

--             SetEntityCoords(PlayerPedId(), playerCoordsUP.x, playerCoordsUP.y, nearZ)
--         end

--     end
-- end)
