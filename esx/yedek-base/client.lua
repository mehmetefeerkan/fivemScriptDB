-- OYUN ICERISINCE NPCLER YOKKEN CIKAN ORTAM SESLERINI KAPATIR

CreateThread(function()   
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
    SetAudioFlag("PoliceScannerDisabled",true);
end)


-- POLIS ARACLARININ SILAH VERMESINI ENGELLER

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        id = PlayerId()
        DisablePlayerVehicleRewards(id)
    end
end)


--[[
-- CROSSHAIR SILER

Citizen.CreateThread(function()
	local isSniper = false
	while true do
Citizen.Wait(0)
	local ped = GetPlayerPed(-1)
	local currentWeaponHash = GetSelectedPedWeapon(ped)
	if currentWeaponHash == 100416529 then
	isSniper = true
	elseif currentWeaponHash == 205991906 then
	isSniper = true
 elseif currentWeaponHash == -952879014 then
	isSniper = true
 elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
	isSniper = true
 else
	isSniper = false
		end
			if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)
]]

-- MINI MAP ARAC DISI KAPANMA

Citizen.CreateThread(function()
    Citizen.Wait(10000)

    while true do
        local sleepThread = 500

        local radarEnabled = IsRadarEnabled()

        if not IsPedInAnyVehicle(PlayerPedId()) and radarEnabled then
            DisplayRadar(false)
        elseif IsPedInAnyVehicle(PlayerPedId()) and not radarEnabled then
            DisplayRadar(true)
        end

        Citizen.Wait(sleepThread)
    end
end)


-- NPCLERDEB YERE DUSEN SILAHLARI SILER
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(10000)
      RemoveAllPickupsOfType(0xDF711959)
      RemoveAllPickupsOfType(0xF9AFB48F)
      RemoveAllPickupsOfType(0xA9355DCD)
    end
  end)

  
  -- PVP 
  Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		SetCanAttackFriendly(GetPlayerPed(-1), true, false)
		NetworkSetFriendlyFireOption(true)
	end
end)


  -- PAUSE MENU NAME
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~p~XO ~w~DEVELOPMENTS V2~y~/ ~b~discord.gg/uVgp28mEWK')
end)


  -- ACIL SERVISLERI KAPATIR

Citizen.CreateThread(function()
	while true do
		Wait(1)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end
end)

-- PD SILER 

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(100)
    local playerPed = GetPlayerPed(-1)
    local playerLocalisation = GetEntityCoords(playerPed)
    ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
    end
    end)


-- CTRL ÇÖMELME

local crouched = false

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )

        local ped = GetPlayerPed( -1 )

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


-- 'B' PARMAKLA GÖSTER

local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(1000)
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
        Wait(1)

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

--[[
-- ARAC ITEKLEME

ESX               = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1000)
  end
end)

Config = {} 
Config.DamageNeeded = 100.0 -- 100.0 being broken and 1000.0 being fixed a lower value than 100.0 will break it
Config.MaxWidth = 5.0 -- Will complete soon
Config.MaxHeight = 5.0
Config.MaxLength = 5.0

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

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)

local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}
Citizen.CreateThread(function()
    Citizen.Wait(2000)
    while true do
        local ped = PlayerPedId()
        local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
        local vehicleCoords = GetEntityCoords(closestVehicle)
        local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
        if Distance < 6.0  and not IsPedInAnyVehicle(ped, false) then
            Vehicle.Coords = vehicleCoords
            Vehicle.Dimensions = dimension
            Vehicle.Vehicle = closestVehicle
            Vehicle.Distance = Distance
            if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                Vehicle.IsInFront = false
            else
                Vehicle.IsInFront = true
            end
        else
            Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
        end
        Citizen.Wait(5000)
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if Vehicle.Vehicle ~= nil then
 
                if IsVehicleSeatFree(Vehicle.Vehicle, -1) and GetVehicleEngineHealth(Vehicle.Vehicle) <= Config.DamageNeeded then
                    ESX.Game.Utils.DrawText3D({x = Vehicle.Coords.x, y = Vehicle.Coords.y, z = Vehicle.Coords.z}, 'Press [~g~SHIFT~w~] and [~g~E~w~] to push the vehicle', 0.4)
                end
     

            if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and IsControlJustPressed(0, Keys["E"])  and GetVehicleEngineHealth(Vehicle.Vehicle) <= Config.DamageNeeded then
                NetworkRequestControlOfEntity(Vehicle.Vehicle)
                local coords = GetEntityCoords(ped)
                if Vehicle.IsInFront then    
                    AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1 , Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                else
                    AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                end

                ESX.Streaming.RequestAnimDict('missfinale_c2ig_11')
                TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                Citizen.Wait(2000)

                local currentVehicle = Vehicle.Vehicle
                 while true do
                    Citizen.Wait(5)
                    if IsDisabledControlPressed(0, Keys["A"]) then
                        TaskVehicleTempAction(PlayerPedId(), currentVehicle, 11, 1000)
                    end

                    if IsDisabledControlPressed(0, Keys["D"]) then
                        TaskVehicleTempAction(PlayerPedId(), currentVehicle, 10, 1000)
                    end

                    if Vehicle.IsInFront then
                        SetVehicleForwardSpeed(currentVehicle, -1.0)
                    else
                        SetVehicleForwardSpeed(currentVehicle, 1.0)
                    end

                    if HasEntityCollidedWithAnything(currentVehicle) then
                        SetVehicleOnGroundProperly(currentVehicle)
                    end

                    if not IsDisabledControlPressed(0, Keys["E"]) then
                        DetachEntity(ped, false, false)
                        StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                        FreezeEntityPosition(ped, false)
                        break
                    end
                end
            end
        end
    end
end)


-- NPC ARACLARI KITLER

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = GetPlayerPed(-1)
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
            local lock = GetVehicleDoorLockStatus(veh)
            if lock == 7 then
                SetVehicleDoorsLocked(veh, 2)
            end
            local pedd = GetPedInVehicleSeat(veh, -1)
            if pedd then
                SetPedCanBeDraggedOut(pedd, false)
            end
        end
    end
 end)
 --]]
------BAYILMA
 local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    --["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

  local ragdoled = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if IsControlPressed(0, Keys["U"]) then
            ragdoled = true
            if IsPedInAnyVehicle(GetPlayerPed(), false) then
                ragdoled = false
                notify("~r~HATA~w~ Sadece Ayaklarının üstündeyken Bayılabilirsin!")
                end
            end
                 
        if ragdoled == true then
            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
            alert("Kalkmak için ~g~[E] ~w~tuşuna bas")

            if IsControlJustPressed(0, Keys['E']) then
                ragdoled = false
            end
        end
    end
end)


--[ [ FUNCTIONS ] ]

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

local canHandsUp = true

Citizen.CreateThread(function()
    local handsup = false

    while true do
        Citizen.Wait(0)

        if canHandsUp then
            if IsControlJustReleased(0, Keys['X']) then
                local playerPed = PlayerPedId()

                RequestAnimDict('random@mugging3')
                while not HasAnimDictLoaded('random@mugging3') do
                    Citizen.Wait(100)
                end

                if handsup then
                    handsup = false
                    ClearPedSecondaryTask(playerPed)
                else
                    handsup = true
                    TaskPlayAnim(playerPed, 'random@mugging3', 'handsup_standing_base', 3.0, -3.0, -1, 49, 0, 0, 0, 0)
                end
            end
        end
    end
end)

------BADCOP
ESX = nil


Weapons = {  -- Blacklistte bulunan silahları buraya giriyoruz.Silah kodlarına buradan ulaşabilirsiniz. / https://wiki.rage.mp/index.php?title=Weapons

    "WEAPON_COMBATPISTOL",
    "WEAPON_SMG",
    "WEAPON_CARBINERIFLE",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_STUNGUN",
    "WEAPON_ASSAULTSMG",

}

Jobs = { -- Whitelistte bulnacak meslekleri buraya yazıyoruz.

    "police",
    "sheriff",
    "fbi",

}

--[[

BU SCRIPT Kaves#0359 TARAFINDAN YAZILMIŞTIR.
THIS SCRIPT WAS WRITTEN BY Kaves#0359

]]--

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


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local player = PlayerPedId()
        if not isPlayerWhitelisted then
            for k,v in pairs(Weapons) do
                local player = PlayerPedId()
                local weapon = GetHashKey(v)
                if HasPedGotWeapon(player, weapon, false) == 1 then
                    RemoveWeaponFromPed(player, weapon)
                end
            end
        end
    end
end)


function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	for k,v in ipairs(Jobs) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisableControlAction(1, 140, true)
        if IsPlayerFreeAiming(PlayerId()) then
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

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

    ----HARİTA BOZULMA ENGEL
    Citizen.CreateThread(function()
        SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
        SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
        SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
        SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
        SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
    
        while true do
            Citizen.Wait(1)
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                SetRadarZoom(1100)
            end
        end
    end)


    ---NONPC

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0) -- prevent crashing
    
            -- These natives have to be called every frame.
            SetVehicleDensityMultiplierThisFrame(0.1) -- set traffic density to 0 
            SetPedDensityMultiplierThisFrame(0.1) -- set npc/ai peds density to 0
            SetRandomVehicleDensityMultiplierThisFrame(0.1) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
            SetParkedVehicleDensityMultiplierThisFrame(0.1) -- set random parked vehicles (parked car scenarios) to 0
            SetScenarioPedDensityMultiplierThisFrame(0.1, 0.1) -- set random npc/ai peds or scenario peds to 0
            SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
            SetRandomBoats(false) -- Stop random boats from spawning in the water.
            SetCreateRandomCops(false) -- disable random cops walking/driving around.
            SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
            SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
            
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
            ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
            RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
        end
    end)
    
--------SİLAH DAMAGE

-- Silah Damageleri
Citizen.CreateThread(function()
    while true do
	SetPedSuffersCriticalHits(PlayerPedId(), false)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DOUBLEACTION"), 0.25000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 0.55000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 0.5000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_VINTAGEPISTOL"), 0.3)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYPISTOL"), 0.50000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHINEPISTOL"), 0.4)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MINISMG"), 0.38000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_APPISTOL"), 0.35000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMPACTRIFLE"), 0.35000)
	Wait(0)		
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MICROSMG"), 0.5)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"), 0.42000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), 0.33000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTSMG"), 0.33000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.2)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"), 0.5)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("weapon_knuckle"), 0.25000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CROWBAR"), 0.24000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.24000)
	Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.10000)
	Wait(0)
    end
end)
-- Silah sekmeleri
local recoils = {


	-- pistols
	[416676503] = 0.10,

	--smg
	[-957766203] = 0.17,

	-- rifles
	[970310034] = 0.10,

}


local myRecoilFactor = 0.0
RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)

    myRecoilFactor = sendFactor / 5 + 0.0

end)


function quickmafs(dir)
	local x = 0.0
	local y = 0.0
	local dir = dir
	if dir >= 0.0 and dir <= 90.0 then
		local factor = (dir/9.2) / 10
		x = -1.0 + factor
		y = 0.0 - factor
	end

	if dir > 90.0 and dir <= 180.0 then
		dirp = dir - 90.0
		local factor = (dirp/9.2) / 10
		x = 0.0 + factor
		y = -1.0 + factor
	end

	if dir > 180.0 and dir <= 270.0 then
		dirp = dir - 180.0
		local factor = (dirp/9.2) / 10
		x = 1.0 - factor
		y = 0.0 + factor
	end

	if dir > 270.0 and dir <= 360.0 then
		dirp = dir - 270.0
		local factor = (dirp/9.2) / 10	
		x = 0.0 - factor
		y = 1.0 - factor
	end
	return x,y
end

Citizen.CreateThread( function()

	
	while true do 

		 if IsPedArmed(PlayerPedId(), 6) then
		 	Citizen.Wait(1)
		 else
		 	Citizen.Wait(1500)
		 end  

	    if IsPedShooting(PlayerPedId()) then
	    	local ply = PlayerPedId()
	    	local GamePlayCam = GetFollowPedCamViewMode()
	    	local Vehicled = IsPedInAnyVehicle(ply, false)
	    	local MovementSpeed = math.ceil(GetEntitySpeed(ply))

	    	if MovementSpeed > 69 then
	    		MovementSpeed = 69
	    	end

	        local _,wep = GetCurrentPedWeapon(ply)

	        local group = GetWeapontypeGroup(wep)

	        local p = GetGameplayCamRelativePitch()

	        local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

	        local recoil = math.random(35,100+MovementSpeed)/100
	        local rifle = false


          	if group == 970310034 then
          		rifle = true
          	end

          	if cameraDistance < 5.3 then
          		cameraDistance = 0.8
          	else
          		if cameraDistance < 8.0 then
          			cameraDistance = 1.5
          		else
          			cameraDistance = 4.0
          		end
          	end


	        if Vehicled then
	        	recoil = recoil + (recoil * cameraDistance)
	        else
	        	recoil = recoil * 0.8
	        end

	        if GamePlayCam == 4 then

	        	recoil = recoil * 0.7
		        if rifle then
		        	recoil = recoil * 0.1
		        end

	        end

	        if rifle then
	        	recoil = recoil * 0.7
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

end)

-- Silah Ekran Sallanması

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)


		
		-- Pistol
		if weapon == GetHashKey("WEAPON_STUNGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_APPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL50") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end
		
		if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_REVOLVER") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_DOUBLEACTION") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		-- SMG
		
		if weapon == GetHashKey("WEAPON_MICROSMG") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPDW") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end
		
		
		if weapon == GetHashKey("WEAPON_ASSAULTSMG") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MACHINEPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MINISMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end
		
		-- Rifles
		
		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end
		
		if weapon == GetHashKey("WEAPON_CARBINERIFLE") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end
		
		
		if weapon == GetHashKey("WEAPON_ADVANCEDRIFLE") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end
		
		if weapon == GetHashKey("WEAPON_GUSENBERG") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		if weapon == GetHashKey("WEAPON_COMPACTRIFLE") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
	end
end)

local recoils = {
	[453432689] = 0.3, -- PISTOL
	[3219281620] = 0.3, -- PISTOL MK2
	[1593441988] = 0.2, -- COMBAT PISTOL
	[584646201] = 0.1, -- AP PISTOL
	[2578377531] = 0.6, -- PISTOL .50
	[324215364] = 0.2, -- MICRO SMG
	[736523883] = 0.1, -- SMG
	[2024373456] = 0.1, -- SMG MK2
	[4024951519] = 0.1, -- ASSAULT SMG
	[3220176749] = 0.2, -- ASSAULT RIFLE
	[961495388] = 0.2, -- ASSAULT RIFLE MK2
	[2210333304] = 0.1, -- CARBINE RIFLE
	[4208062921] = 0.1, -- CARBINE RIFLE MK2
	[2937143193] = 0.1, -- ADVANCED RIFLE
	[2634544996] = 0.1, -- MG
	[2144741730] = 0.1, -- COMBAT MG
	[3686625920] = 0.1, -- COMBAT MG MK2
	[911657153] = 0.1, -- STUN GUN
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.2, -- SNS PISTOL
	[2009644972] = 0.25, -- SNS PISTOL MK2
	[1627465347] = 0.1, -- GUSENBERG
	[3231910285] = 0.2, -- SPECIAL CARBINE
	[-1768145561] = 0.25, -- SPECIAL CARBINE MK2
	[3523564046] = 0.5, -- HEAVY PISTOL
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[-2066285827] = 0.25, -- BULLPUP RIFLE MK2
	[137902532] = 0.4, -- VINTAGE PISTOL
	[-1746263880] = 0.4, -- DOUBLE ACTION REVOLVER
	[171789620] = 0.2, -- COMBAT PDW
	[3696079510] = 0.9, -- MARKSMAN PISTOL
	[3675956304] = 0.3, -- MACHINE PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.65, -- REVOLVER MK2
	[1649403952] = 0.3, -- COMPACT RIFLE
	[3173288789] = 0.1, -- MINI SMG		
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				repeat 
					Wait(0)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p+0.1, 0.2)
					end
					tv = tv+0.1
				until tv >= recoils[wep]
			end
			
		end
	end
end)

-----YANAGEÇ

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("yan", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone to run it




----İD GÖSTER
local hidden = {}
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 15
local playerSource = 0
local displayIDHeight = 1.0
local red = 255
local green = 255
local blue = 255

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        --SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) 
        DrawText(_x,_y)
    end
end

function DrawText3DNick(x,y,z, text)  -- Super
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.35*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        --SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) 
        DrawText(_x,_y)
    end
end

function DrawText3DTalking(x,y,z, text) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 5)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) 
        DrawText(_x,_y)
    end
end

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local invehicle = IsPedInAnyVehicle(ped, false)
    if invehicle then 
        for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
            if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
        end
    end
    return -2
end


RegisterNetEvent("hud:HidePlayer")
AddEventHandler("hud:HidePlayer", function(player, toggle)
    if type(player) == "table" then
        for k,v in pairs(player) do
            local id = GetPlayerFromServerId(k)
            hidden[id] = k
        end
        return
    end
    local id = GetPlayerFromServerId(player)
    if toggle == true then hidden[id] = player
    else
        for k,v in pairs(hidden) do
            if v == player then hidden[k] = nil end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, 19) then
            for i=0,99 do
                N_0x31698aa80e0223f8(i)
            end
            for id = 0, 128 do
                if  NetworkIsPlayerActive( id ) --[[and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) --]] then
                ped = GetPlayerPed( id )
               
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				
					local isDucking = IsPedDucking(GetPlayerPed( id ))
                    local sikis = HasEntityClearLosToEntity( GetPlayerPed( -1 ), GetPlayerPed( id ), 17 )
                    local koltuknumara = GetPedVehicleSeat( GetPlayerPed( id ) )
                    local isReadyToShoot = IsPedWeaponReadyToShoot(GetPlayerPed( id ))
                    local isStealth = GetPedStealthMovement(GetPlayerPed( id ))
                    local isDriveBy = IsPedDoingDriveby(GetPlayerPed( id ))
                    local isInCover = IsPedInCover(GetPlayerPed( id ),true)
                    if isStealth == nil then
                        isStealth = 0
                    end

                    if isDucking or isStealth == 1 or isDriveBy or isInCover then
                        sikis = false
                    end

                    if hidden[id] then sikis = false end
                    
                    if koltuknumara ~= -2 then
                        koltuknumara = koltuknumara + 0.25
                    end
                    koltuknumara = tonumber(koltuknumara)

                if(ignorePlayerNameDistance) then
					if( NetworkIsPlayerTalking(id) ) then
                            
                            if sikis then
                                if koltuknumara == -2 then
                                    DrawText3DTalking(x2, y2, z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                else
                                    DrawText3DTalking(x2, (y2+koltuknumara), z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, (y2+koltuknumara), z2+1.1, " ".. GetPlayerName(id) .. " ")
                                end
                            end
                        else
                            if sikis then
                                if koltuknumara == -2 then
                                    DrawText3D(x2, y2, z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                else
                                    DrawText3D(x2, (y2+koltuknumara), z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, (y2+koltuknumara), z2+1.1, " ".. GetPlayerName(id) .. " ")
                                end
                            end
                        end
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
						if( NetworkIsPlayerTalking(id) ) then
                            
                            if sikis then
                                if koltuknumara == -2 then
                                    DrawText3DTalking(x2, y2, z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                else
                                    DrawText3DTalking(x2, (y2+koltuknumara), z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                end
                            end
                        else
                            if sikis then
                                if koltuknumara == -2 then
                                    DrawText3D(x2, y2, z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                else
                                    DrawText3D(x2, (y2+koltuknumara), z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                end
                            end
                        end
                    end
                end  
            end
        end
        elseif not IsControlPressed(1, 19) then
            DrawText3D(0, 0, 0, "")
        end
    end
end)

--BLİP

local Blips = {
    [1] = {
        name = 'Marketlers',
        show = false,
        info = true,
        blip = {
            {title="Market", colour=2, id=52, x=373.875, y=325.896, z=103.666, np = nil},
            {title="Market", colour=2, id=52, x=2557.458, 382.282, z=106.722, np = nil},
            {title="Market", colour=2, id=52, x=-3038.939, y=585.954, z=7.998, np = nil},
            {title="Market", colour=2, id=52, x=547.431, y=2671.710, z=42.166, np = nil},
            {title="Market", colour=2, id=52, x=1961.464, y=3280.671, z=32.353, np = nil},
            {title="Market", colour=2, id=52, x=2678.916, y=3820.01, z=55.251, np = nil},
            {title="Market", colour=2, id=52, x=1729.563, y=6414.126, z=36.047, np = nil},
            {title="Market", colour=2, id=52, x=26.18, y=-1347.37, z=29.8, np = nil},
            {title="Market", colour=2, id=52, x=2557.458, y=382.282, z=108.632, np = nil},
            {title="Market", colour=2, id=52, x=-3241.927, y=1001.462, z=12.840, np = nil},
        }
    },
    [2] = {
        name = 'Berberler',
        show = false,
        info = true,
        blip = {
            {title="Berber", colour=4, id=71, x=1932.0756835938, y=3729.6706542969, z=32.844413757324, np = nil},
            {title="Berber", colour=4, id=71, x=-278.19036865234, y=6228.361328125, z=31.695510864258, np = nil},
            {title="Berber", colour=4, id=71, x=1211.9903564453, y=-472.77117919922, z=66.207984924316, np = nil},
            {title="Berber", colour=4, id=71, x=-33.224239349365, y=-152.62608337402, z=57.076496124268, np = nil},
            {title="Berber", colour=4, id=71, x=136.7181854248, y=-1708.2673339844, z=29.291622161865, np = nil},
            {title="Berber", colour=4, id=71, x=-815.18896484375, y=-184.53868103027, z=37.568943023682, np = nil},
            {title="Berber", colour=4, id=71, x=-1283.2886962891, y=-1117.3210449219, z=6.9901118278503, np = nil},
        }
    },
    [3] = {
        name = 'Garajlar',
        show = false,
        info = true,
        blip = {
            {title="Garaj", colour=53, id=290, x=273.67422485352, y=-344.15573120117, z=44.919834136963, np = nil},
            {title="Garaj", colour=53, id=290, x=-1803.8967285156, y=-341.45928955078, z=43.986347198486, np = nil},
            {title="Garaj", colour=53, id=290, x=1893.77, y=3712.21, z=32.78, np = nil},
            {title="Garaj", colour=53, id=290, x=77.53, y=6361.71, z=31.49, np = nil},
            {title="Garaj", colour=53, id=290, x=846.2601, y=-1050.778, z=27.95996, np = nil},
            {title="Garaj", colour=53, id=290, x=1107.18, y=60.58, z=80.89, np = nil},
            {title="Garaj", colour=53, id=290, x=1036.09, y=-763.36, z=57.99, np = nil},
            {title="Garaj", colour=53, id=290, x=56.05059, y=-876.4091, z=30.65991, np = nil},
            {title="Garaj", colour=53, id=290, x=-72.69, y=908.39, z=235.63, np = nil},
            {title="Garaj", colour=53, id=290, x=-72.69, y=908.39, z=235.63, np = nil},
            {title="Garaj", colour=53, id=290, x=-3155.68, y=1125.22, z=20.86, np = nil},
            {title="Garaj", colour=53, id=290, x=213.8, y=-809.00, z=31.05, np = nil},
            {title="Garaj", colour=53, id=290, x=-52.79, y=-220.93, z=45.44, np = nil},
            {title="Garaj", colour=53, id=290, x=2549.39, y=4669.95, z=34.08, np = nil},
            {title="Garaj", colour=53, id=290, x=951.42, y=-122.64, z=74.35, np = nil},
            {title="Garaj", colour=53, id=290, x=-1414.61, y=-653.81, z=28.67, np = nil},
            {title="Garaj", colour=53, id=290, x=541.1, y=-1791.09, z=29.14, np = nil},
            {title="Garaj", colour=53, id=290, x=-737.11, y=5822.99, z=17.31, np = nil},
            {title="Garaj", colour=53, id=290, x=1098.0, y=2659.54, z=38.14, np = nil},
        }
    },
    [4] = {
        name = 'Kıyafetçiler',
        show = false,
        info = true,
        blip = {
            {title="Kıyafetçi", colour=4, id=73, x=72.254,    y=-1399.102, z=28.376, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=-703.776,  y=-152.258,  z=36.415, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=-167.863,  y=-298.969,  z=38.733, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=428.694,   y=-800.106,  z=28.491, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=-829.413,  y=-1073.710, z=10.328, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=-1447.797, y=-242.461,  z=48.820, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=11.632,    y=6514.224,  z=30.877, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=123.646,   y=-219.440,  z=53.557, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=1696.291,  y=4829.312,  z=41.063, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=618.093,   y=2759.629,  z=41.088, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=1190.550,  y=2713.441,  z=37.222, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=-1193.429, y=-772.262,  z=16.324, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=-3172.496, y=1048.133,  z=19.863, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=458.29, y=-989.21,  z=30.69, np = nil},
            {title="Kıyafetçi", colour=4, id=73, x=-1108.441, y=2708.923,  z=18.107, np = nil},
        }
    },
    [5] = {
        name = 'Dövmeciler',
        show = false,
        info = true,
        blip = {
            {title="Dövmeci", colour=4, id=75, x=-814.308, y=-183.823, z=36.568, np = nil},
            {title="Dövmeci", colour=4, id=75, x=136.826, y=-1708.373, z=28.291, np = nil},
            {title="Dövmeci", colour=4, id=75, x=-1282.604, y=-1116.757, z=5.990, np = nil},
            {title="Dövmeci", colour=4, id=75, x=1931.513, y=3729.671, z=31.844, np = nil},
            {title="Dövmeci", colour=4, id=75, x=1212.840, y=-472.921, z=65.208, np = nil},
            {title="Dövmeci", colour=4, id=75, x=-32.885, y=-152.319, z=56.076, np = nil},
            {title="Dövmeci", colour=4, id=75, x=-278.077, y=6228.463, z=30.695, np = nil},
        }
    },
    [6] = {
        name = 'Bankalar',
        show = false,
        info = true,
        blip = {
            {title="Banka", colour=2, id=108, x=150.2, y=-1040.2, z=29.3, np = nil},
            {title="Banka", colour=2, id=108, x=-1212.9, y=-330.8, z=37.7, np = nil},
            {title="Banka", colour=2, id=108, x=-2962.5, y=482.6, z=15.7, np = nil},
            {title="Banka", colour=2, id=108, x=-112.2, y=6469.2, z=31.6, np = nil},
            {title="Banka", colour=2, id=108, x=314.1, y=-278.6, z=54.1, np = nil},
            {title="Banka", colour=2, id=108, x=-351.5, y=-49.5, z=49.0, np = nil},
            {title="Banka", colour=2, id=108, x=241.7, y=220.7, z=106.2, np = nil},
            {title="Banka", colour=2, id=108, x=1175.0, y=2706.6, z=38.0, np = nil},
        }
    },
    [7] = {
        name = 'Benzinlikler',
        show = false,
        info = true,
        blip = {
            {title="Benzinlik", colour=4, id=361, x=-5, y=-1, z=2, np = nil},
            {title="Benzinlik", colour=2, id=52, x=2, y=3, z=5, np = nil},

            {title="Benzinlik", colour=4, id=361, x=49.4187,   y=2778.793,  z=58.043, np = nil},
            {title="Benzinlik", colour=4, id=361, x=263.894,   y=2606.463,  z=44.983, np = nil},
            {title="Benzinlik", colour=4, id=361, x=1039.958,  y=2671.134,  z=39.550, np = nil},
            {title="Benzinlik", colour=4, id=361, x=1207.260,  y=2660.175,  z=37.899, np = nil},
            {title="Benzinlik", colour=4, id=361, x=2539.685,  y=2594.192,  z=37.944, np = nil},
            {title="Benzinlik", colour=4, id=361, x=2679.858,  y=3263.946,  z=55.240, np = nil},
            {title="Benzinlik", colour=4, id=361, x=2005.055,  y=3773.887,  z=32.403, np = nil},
            {title="Benzinlik", colour=4, id=361, x=1687.156,  y=4929.392,  z=42.078, np = nil},
            {title="Benzinlik", colour=4, id=361, x=1701.314,  y=6416.028,  z=32.763, np = nil},
            {title="Benzinlik", colour=4, id=361, x=179.857,   y=6602.839,  z=31.868, np = nil},
            {title="Benzinlik", colour=4, id=361, x=-94.4619,  y=6419.594,  z=31.489, np = nil},
            {title="Benzinlik", colour=4, id=361, x=-2554.996, y=2334.40,  z=33.078, np = nil},
            {title="Benzinlik", colour=4, id=361, x=-1800.375, y=803.661,  z=138.651, np = nil},
            {title="Benzinlik", colour=4, id=361, x=-1437.622, y=-276.747,  z=46.207, np = nil},
            {title="Benzinlik", colour=4, id=361, x=-2096.243, y=-320.286,  z=13.168, np = nil},
            {title="Benzinlik", colour=4, id=361, x=-724.619, y=-935.1631,  z=19.213, np = nil},
            {title="Benzinlik", colour=4, id=361, x=-526.019, y=-1211.003,  z=18.184, np = nil},
            {title="Benzinlik", colour=4, id=361, x=-70.2148, y=-1761.792,  z=29.534, np = nil},
            {title="Benzinlik", colour=4, id=361, x=265.648,  y=-1261.309,  z=29.292, np = nil},
            {title="Benzinlik", colour=4, id=361, x=819.653,  y=-1028.846,  z=26.403, np = nil},
            {title="Benzinlik", colour=4, id=361, x=1208.951, y=-1402.567, z=35.224, np = nil},
            {title="Benzinlik", colour=4, id=361, x=1181.381, y=-330.847,  z=69.316, np = nil},
            {title="Benzinlik", colour=4, id=361, x=620.843,  y=269.100,  z=103.089, np = nil},
            {title="Benzinlik", colour=4, id=361, x=2581.321, y=362.039, z=108.468, np = nil},
        }
    },
    [8] = {
        name = 'Kapanmazlar',
        show = true,
        info = false,
        blip = {
            --{title="Underground", colour=4, id=171, x=-1462.69, y=-382.09, z=38.82, np = nil},
            --{title="Hastane", colour=2, id=61, x=305.6, y=-1436.59, z=31.3, np = nil},
            --{title="Başo", colour=49, id=106, x=-1526.69, y=94.66, z=56.61, np = nil},
            --{title="Başo Mekanik", colour=49, id=15, x=958.09, y=-972.3, z=42.35, np = nil},
            --{title="Motel", colour=4, id=206, x=324.37, y=-212.47, z=54.09, np = nil},
            {title="Mega Mall", colour=4, id=78, x=45.44, y=-1748.18, z=29.56, np = nil},
            {title="Mega Mall", colour=4, id=78, x=2748.18, y=3472.44, z=55.67, np = nil},
            {title="Maden Yatagi", colour=5, id=112, x=-592.87, y=2079.77, z=131.42, np = nil},
            {title="Maden İşleme", colour=5, id=112, x=1088.07, y=-2001.57, z=30.88, np = nil},
            {title="Burger Shot", colour=0, id=546, x=-1179.05, y=-882.38, z=13.88, np = nil},
            {title="Satilik Mekanik", colour=46, id=15, x=-336.94, y=-136.82, z=38.48, np = nil},
            {title="Satilik Mekanik", colour=46, id=15, x=584.04, y=-183.14, z=67.17, np = nil},
            {title="Cadde Garage", colour=46, id=15, x=-227.94, y=-1330.82, z=30.48, np = nil},
            {title="Satilik Mekanik", colour=46, id=15, x=479.74, y=-1317.38, z=29.2, np = nil},
            {title="Drivers", colour=1, id=106, x=-1550.35, y=-264.35, z=-48.27, np = nil},
            {title="LSPD", colour=29, id=60, x=446.1, y=-983.01, z=30.01, bl = nil},
            {title="Tekila Bar", colour=1, id=93, x=-562.25, y=277.16, z=82.98, bl = nil},
            {title="Balık Tutma Alanı", colour=4, id=206, x=-1859.56, y=-1242.62, z=8.62, bl = nil},
            --{title="Angels of Death", colour=1, id=226, x=36.37, y=6475.09, z=31.88, bl = nil},
        }
    }
}
  
  RegisterNetEvent("adez_blip:turn")
  AddEventHandler("adez_blip:turn", function(i)
      if i ~= nil then
          if i <= #Blips then
                if Blips[i].info == true then
                    if Blips[i].show == true then
                        TurnOffBlip(i)
                        exports['mythic_notify']:DoHudText('inform', Blips[i].name .. '  kapadın!')
                    else
                        TurnOnBlip(i)
                        exports['mythic_notify']:DoHudText('inform', Blips[i].name .. '  açtın!')
                    end
                end
          end
      end
  end)
  
  RegisterCommand("blip", function(source, args)
      if args[1] == 'yardım' then
          InformBlips()
      else
          i = tonumber(args[1])
          TriggerEvent("adez_blip:turn", i)
      end
  end)
  
  function TurnOffBlip(i)
      for j=1, #Blips[i].blip, 1 do
          if Blips[i].blip[j].np ~= nil then
              SetBlipDisplay(Blips[i].blip[j].np, 0)
              Blips[i].show = false
          end
      end
  end
  
  function TurnOnBlip(i)
      for j=1, #Blips[i].blip, 1 do
          if Blips[i].blip[j].np ~= nil then
              SetBlipDisplay(Blips[i].blip[j].np, 4)
              Blips[i].show = true
          end
      end
  end
  
  function InformBlips()
      for i=1, #Blips, 1 do
          if Blips[i].info then
              TriggerEvent('chat:addMessage', {
                  color = { 255, 0, 0},
                  multiline = true,
                  args =  {'Blip' ,Blips[i].name .. ' = ' .. i}
              })
          end
      end
  end
  
  function AddBlips()
      for i=1, #Blips, 1 do
          for j=1, #Blips[i].blip, 1 do
                Blips[i].blip[j].np = AddBlipForCoord(Blips[i].blip[j].x, Blips[i].blip[j].y, Blips[i].blip[j].z)
                SetBlipSprite(Blips[i].blip[j].np, Blips[i].blip[j].id)
                if Blips[i].show then
                    SetBlipDisplay(Blips[i].blip[j].np, 4)
                else
                    SetBlipDisplay(Blips[i].blip[j].np, 0)
                end
                SetBlipScale(Blips[i].blip[j].np, 0.5)
                SetBlipColour(Blips[i].blip[j].np, Blips[i].blip[j].colour)
                SetBlipAsShortRange(Blips[i].blip[j].np, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(Blips[i].blip[j].title)
                EndTextCommandSetBlipName(Blips[i].blip[j].np)
          end
      end
  end
  
  TriggerEvent('chat:addSuggestion', '/blip', 'Blip Ac veya Kapa', {
      { name="blipNum", help="Blipin Numarasi/ Yardım için yardım yaz" }
  })
  
  Citizen.CreateThread(function()
      AddBlips()
  end)
  



  --cron

  local Jobs     = {}
local LastTime = nil

function RunAt(h, m, cb)

	table.insert(Jobs, {
		h  = h,
		m  = m,
		cb = cb
	})

end

function GetTime()

	local timestamp = os.time()
	local d         = os.date('*t', timestamp).wday
	local h         = tonumber(os.date('%H', timestamp))
	local m         = tonumber(os.date('%M', timestamp))

	return {d = d, h = h, m = m}

end

function OnTime(d, h, m)

	for i=1, #Jobs, 1 do
		if Jobs[i].h == h and Jobs[i].m == m then
			Jobs[i].cb(d, h, m)
		end
	end

end

function Tick()

	local time = GetTime()

	if time.h ~= LastTime.h or time.m ~= LastTime.m then
		OnTime(time.d, time.h, time.m)
		LastTime = time
	end

	SetTimeout(60000, Tick)
end

LastTime = GetTime()

Tick()

AddEventHandler('cron:runAt', function(h, m, cb)
	RunAt(h, m, cb)
end)
