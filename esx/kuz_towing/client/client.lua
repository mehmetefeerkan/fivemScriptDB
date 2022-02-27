Config.ropeLength = Config.ropeLength + .0
Config.maxTowingSpeed = Config.maxTowingSpeed + .0
ESX = nil
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

local menuOpen = false
local entity1 = nil
local entity2 = nil

local tempRope = nil
local ropes = {}
local localRope = nil

local driverPed = nil

local isPlayerInVehicle = false
local playerPed = PlayerPedId()
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
RegisterNetEvent('kuz_towing:openTowingMenu')
AddEventHandler('kuz_towing:openTowingMenu', function()
    OpenTowingMenu()
end)

RegisterNUICallback('FetchLocale', function(data, cb)
    SendNUIMessage({
        event = "locale",
        press_to_attach = Locale.press_to_attach,
        press_to_detach = Locale.press_to_detach,
    })
end)

RegisterNUICallback('CloseTowingMenu', function(data, cb)
    CloseTowingMenu()
    cb(true)
end)

function OpenTowingMenu()
    menuOpen = true
    SendNUIMessage({
        event = "show",
        state = true,
    })

    SetNuiFocus(true, true)
end

function CloseTowingMenu()
    if Config.useEsx then
        ESX.UI.Menu.CloseAll()
    end
    menuOpen = false
    SendNUIMessage({
        event = "show",
        state = false
    })
    SetNuiFocus(false, false)
end

RegisterNUICallback('ConnectFront', function(data, cb)
    playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local veh = GetNearestVehicle(coords.x, coords.y, coords.z, 5.0)

    local found = veh ~= 0 and veh ~= nil
    if (found) and entity2 ~= veh and not Contains(Config.blacklistedClasses, GetVehicleClass(veh)) then
        local lock = GetVehicleDoorLockStatus(veh)
        if (lock == 0 or lock == 1 or lock == 7 or lock == 8) or not Config.checkForLocks then
            entity1 = veh
            if (entity1 == nil or entity2 == nil) then
                AttachTempRope(entity1, true)
            end
            CloseTowingMenu()
            local vehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
            AttemptAttachRope()
            cb(vehName)
        else
            ShowTooltip(Locale.vehicle_locked)
            entity1 = nil
            cb(false)
        end
    else
        entity1 = nil
        cb(false)
    end
end)

RegisterNUICallback('ConnectRear', function(data, cb)
    playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local veh = GetNearestVehicle(coords.x, coords.y, coords.z, 5.0)

    local found = veh ~= 0 and veh ~= nil
    if (found) and entity1 ~= veh and not Contains(Config.blacklistedClasses, GetVehicleClass(veh)) then
        local lock = GetVehicleDoorLockStatus(veh)
        if (lock == 0 or lock == 1 or lock == 7 or lock == 8) or not Config.checkForLocks then
            entity2 = veh
            if (entity1 == nil or entity2 == nil) then
                AttachTempRope(entity2, false)
            end
            CloseTowingMenu()
            local vehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
            AttemptAttachRope()
            cb(vehName)
        else
            ShowTooltip('This vehicle is locked and therefore cannot be towed')
            entity2 = nil
            cb(false)
        end
    else
        entity2 = nil
        cb(false)
    end
end)

RegisterNUICallback('DetachRope', function(data, cb)
    DetachRope()
    cb(true)
end)

function DetachRope()
    if entity1 and entity2 then
        CloseTowingMenu()
        TriggerServerEvent('kuz_towing:stopTow')
        DeleteRope(localRope)
        SetEntityMaxSpeed(entity1, 99999.0)
        SetEntityMaxSpeed(entity2, 99999.0)
        localRope = nil
    elseif tempRope then
        CloseTowingMenu()
        DeleteRope(tempRope)
        tempRope = nil
    end

    if driverPed ~= nil then
        DeletePed(driverPed)
        driverPed = nil
    end

    entity1 = nil
    entity2 = nil

    SendNUIMessage({
        event = "reset",
    })
end

function AttemptAttachRope()
    if entity1 and entity2 then
        playerPed = PlayerPedId()
        local pos = GetEntityCoords(playerPed)
        SetRopesCreateNetworkWorldState(false)
        local veh1 = NetworkGetNetworkIdFromEntity(entity1)
        local veh2 = NetworkGetNetworkIdFromEntity(entity2)
        TriggerServerEvent('kuz_towing:tow', veh1, veh2)
        CloseTowingMenu()
        if tempRope ~= nil then
            DeleteRope(tempRope)
            tempRope = nil
        end
    end
end

function AttachTempRope(entity, front)
    playerPed = PlayerPedId()
    local bone = 'chassis'
    if front then
        bone = GetBoneRear(entity)
    else
        bone = GetBoneFront(entity)
    end

    local pos = GetEntityCoords(playerPed)
    if tempRope ~= nil then
        DeleteRope(tempRope)
        tempRope = nil
    end
    RopeLoadTextures()
    while not RopeAreTexturesLoaded() do
        Citizen.Wait(50)
    end

    local bonePos = GetWorldPositionOfEntityBone(entity, GetEntityBoneIndexByName(entity, bone))
    if GetDistanceBetweenCoords(bonePos, pos, true) <= Config.ropeLength * 1.5 then
        tempRope = AddRope(pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, Config.ropeLength * 0.2, 1, Config.ropeLength * 0.75, 0.1, 10.0, true, false, true, 1.0, false)
        AttachEntitiesToRope(tempRope, playerPed, entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, Config.ropeLength - 2.0, true, true, 'IK_R_Hand', bone)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)
        playerPed = PlayerPedId()
        if tempRope ~= nil then
            local speed = 0
            local coords = nil
            if entity1 ~= nil then
                speed = GetEntitySpeed(entity1)
                coords = GetWorldPositionOfEntityBone(entity1, GetEntityBoneIndexByName(entity1, GetBoneRear(entity1)))
            elseif entity2 ~= nil then
                speed = GetEntitySpeed(entity2)
                coords = GetWorldPositionOfEntityBone(entity2, GetEntityBoneIndexByName(entity2, GetBoneFront(entity2)))
            end
            if coords.x == 0 then
                if entity1 ~= nil then
                    coords = GetEntityCoords(entity1)
                elseif entity2 ~= nil then
                    coords = GetEntityCoords(entity2)
                end
            end

            local pullingDistance = GetDistanceBetweenCoords(GetWorldPositionOfEntityBone(playerPed, GetEntityBoneIndexByName(playerPed, 'IK_R_Hand')), coords)
            if (speed >= 5.0 and pullingDistance > (Config.ropeLength - 2.1)) or (speed > 20.0) or (pullingDistance > Config.ropeLength * 1.75) then
                local ragdoll = true
                DetachRope()
                Citizen.CreateThread(function()
                    while ragdoll do
                        Citizen.Wait(100)
                        velocity = GetEntityVelocity(playerPed)
                        if entity1 ~= nil then
                            velocity = GetEntityVelocity(entity1)
                        elseif entity2 ~= nil then
                            velocity = GetEntityVelocity(entity2)
                        end
                        SetEntityVelocity(playerPed, velocity.x * 1.25, velocity.y * 1.25, velocity.z * 1.25)
                        SetPedToRagdoll(playerPed, 1000, 1000, 0, true, true, true)
                    end
                end)
                Citizen.Wait(1000)
                entity1 = nil
                entity2 = nil
                ragdoll = false
            elseif pullingDistance > (Config.ropeLength * 1.3) and coords.x > 0 then
                DetachRope()
            end
        end

        isPlayerInVehicle = IsPedInAnyVehicle(playerPed)


        local potentialVehicles = {}
        if isPlayerInVehicle or driverPed ~= nil then
            for k, rope in pairs(ropes) do
                if isPlayerInVehicle then
                    table.insert(potentialVehicles, rope['veh2'])
                    local usingVeh = GetVehiclePedIsIn(playerPed, false)
                    if usingVeh == rope['veh1'] then
                        if GetPedInVehicleSeat(rope['veh2'], -1) == 0 then

                            local vehCoords = GetEntityCoords(rope['veh2'])
                            local pos = NetworkGetPlayerCoords(GetNearestPlayerToEntity(rope['veh2']))
                            if driverPed == nil and (GetDistanceBetweenCoords(vehCoords, pos) >= 3.0) then
                                CreateDriverPed(rope['veh1'], rope['veh2'])
                                NetworkRequestControlOfEntity(rope['veh2'])
                            end
                        end
                    end
                end
            end
        end
        if not isPlayerInVehicle then
            if driverPed ~= nil then
                DeletePed(driverPed)
                driverPed = nil
            end
        end
        if driverPed ~= nil then
            if not Contains(potentialVehicles, GetVehiclePedIsIn(driverPed)) then
                DeletePed(driverPed)
                driverPed = nil
            end

            if driverPed ~= nil then
                local npcCoords = GetEntityCoords(driverPed)
                local pos = NetworkGetPlayerCoords(GetNearestPlayerToEntity(driverPed))
                if GetDistanceBetweenCoords(npcCoords, pos) <= 3.0 then
                    DeletePed(driverPed)
                    driverPed = nil
                end
            end
        end
    end
end)

RegisterNetEvent('kuz_towing:removeRope')
AddEventHandler('kuz_towing:removeRope', function(id, veh1_, veh2_)
    for k, rope in pairs(ropes) do
        if rope.id == id then
            DeleteRope(rope.rope)
            ropes[k] = nil
            if NetworkDoesEntityExistWithNetworkId(veh1_) and NetworkDoesEntityExistWithNetworkId(veh2_) then
                local veh1 = NetworkGetEntityFromNetworkId(veh1_)
                local veh2 = NetworkGetEntityFromNetworkId(veh2_)
                SetEntityMaxSpeed(veh1_, 99999.0)
                SetEntityMaxSpeed(veh2_, 99999.0)
            end
        end
    end
end)

RegisterNetEvent('kuz_towing:makeRope')
AddEventHandler('kuz_towing:makeRope', function(veh1_, veh2_, id, owner)
    for k, rope in pairs(ropes) do
        if rope.id == id then
            DeleteRope(rope.rope)
            ropes[k] = nil
            if NetworkDoesEntityExistWithNetworkId(veh1_) and NetworkDoesEntityExistWithNetworkId(veh2_) then
                local veh1 = NetworkGetEntityFromNetworkId(veh1_)
                local veh2 = NetworkGetEntityFromNetworkId(veh2_)
                if veh1 ~= 0 then
                    SetEntityMaxSpeed(veh1, 99999.0)
                end
                if veh2 ~= 0 then
                    SetEntityMaxSpeed(veh2, 99999.0)
                end
            end
        end
    end

    if NetworkDoesEntityExistWithNetworkId(veh1_) and NetworkDoesEntityExistWithNetworkId(veh2_) then
        local veh1 = NetworkGetEntityFromNetworkId(veh1_)
        local veh2 = NetworkGetEntityFromNetworkId(veh2_)

        if (veh1 ~= nil and veh1 ~= 0 and veh2 ~= nil and veh2 ~= 0) then
            SetEntityMaxSpeed(veh1, Config.maxTowingSpeed / 2.3)
            SetEntityMaxSpeed(veh2, Config.maxTowingSpeed / 2.3)

            local pos = GetEntityCoords(veh1)

            local coords1 = GetWorldPositionOfEntityBone(veh1, GetEntityBoneIndexByName(veh1, GetBoneRear(veh1)))
            local coords2 = GetWorldPositionOfEntityBone(veh2, GetEntityBoneIndexByName(veh2, GetBoneFront(veh2)))

            local distance = GetDistanceBetweenCoords(coords1, coords2, true)
            if distance <= (Config.ropeLength * 3) then
                local bone1 = GetBoneRear(veh1)
                local bone2 = GetBoneFront(veh2)
                RopeLoadTextures()
                while not RopeAreTexturesLoaded() do
                    Citizen.Wait(50)
                end
                local rope = AddRope(pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, Config.ropeLength * 0.3, 1, Config.ropeLength, 0.1, 10.0, true, false, true, 1.0, false)
                AttachEntitiesToRope(rope, veh1, veh2, 0.0, 0.0, 0.1, 0.0, 0.0, 0.1, Config.ropeLength, false, false, bone1, bone2)
                if owner then
                    localRope = rope
                end
                local ropeObject = { rope = rope, id = id, veh1 = veh1, veh2 = veh2 }
                table.insert(ropes, ropeObject)
                SetVehicleBrake(veh2, false)
            else
                if owner then
                    DetachRope()
                end
            end
        end
    else
        if owner then
            DetachRope()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isPlayerInVehicle or driverPed ~= nil then
            for k, rope in pairs(ropes) do
                if driverPed ~= nil then
                    if (not IsPedInAnyVehicle(driverPed) or GetVehiclePedIsIn(driverPed) ~= rope['veh2']) or IsPedBeingJacked(driverPed) then
                        DeletePed(driverPed)
                        driverPed = nil
                    end
                    SetVehicleEngineOn(rope['veh2'], false, true, false)
                    SetVehicleBrake(rope['veh2'], false)
                    SetVehicleHandbrake(rope['veh2'], false)
                end
            end
        end
    end
end)


function GetBoneFront(veh)
    local bones = {
        'attach_male',
        'neon_f',
        'overheat',
        'overheat2',
        'rope_attach_a',
        'rope_attach_b',
        'overheat',
        'engine',
        'bonnet',
        'bumper_f',
        'transmission_f',
        'chassis_dummy',
    }
    for i, bone in pairs(bones) do
        local pos = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, bone))
        if pos.x ~= 0.0 and pos.x ~= 0 and pos.x ~= nil and (pos.x > 20.0 or pos.x < -20 or pos.z > 20 or pos.z < -20) then
            return bone
        end
    end
    return 'chassis_dummy'
end

function GetBoneRear(veh)
    local bones = {
        'attach_female',
        'neon_b',
        'tow_arm',
        'tow_mount_a',
        'tow_mount_b',
        'bumper_r',
        'exhaust',
        'boot',
        'petroltank',
        'chassis_dummy',
    }
    for i, bone in pairs(bones) do
        local pos = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, bone))
        if pos.x ~= 0.0 and pos.x ~= 0 and pos.x ~= nil and (pos.x > 20.0 or pos.x < -20 or pos.z > 20 or pos.z < -20) then
            return bone
        end
    end
    return 'chassis_dummy'
end

function CreateDriverPed(veh1, veh2)
    local npcHash = 'a_c_rabbit_01'
    modelHash = GetHashKey(npcHash)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(1)
    end
    if GetPedInVehicleSeat(veh2, -1) == 0 then
        driverPed = CreatePedInsideVehicle(veh2, 4, npcHash, -1, false, false)
        SetModelAsNoLongerNeeded(modelHash)

        SetEntityVisible(driverPed, false, 0)
        SetPedCanRagdoll(driverPed, false)
        SetEntityInvincible(driverPed, true)
        TaskVehicleFollow(driverPed, veh2, veh1, Config.maxTowingSpeed, 786603, 10)
    end
end

function GetNearestVehicle(x, y, z, radius)
    local closest = GetClosestVehicle(x, y, z, radius, 0, 70)
    local lastVeh = 0
    if not IsPedInAnyVehicle(playerPed) then
        lastVeh = GetVehiclePedIsIn(playerPed, true)
    end
    if lastVeh ~= 0 and GetDistanceBetweenCoords(x, y, z, GetEntityCoords(closest), true) > GetDistanceBetweenCoords(x, y, z, GetEntityCoords(lastVeh), true) then
        closest = lastVeh
    end

    return closest
end

function Contains(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function ShowTooltip(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end
