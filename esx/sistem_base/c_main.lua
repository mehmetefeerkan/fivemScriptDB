ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

--ID GOSTERME

RegisterCommand("id", function(source, raw, args)
    -- chatMessage("^1ID'niz: ^0" .. GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())))
    TriggerEvent('notification', "ID'niz: " .. GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())), 1)
end, false)

function chatMessage(msg)
	TriggerEvent("chatMessage", "", {255, 255, 255}, msg)
end

--YARALI YURUYUS

local hurt = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(PlayerPedId()) <= 139 then
            setHurt()
        elseif hurt and GetEntityHealth(PlayerPedId()) > 140 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end

--TOPLU DÖNGÜLER

local ragdoled = false
local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end
local canHandsUp = true

AddEventHandler('handsup:toggle', function(param)
	canHandsUp = param
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("yan", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)

Citizen.CreateThread(function()
    local handsup = false
    while true do      
        -- POLİS ARAÇLARINDAN SİLAH ÇIKMASINI ENGELLEME
        Citizen.Wait(0)
        id = PlayerId()
        DisablePlayerVehicleRewards(id)      
        -- ELİNDE SİLAH VARKEN TUŞ ENGELLEME
        local ped = PlayerPedId()
        DisableControlAction(0, 140, true) 
            if IsPedArmed(ped, 6) then
            	DisableControlAction(1, 288, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            end
        -- --R YUMRUK ENGEL
        -- Citizen.CreateThread(function()
        --     while true do
        --         Citizen.Wait(5) -- A Short Daily of 5 MS
        --         DisableControlAction(0, 140, true) -- Disable the Light Dmg Contr ol
        --     end
        -- end)
        -- Q + E BAYILMA
        if IsControlPressed(0, 44) and IsControlPressed(0, 46) then
            ragdoled = true
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                ragdoled = false
                end
            end
                 
        if ragdoled == true then
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)

            if IsControlJustPressed(0, 105) then
                ragdoled = false
            end
        end
        -- SİLAH DAMAGE AYARLARI
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.01)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNOWBALL"), 0.01)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.2)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"), 0.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"), 2.0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_POOLCUE"), 0.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"), 0.0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MUSKET"), 0.01)
        --ARAÇTA YAN KOLTUĞA GEÇMEYİ ENGELLEME
        if IsPedInAnyVehicle(PlayerPedId(), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId() then
				if GetIsTaskActive(PlayerPedId(), 165) then
					SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
				end
			end
        end
        --X İLE EL KALDIRMA
        if canHandsUp then
			if IsControlJustReleased(0, 73) then
				local playerPed = PlayerPedId()
				DisableControlAction(0,21,true) -- disable sprint
				DisableControlAction(0,24,true) -- disable attack
				DisableControlAction(0,25,true) -- disable aim
				DisableControlAction(0,47,true) -- disable weapon
				DisableControlAction(0,58,true) -- disable weapon
				DisableControlAction(0,263,true) -- disable melee
				DisableControlAction(0,264,true) -- disable melee
				DisableControlAction(0,257,true) -- disable melee
				DisableControlAction(0,140,true) -- disable melee
				DisableControlAction(0,141,true) -- disable melee
				DisableControlAction(0,142,true) -- disable melee
				DisableControlAction(0,143,true) -- disable melee
				RequestAnimDict('random@mugging3')
				while not HasAnimDictLoaded('random@mugging3') do
					Citizen.Wait(100)
				end

				if handsup then
					handsup = false
					ClearPedSecondaryTask(playerPed)
					TriggerServerEvent('esx_thief:update', handsup)
				else
					handsup = true
					TaskPlayAnim(playerPed, 'random@mugging3', 'handsup_standing_base', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
					TriggerServerEvent('esx_thief:update', handsup)
				end
			end
        end
        -- ANTI COMBAT MODE
        if not GetPedConfigFlag(ped,78,1) then 
        SetPedUsingActionMode(PlayerPedId(), false, -1, 0)
        end
    end
end)


--SİLAH SEKME

local recoils = {
	[416676503] = 0.34,
	[-957766203] = 0.22,
	[970310034] = 0.17,  
}

Citizen.CreateThread(function()
	while true do 
    Citizen.Wait(0)
        local ply = PlayerPedId()
        -- SetPedSuffersCriticalHits(ply, false)

        if IsPedArmed(ply, 6) then
			DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        elseif IsPedArmed(ply, 1) then
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.1)   
        else
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.35)
		end
		
        if IsPedShooting(ply) then      
            local _,wep = GetCurrentPedWeapon(ply)
            local _,cAmmo = GetAmmoInClip(ply, wep)
			
		--	if hasar[wep] and hasar[wep] ~= 0 then
              --  yenihasar = ((hasar[wep]/100)*25)/10
               -- print(yenihasar)
			--	N_0x4757f00bc6323cfe(wep, yenihasar)
			--end
			
            local GamePlayCam = GetFollowPedCamViewMode()
            local Vehicled = IsPedInAnyVehicle(ply, false)
            local MovementSpeed = math.ceil(GetEntitySpeed(ply))

            if MovementSpeed > 69 then
                MovementSpeed = 69
            end
            Citizen.Wait(50)
            local _,wep = GetCurrentPedWeapon(ply)
            if wep ~= 126349499 then
                local group = GetWeapontypeGroup(wep)
                local p = GetGameplayCamRelativePitch()
                local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

                local recoil = math.random(100,140+MovementSpeed)/100
                local rifle = false

                if group == 970310034 then
                    rifle = true
                end

                if cameraDistance < 5.3 then
                    cameraDistance = 1.5
                else
                    if cameraDistance < 8.0 then
                        cameraDistance = 4.0
                    else
                        cameraDistance = 7.0
                    end
                end

                if Vehicled then
                    recoil = recoil + (recoil * cameraDistance)
                else
                    recoil = recoil * 0.2
                end

                if GamePlayCam == 4 then
                    recoil = recoil * 0.2
                    if rifle then
                        recoil = recoil * 0.4
                    end
                end

                if rifle then
                    recoil = recoil * 0.4
                end

                local rightleft = math.random(4)
                local h = GetGameplayCamRelativeHeading()
                local hf = math.random(10,40+MovementSpeed)/100

                if Vehicled then
                    hf = hf * 2.0
                end

                if rightleft == 1 then
                    SetGameplayCamRelativeHeading(h+hf)
                elseif rightleft == 2 then
                    SetGameplayCamRelativeHeading(h-hf)
                end 
            
                local set = p+recoil

                SetGameplayCamRelativePitch(set,0.8)   
            end 	       	
        end
        
	end
end)

-- ZAR ATMA


RegisterCommand('zarat', function(source, args, rawCommand) 
    local number = 0
    number = math.random(1,12)
     

    loadAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1500)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 2, "dice", 0.5)
    ClearPedTasks(PlayerPedId())
    Citizen.Wait(500)
    TriggerServerEvent('3dme:shareDisplayDo', 'Zarın üzerinde ' .. number ..' yazıyor')
end)

RegisterCommand('tombala', function(source, args, rawCommand) 
    local number = 0
    number = math.random(1,50)
     

    loadAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(500)
    ClearPedSecondaryTask(PlayerPedId())
    Citizen.Wait(500)
    TriggerServerEvent('3dme:shareDisplayDo', 'Tombalanın üzerinde ' .. number .. ' yazıyor')
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end

--SIRTTA SİLAH

local SETTINGS = {
    back_bone = 24816,
    x = 0.075,
    y = -0.15,
    z = -0.02,
    x_rotation = 0.0,
    y_rotation = 165.0,
    z_rotation = 0.0,
    compatable_weapon_hashes = {
      -- melee:
      --["prop_golf_iron_01"] = 1141786504, -- positioning still needs work
      ["w_me_bat"] = -1786099057,
      -- assault rifles:
      ["w_ar_carbinerifle"] = -2084633992,
      ["w_ar_carbineriflemk2"] = GetHashKey("WEAPON_CARBINERIFLE_Mk2"),
      ["w_ar_assaultrifle"] = -1074790547,
      ["w_ar_specialcarbine"] = -1063057011,
      ["w_ar_bullpuprifle"] = 2132975508,
      ["w_ar_advancedrifle"] = -1357824103,
      -- sub machine guns:
      ["w_sb_microsmg"] = 324215364,
      ["w_sb_assaultsmg"] = -270015777,
      ["w_sb_smg"] = 736523883,
      ["w_sb_combatpdw"] = 171789620,
      ["w_sb_smgmk2"] = GetHashKey("WEAPON_SMGMk2"),
      ["w_sb_gusenberg"] = 1627465347,
      -- sniper rifles:
      ["w_sr_sniperrifle"] = 100416529,
      -- shotguns:
      ["w_sg_assaultshotgun"] = -494615257,
      ["w_sg_bullpupshotgun"] = -1654528753,
      ["w_sg_pumpshotgun"] = 487013001,
      ["w_ar_musket"] = -1466123874,
      ["w_sg_heavyshotgun"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
      -- ["w_sg_sawnoff"] = 2017895192 don't show, maybe too small?
      -- launchers:
      ["w_lr_firework"] = 2138347493
    }
}

local attached_weapons = {}

Citizen.CreateThread(function()
  while true do
      local me = PlayerPedId()
      ---------------------------------------
      -- attach if player has large weapon --
      ---------------------------------------
      for wep_name, wep_hash in pairs(SETTINGS.compatable_weapon_hashes) do
          if HasPedGotWeapon(me, wep_hash, false) then
              if not attached_weapons[wep_name] then
                  AttachWeapon(wep_name, wep_hash, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation, isMeleeWeapon(wep_name))
              end
          end
      end
      --------------------------------------------
      -- remove from back if equipped / dropped --
      --------------------------------------------
      for name, attached_object in pairs(attached_weapons) do
          -- equipped? delete it from back:
          if GetSelectedPedWeapon(me) ==  attached_object.hash or not HasPedGotWeapon(me, attached_object.hash, false) then -- equipped or not in weapon wheel
            DeleteObject(attached_object.handle)
            attached_weapons[name] = nil
          end
      end
  Wait(0)
  end
end)

function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR, isMelee)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(100)
	end

  attached_weapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
  }

  if isMelee then x = 0.11 y = -0.14 z = 0.0 xR = -75.0 yR = 185.0 zR = 92.0 end -- reposition for melee items
  if attachModel == "prop_ld_jerrycan_01" then x = x + 0.3 end
	AttachEntityToEntity(attached_weapons[attachModel].handle, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

function isMeleeWeapon(wep_name)
    if wep_name == "prop_golf_iron_01" then
        return true
    elseif wep_name == "w_me_bat" then
        return true
    elseif wep_name == "prop_ld_jerrycan_01" then
      return true
    else
        return false
    end
end

--GİYİNME

RegisterCommand('giyin', function(source, args, skin)

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
	TriggerEvent('skinchanger:loadSkin', skin)
	end)

end, false)

--DRIFT SMOKE

local _SIZE = 0.2
local _DENS = 10
local _BURNOUT_SIZE = 1.5
local _BIND_KEY = 132 -- Default: RIGHT CTRL
local _SMOKE_ON = false
local bone_list = {"wheel_lr","wheel_rr"}

Citizen.CreateThread(function()
    base = "scr_recartheft"
    base2 = "core"
    Request(base)
    Request(base2)
    while true do 
        sleep = 2000
        ped = PlayerPedId()
        car = GetVehiclePedIsUsing(ped)
        ang,speed = angle(car)
        if _SMOKE_ON then
            if IsPedInAnyVehicle(ped, false) then
                sleep = 5
                if speed >= 3.0 and ang ~= 0 then
                    DriftSmoke(base,"scr_wheel_burnout", car, _DENS, _SIZE)
                elseif speed < 1.0 and IsVehicleInBurnout(car) then
                    DriftSmoke(base2 ,"exp_grd_bzgas_smoke", car, 3, _BURNOUT_SIZE)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterCommand('dsmokeac', function()
    ped = PlayerPedId()
    car = GetVehiclePedIsUsing(ped)
    ang,speed = angle(car)
    if IsPedInVehicle(ped, car) then
    _SMOKE_ON = true
    -- exports['mythic_notify']:SendAlert('inform', 'Drift smoke aktif')
    TriggerEvent('notification', 'Drift smoke açıldı', 1)
    end
end)

RegisterCommand('dsmokekapat', function()
    ped = PlayerPedId()
    car = GetVehiclePedIsUsing(ped)
    ang,speed = angle(car)
    if IsPedInVehicle(ped, car) then
    _SMOKE_ON = false
    TriggerEvent('notification', 'Drift smoke kapatıldı', 2)
    end
end)

function Request(name)
    RequestNamedPtfxAsset(name)
    while not HasNamedPtfxAssetLoaded(name) do
        Wait(1)
    end
end

function DriftSmoke(base, sub, car, dens, size)
    all_part = {}
    for i = 0,dens do
        UseParticleFxAssetNextCall(base)
        W1 = StartParticleFxLoopedOnEntityBone(sub, car, 0.05, 0, 0, 0, 0, 0, GetEntityBoneIndexByName(car, bone_list[1]), size, 0, 0, 0)
        UseParticleFxAssetNextCall(base)
        W2 = StartParticleFxLoopedOnEntityBone(sub, car, 0.05, 0, 0, 0, 0, 0, GetEntityBoneIndexByName(car, bone_list[2]), size, 0, 0, 0)
        table.insert(all_part, 1, W1)
        table.insert(all_part, 2, W2)
    end
    Citizen.Wait(1000)
    for _,W1 in pairs(all_part) do
        StopParticleFxLooped(W1, true)
    end
end

function angle(veh)
    if not veh then return false end
    local vx,vy,vz = table.unpack(GetEntityVelocity(veh))
    local modV = math.sqrt(vx*vx + vy*vy)
    local rx,ry,rz = table.unpack(GetEntityRotation(veh,0))
    local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))
    if GetEntitySpeed(veh)* 3.6 < 5 or GetVehicleCurrentGear(veh) == 0 then return 0,modV end --speed over 30 km/h
    local cosX = (sn*vx + cs*vy)/modV
    if cosX > 0.966 or cosX < 0 then return 0,modV end
    return math.deg(math.acos(cosX))*0.5, modV
end


-- PARMAKLA GÖSTERME

local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = PlayerPedId()
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
    local ped = PlayerPedId()
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
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
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
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
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
                local ped = PlayerPedId()
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

-- CTRL İLE EĞİLME

local crouched = false

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )

        local ped = PlayerPedId()

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

            if ( not IsPauseMenuActive() ) then 
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        Citizen.Wait( 100 )
                    end 

                    if ( crouched == true ) then 
                        ResetPedMovementClipset( ped, 0 )
                        crouched = false 
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end )

--TASER BAYILTMA SÜRESİ

--[[
local tiempo = 15000 -- in miliseconds >> 1000 ms = 1s

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedBeingStunned(PlayerPedId()) then
		SetPedMinGroundTimeForStungun(PlayerPedId(), tiempo)
		end
	end
end)
--]]


-- DISCORDRICH


-- Citizen.CreateThread(function()
-- 	while true do
-- 		SetDiscordAppId(756599478756180159) -- AppId rastgele oluşturulmuştur. (siz kendiniz discord developers'dan alıp koymanız gerekmektedir)
-- 		SetDiscordRichPresenceAsset('logo')
--         SetDiscordRichPresenceAssetText('[TR]  Roleplay') 
--         SetDiscordRichPresenceAssetSmall('logo')
--         SetDiscordRichPresenceAssetSmallText('discord.gg/Asgard')
-- 		Citizen.Wait(60)
-- 	end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1600)
--         players = {}
--         for i = 0, 256 do
--             if NetworkIsPlayerActive( i ) then
--                 table.insert( players, i )
--             end
--         end
--         SetRichPresence(" discord.gg/Asgard")
--     end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
-- 		if VehName == "NULL" then VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) end
-- 		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
-- 		local StreetHash = GetStreetNameAtCoord(x, y, z)
-- 		local pId = GetPlayerServerId(PlayerId())
-- 		local pName = GetPlayerName(PlayerId())
-- 		local playerCount = #GetActivePlayers()
-- 		Citizen.Wait(15000)
-- 		if StreetHash ~= nil then
-- 			StreetName = GetStreetNameFromHashKey(StreetHash)
-- 			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
-- 				if IsPedSprinting(PlayerPedId()) then
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				elseif IsPedRunning(PlayerPedId()) then
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				elseif IsPedWalking(PlayerPedId()) then
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				elseif IsPedStill(PlayerPedId()) then
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				end
-- 			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
-- 				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
-- 				if MPH > 50 then
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				elseif MPH <= 50 and MPH > 0 then
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				elseif MPH == 0 then
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				end
-- 			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
-- 				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				else
-- 					SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 				end
-- 			elseif IsEntityInWater(PlayerPedId()) then
-- 				SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
-- 				SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
-- 				SetRichPresence("ID: "..pId.." | Oyuncu: ".. playerCount .."/256 ")
-- 			end
-- 		end
-- 	end
-- end)

-- POLİS ARAÇLARINA HIZ TAKVİYESİ

Citizen.CreateThread(function()
	while true do
		local sleep = 2000
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
		local class = GetVehicleClass(veh)
        if veh ~= nil then
			sleep = 5
            if class == 18 then
				SetVehicleEnginePowerMultiplier(veh, 40.0)
			elseif class == 7 then
				SetVehicleEnginePowerMultiplier(veh, 10.0)
			elseif class == 6 then
				SetVehicleEnginePowerMultiplier(veh, 10.0)
			elseif class == 3 then
				SetVehicleEnginePowerMultiplier(veh, 5.0)
            end
			
			SetVehicleEnginePowerMultiplier(635650, -5.0)
			-- print(veh)
        end
		Citizen.Wait(sleep)
	end
end)

-- HAWLİ KORNA

-- Citizen.CreateThread(function()
	-- while true do
		-- local sleep = 2500
		-- local playerPed = PlayerPedId()
		-- local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		-- if IsPedInAnyVehicle(playerPed) then
			-- sleep = 5
			-- if IsControlJustPressed(0, 29) then
				-- ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
					-- if quantity > 0 then
						-- TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 15, "arapkorna", 0.3)
					-- else
						-- TriggerEvent('notification', 'Havalı kornaya sahip değilsin!', 2)
					-- end
				-- end, 'water')
						
			-- end
		-- end
		-- Citizen.Wait(sleep)
	-- end
-- end)	

-- ÖLÜM LOGU

--Ölüm Logu
local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
--local Car = { 133987706, -1553120962 }
local Animal = { -100946242, 148160082 }
local FallDamage = { -842959696 }
local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local Gas = { -1600701090 }
local Burn = { 615608432, 883325847, -544306709 }
local Drown = { -10959621, 1936677264 }

Citizen.CreateThread(function()
    local alreadyDead = false

    while true do
        Citizen.Wait(50)
        local playerPed = PlayerPedId()
        if IsEntityDead(playerPed) and not alreadyDead then
            local playerName = GetPlayerName(PlayerId())
            killer = GetPedKiller(playerPed)
            killername = false

            for id = 0, 256 do
                if killer == GetPlayerPed(id) then
                    killername = GetPlayerName(id)
                end
            end

            local death = GetPedCauseOfDeath(playerPed)

            if checkArray (Melee, death) then
                TriggerServerEvent('playerDied', killername .. " Yumruklayarak " .. playerName .. "öldürdü")
            elseif checkArray (Bullet, death) then
                TriggerServerEvent('playerDied', killername .. " Silahla vurarak " .. playerName .. "öldürdü")
            elseif checkArray (Knife, death) then
                TriggerServerEvent('playerDied', killername .. " Bıçaklayarak " .. playerName .. "öldürdü")
          --  elseif checkArray (Car, death) then
         --       TriggerServerEvent('playerDied', killername .. " Arabayla ezerek " .. playerName .. "öldürdü")
            elseif checkArray (Animal, death) then
                TriggerServerEvent('playerDied', playerName .. " Hayvan tarafından öldürüldü")
            elseif checkArray (FallDamage, death) then
                TriggerServerEvent('playerDied', playerName .. " Düşerek öldü")
            elseif checkArray (Explosion, death) then
                TriggerServerEvent('playerDied', playerName .. " Patlama yüzünden öldü")
            elseif checkArray (Gas, death) then
                TriggerServerEvent('playerDied', playerName .. " Gaz yüzünden öldü")
            elseif checkArray (Burn, death) then
                TriggerServerEvent('playerDied', playerName .. " Yanarak öldü")
            elseif checkArray (Drown, death) then
                TriggerServerEvent('playerDied', playerName .. " Boğularak öldü")
            else
                TriggerServerEvent('playerDied', playerName .. " Bilinmiyor")
                --print(death)
            end

            alreadyDead = true
        end

        if not IsEntityDead(playerPed) then
            alreadyDead = false
        end
    end
end)

function checkArray (array, val)
    for name, value in ipairs(array) do
        if value == val then
            return true
        end
    end
    return false
end

-- ÖLÜMLOGU BİTİŞ