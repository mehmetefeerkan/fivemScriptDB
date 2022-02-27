ESX =  nil

local pos = GetEntityCoords(GetPlayerPed(-1),  true)
local s1, s2 = GetStreetNameAtCoord( pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
local street1 = GetStreetNameFromHashKey(s1)
local street2 = GetStreetNameFromHashKey(s2)
local isRobbing = false
local hasRobbed = false
local looting = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

function DrawText3Ds(x,y,z,text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('animation:rob')
AddEventHandler('animation:rob', function()
    local Ped = GetPlayerPed(-1)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    while isRobbing == true do
        if not IsEntityPlayingAnim(Ped, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)
end)

AddEventHandler('skinchanger:loadSkin', function(character)
	playerGender = character.sex
end)

RegisterNetEvent('znt:getReward')
AddEventHandler('znt:getReward', function()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)

    if vehicle == GetHashKey('stockade') or GetEntityModel(vehicle) then
      createped()
      pedSpawned = true
      local playerPed = PlayerPedId()
	   local playerCoords = GetEntityCoords(playerPed)
	   local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z))
    TriggerEvent('police:moneytruckrobbery')
    --  PlaySoundFrontend(GetSoundId(), "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
    end
    Citizen.Wait(0)
end)

function Timeout(hasRobbed)
    local timer = Config.Timeout
    while hasRobbed == true do
        Citizen.Wait(1000)

        if timer > 0 then
            timer = timer -1
        end

        if timer == 1 then
            hasRobbed = false
            finished = false
            break
        end
    end
end

RegisterNetEvent('znt:robbingtimer')
AddEventHandler('znt:robbingtimer', function ()

    if isRobbing == true then
        local timer = Config.Timer

        Citizen.CreateThread(function()
            while timer > 0 and isRobbing do
                Citizen.Wait (1000)

                if  timer > 0 then
                    timer = timer -1
                end

                if timer == 1 then
                    finished = true
                    break
                end
            end
        end)
    end
end)


function PlateCheck(CurPlate, CurrentPlate)
    local vehicle   = ESX.Game.GetVehicleInDirection()
    if CurrentPlate ~= CurPlate then
        return
    else
        SetVehicleDoorOpen(vehicle, 2, 0, 0)
        SetVehicleDoorOpen(vehicle, 3, 0, 0)
        looting = true
        TriggerEvent('animation:rob')
        TriggerServerEvent('znt:Payout')
        TriggerEvent('znt:robbingtimer')
        exports['mythic_progbar']:Progress({
            name = "saas",
            duration = 100000,
            label = 'Esyalari Topluyorsun',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            } ,
        }, function(cancelled)
        if not cancelled then
            SetVehicleDoorShut(vehicle, 2, 0)
            SetVehicleDoorShut(vehicle, 3, 0)
        end
        end)
    end
end

RobbedPlates = {}

Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    local pos = GetEntityCoords(GetPlayerPed(-1))
    local stockade = GetHashKey('stockade')
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, stockade, 70)
    local text = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -4.25, 0.0)
    local dstCheck = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(vehicle), true)
    local Plate = GetVehicleNumberPlateText(vehicle)

    if DoesEntityExist(vehicle) then
        if not isRobbing then
            if dstCheck < 5.0 then
                if IsControlJustReleased(0, 38) and not hasRobbed then
                    if not RobbedPlates[Plate] then
                        CurPlate = GetVehicleNumberPlateText(vehicle)
                        TriggerServerEvent('znt:Itemcheck', 1)
                        TriggerEvent("client:newStress",true,50)
                    else
                        exports['mythic_notify']:DoHudText('error', 'Bu kamyon boş görünüyor')
                    end
                end
            end
        end

        if not IsEntityDead(GetPlayerPed(-1)) then

            if pedSpawned == true and vehicle then

                --DrawMarker(27, text.x, text.y, text.z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255, 0, 0, 100, 0, 0, 0, 0)
                DrawText3Ds(text.x, text.y, text.z, "[E]")
                if dstCheck < 5.0 then
                    if IsControlJustReleased(0,38) and not looting then
                        CurrentPlate = GetVehicleNumberPlateText(vehicle)
                        PlateCheck(CurPlate, CurrentPlate)
                    end
                end
                if finished then
                    SetPedAsNoLongerNeeded(guard)
                    SetPedAsNoLongerNeeded(guard2)
                    SetPedAsNoLongerNeeded(guard3)
                    pedSpawned = false
                    isRobbing = false
                    looting = false
                    Timeout(true)
                    RobbedPlates[Plate] = true
                    TriggerServerEvent('znt:UpdatePlates', RobbedPlates, Plate)
                    TriggerServerEvent('znt:moneytruck_false')
                end
            end
        else
            TriggerServerEvent('znt:moneytruck_false')
            Citizen.Wait(Config.Timeout * 1000)
            finished = false
            isRobbing = false
            pedSpawned = false
            looting = false
        end
    else
        Citizen.Wait(500)
    end
    end
end)

RegisterNetEvent('znt:newTable')
AddEventHandler('znt:newTable', function(UpdatedTable)
    RobbedPlates = UpdatedTable
end)

RegisterNetEvent('znt:berkesex')
AddEventHandler('znt:berkesex', function(cb)
    cb = true
    isRobbing = true
    Hacking = true
    local Ped = GetPlayerPed(-1)
    if isRobbing == true then
        print('started')
        ClearPedSecondaryTask(Ped)
        TaskPlayAnim(Ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        exports['mythic_progbar']:Progress({
            name = "saas",
            duration = 10000,
            label = 'Kapıyı Açmayı Deniyorsun [DEL] İptal',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            } ,
        }, function(cancelled)
        if not cancelled then
            TriggerEvent('znt:getReward')
            ClearPedTasksImmediately(Ped)
            ClearPedTasks(PlayerPedId())
        end
        end)  
    end
end)

RegisterNetEvent('znt:NotifyPolice')
AddEventHandler('znt:NotifyPolice', function(msg)
    exports['mythic_notify']:DoHudText('error', msg)
end)

function cb1(success, timeremaining)
    if success then
        TriggerEvent('znt:getReward')
        TriggerServerEvent('znt:NotifyPolice', street1, street2, pos)
        Wait(30 * 1000) -- add a time penalty if failed, so it gives police more time to arrive // feel free to remove
        isRobbing = false
        TriggerServerEvent('znt:moneytruck_false')
    end
end

function createped()

    local pos = GetEntityCoords(GetPlayerPed(-1))
    local hashKey = GetHashKey("ig_casey")
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)
    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(500)
    end

    guard = CreatePedInsideVehicle(vehicle, pedType, hashKey, 0, 1, 1)
    guard2 = CreatePedInsideVehicle(vehicle, pedType, hashKey, 1, 1, 1)
    guard3 =  CreatePedInsideVehicle(vehicle, pedType, hashKey, 2, 1, 1)

  --////////////
  --  Guard 1
  --///////////

    SetPedShootRate(guard,  750)
    SetPedCombatAttributes(guard, 46, true)
    SetPedFleeAttributes(guard, 0, 0)
    SetPedAsEnemy(guard,true)
    SetPedMaxHealth(guard, 900)
    SetPedAlertness(guard, 3)
    SetPedCombatRange(guard, 0)
    SetPedCombatMovement(guard, 3)
    TaskCombatPed(guard, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard, vehicle, 0)
    GiveWeaponToPed(guard, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard, GetHashKey("HATES_PLAYER"))

    --////////////
    --  Guard 2
    --///////////
    SetPedShootRate(guard2,  750)
    SetPedCombatAttributes(guard2, 46, true)
    SetPedFleeAttributes(guard2, 0, 0)
    SetPedAsEnemy(guard2,true)
    SetPedMaxHealth(guard2, 900)
    SetPedAlertness(guard2, 3)
    SetPedCombatRange(guard2, 0)
    SetPedCombatMovement(guard2, 3)
    TaskCombatPed(guard2, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard2, vehicle, 0)
    GiveWeaponToPed(guard2, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard2, GetHashKey("HATES_PLAYER"))
  
    --////////////
    --  Guard3
    --///////////
    SetPedShootRate(guard3,  750)
    SetPedCombatAttributes(guard3, 46, true)
    SetPedFleeAttributes(guard3, 0, 0)
    SetPedAsEnemy(guard3,true)
    SetPedMaxHealth(guard3, 900)
    SetPedAlertness(guard3, 3)
    SetPedCombatRange(guard3, 0)
    SetPedCombatMovement(guard3, 3)
    TaskCombatPed(guard3, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard3, vehicle, 0)
    GiveWeaponToPed(guard3, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard3, GetHashKey("HATES_PLAYER"))
end