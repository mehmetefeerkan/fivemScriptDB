ESX = nil

local Base = Config.Gardener.Base
local Garage = Config.Gardener.Garage
local Marker = Config.Gardener.DefaultMarker
local GarageSpawnPoint = Config.Gardener.GarageSpawnPoint
local Type = nil
local AmountPayout = 0
local done = 0
local PlayerData = {}
local salary = nil

onDuty = false
hasCar = false
inGarageMenu = false
inMenu = false
wasTalked = false
appointed = false
waitingDone = false
CanWork = false
Paycheck = false

hasOpenDoor = false
hasBlower = false
hasTrimmer = false
hasLawnMower = false
hasBackPack = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
--     PlayerData = xPlayer
-- end)

-- RegisterNetEvent('esx:setJob')
-- AddEventHandler('esx:setJob', function(job)
-- 	PlayerData.job = job
-- end)

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

-- BASE
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

            -- if PlayerData.job ~= nil and PlayerData.job.grade_name == 'gardener' then
                if (GetDistanceBetweenCoords(coords, Base.Pos.x, Base.Pos.y, Base.Pos.z, true) < 8) then
                    sleep = 5
                    DrawMarker(Base.Type, Base.Pos.x, Base.Pos.y, Base.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Base.Size.x, Base.Size.y, Base.Size.z, Base.Color.r, Base.Color.g, Base.Color.b, 100, false, true, 2, false, false, false, false)
                    if (GetDistanceBetweenCoords(coords, Base.Pos.x, Base.Pos.y, Base.Pos.z, true) < 1.2) then
                        if not onDuty then
                            sleep = 5
                            DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, '~g~[E]~s~ - Change into work clothes')
                            if IsControlJustPressed(0, Keys["E"]) then
                                exports.rprogress:Custom({
                                    Duration = 2500,
                                    Label = "You're changing your clothes...",
                                    Animation = {
                                        scenario = "WORLD_HUMAN_COP_IDLES",
                                        animationDictionary = "idle_a",
                                    },
                                    DisableControls = {
                                        Mouse = false,
                                        Player = true,
                                        Vehicle = true
                                    }
                                })
                                Citizen.Wait(2500)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.male)
                                elseif skin.sex == 1 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.female)
                                end
                                end)
                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You started working!", timeout = 3000})
                                onDuty = true
                                addGarageBlip()
                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>To open the work menu, press <b>[DEL]</b>", timeout = 5000})
                            end
                        elseif onDuty then
                            sleep = 5
                            DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, '~r~[E]~s~ - Change into citizen clothes')
                            if IsControlJustPressed(0, Keys["E"]) then
                                exports.rprogress:Custom({
                                    Duration = 2500,
                                    Label = "You're changing your clothes...",
                                    Animation = {
                                        scenario = "WORLD_HUMAN_COP_IDLES",
                                        animationDictionary = "idle_a",
                                    },
                                    DisableControls = {
                                        Mouse = false,
                                        Player = true,
                                        Vehicle = true
                                    }
                                })
                                Citizen.Wait(2500)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                end)
                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You finished work!", timeout = 3000})
                                onDuty = false
                                removeGarageBlip()
                            end
                        end
                    end
                end
            -- end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

            -- if PlayerData.job ~= nil and PlayerData.job.grade_name == 'gardener' then
                if onDuty then
                    if not inMenu then
                        sleep = 2
                        if IsControlJustPressed(0, Keys["DEL"]) then
                            inMenu = true
                        end
                    elseif inMenu then
                        sleep = 2
                        DrawText3Dss(coords.x, coords.y, coords.z + 1.0, '~g~[G]~s~ - Search an errand | ~r~[H]~s~ - Cancel errand')
                        if IsControlJustPressed(0, Keys["DEL"]) then
                            inMenu = false
                        elseif IsControlJustPressed(0, Keys["G"]) then
                            if Type == nil then
                                inMenu = false
                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Searching an errand...", timeout = 15000})
                                Citizen.Wait(15000)
                                Gardens = Randomize(Config.Gardens)
                                CreateWork(Gardens.StreetHouse)
                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>GPS location set! Drive to " ..Gardens.StreetHouse, timeout = 2000})
                                salary = math.random(1, 2)
                                if Type == "Rockford Hills" then
                                    for i, v in ipairs(Config.RockfordHills) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "West Vinewood" then
                                    for i, v in ipairs(Config.WestVinewood) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Vinewood Hills" then
                                    for i, v in ipairs(Config.VinewoodHills) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "El Burro Heights" then
                                    for i, v in ipairs(Config.ElBurroHeights) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Richman" then
                                    for i, v in ipairs(Config.Richman) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Mirror Park" then
                                    for i, v in ipairs(Config.MirrorPark) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "East Vinewood" then
                                    for i, v in ipairs(Config.EastVinewood) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                end
                            else
                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You already have an errand!", timeout = 2000})
                            end
                        elseif IsControlJustPressed(0, Keys["H"]) then
                            if Type then
                                CancelWork()
                                DeleteWaypoint()
                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You canceled a meeting with a client", timeout = 2000})
                            elseif not Type then
                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You currently have no appointment", timeout = 2000})
                            end
                        end
                    end
                end
            -- end
        Citizen.Wait(sleep)
    end
end)

-- GARAGE MENU
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local WLCar = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

            -- if PlayerData.job ~= nil and PlayerData.job.grade_name == 'gardener' then
                if onDuty then
                    if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Marker.Type, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Garage.Size.x, Garage.Size.y, Garage.Size.z, Garage.Color.r, Garage.Color.g, Garage.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 1.2) then
                            if IsPedInAnyVehicle(ped, false) then
                                sleep = 5
                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~r~[E]~s~ - Return vehicle')
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if hasCar then
                                        TriggerServerEvent('inside-gardener:returnVehicle', source)
                                        ReturnVehicle()
                                        exports.pNotify:SendNotification({text = '<b>Gardener</b></br>You received ' ..Config.DepositPrice.. '$ for returning the vehicle', timeout = 1500})
                                        hasCar = false
                                        Plate = nil
                                    else
                                        exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You haven't paid deposit for this vehicle!", timeout = 2500})
                                    end
                                end
                            elseif not IsPedInAnyVehicle(ped, false) then
                                sleep = 5
                                if not inGarageMenu then
                                    DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~g~[E]~s~ - Open Garage Menu')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if not inMenu then
                                            FreezeEntityPosition(ped, true)
                                            inGarageMenu = true
                                            exports.pNotify:SendNotification({text = '<b>Gardener</b></br>Select a parking space', timeout = 2500})
                                        elseif inMenu then
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Close the work menu!", timeout = 2500})
                                        end
                                    end
                                elseif inGarageMenu then
                                    DrawText3DMenu(Garage.Pos.x - 0.8, Garage.Pos.y, Garage.Pos.z + 0.8, '~g~[G]~s~ - Parking Space #1\n~g~[H]~s~ - Parking Space #2\n~r~[E]~s~ - Close Garage Menu ')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        inGarageMenu = false
                                        FreezeEntityPosition(ped, false)
                                    elseif IsControlJustReleased(0, Keys["G"]) then
                                        if not hasCar then
                                            ESX.TriggerServerCallback('inside-gardener:checkMoney', function(hasMoney)
                                            if hasMoney then
                                                ESX.Game.SpawnVehicle(Config.CompanyVehicle, vector3(GarageSpawnPoint.Pos1.x, GarageSpawnPoint.Pos1.y, GarageSpawnPoint.Pos1.z), GarageSpawnPoint.Pos1.h, function(vehicle)
                                                SetVehicleNumberPlateText(vehicle, "GRD"..tostring(math.random(1000, 9999)))
                                                SetVehicleEngineOn(vehicle, true, true)
                                                exports.pNotify:SendNotification({text = '<b>Gardener</b></br>You paid ' ..Config.DepositPrice.. '$ to take out the vehicle', timeout = 1500})
                                                hasCar = true
                                                Plate = GetVehicleNumberPlateText(vehicle)
                                                end)
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            else
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You don't have enough money!", timeout = 2500})
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            end
                                            end)
                                        elseif hasCar then
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>First, put down the car you pulled out", timeout = 2500})
                                        end
                                    elseif IsControlJustReleased(0, Keys["H"]) then
                                        if not hasCar then
                                            ESX.TriggerServerCallback('inside-gardener:checkMoney', function(hasMoney)
                                            if hasMoney then
                                                ESX.Game.SpawnVehicle(Config.CompanyVehicle, vector3(GarageSpawnPoint.Pos2.x, GarageSpawnPoint.Pos2.y, GarageSpawnPoint.Pos2.z), GarageSpawnPoint.Pos2.h, function(vehicle)
                                                SetVehicleNumberPlateText(vehicle, "GRD"..tostring(math.random(1000, 9999)))
                                                SetVehicleEngineOn(vehicle, true, true)
                                                exports.pNotify:SendNotification({text = '<b>Gardener</b></br>You paid ' ..Config.DepositPrice.. '$ to take out the vehicle', timeout = 1500})
                                                hasCar = true
                                                Plate = GetVehicleNumberPlateText(vehicle)
                                                end)
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            else
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You don't have enough money!", timeout = 2500})
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            end
                                            end)
                                        elseif hasCar then
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>First, put down the car you pulled out", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            -- end
        Citizen.Wait(sleep)
    end
end)

-- OPENING VAN DOORS
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)

            if hasCar then
                if not IsPedInAnyVehicle(ped, false) then
                    if Plate == GetVehicleNumberPlateText(vehicle) then
                        local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.0, 0)
                        if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2) then
                            if not hasOpenDoor then
                                sleep = 5
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~g~[G]~s~ - Open Doors")
                                if IsControlJustReleased(0, Keys["G"]) then
                                    exports.rprogress:Custom({
                                        Duration = 1500,
                                        Label = "You're opening the rear doors",
                                        DisableControls = {
                                            Mouse = false,
                                            Player = true,
                                            Vehicle = true
                                        }
                                    })
                                    Citizen.Wait(1500)
                                    SetVehicleDoorOpen(vehicle, 3, false, false)
                                    SetVehicleDoorOpen(vehicle, 2, false, false)
                                    hasOpenDoor = true
                                end
                            elseif hasOpenDoor then
                                if not hasBlower and not hasLawnMower and not hasTrimmer and not hasBackPack then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.7, "~g~[E]~s~ - Leaf Blower | ~g~[H]~s~ Back Pack")
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.5, "~g~[K]~s~ - Trimmer | ~g~[L]~s~ - Lawn Mower")
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.3, "~r~[G]~s~ - Close Doors")
                                    if IsControlJustReleased(0, Keys["G"]) then
                                        exports.rprogress:Custom({
                                            Duration = 1500,
                                            Label = "You're closing the rear doors",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(1500)
                                        SetVehicleDoorShut(vehicle, 3, false)
                                        SetVehicleDoorShut(vehicle, 2, false)
                                        hasOpenDoor = false
                                    elseif IsControlJustReleased(0, Keys["E"]) then
                                        exports.rprogress:Custom({
                                            Duration = 1500,
                                            Label = "You pulling out the Leaf Blower...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(1500)
                                        addLeafBlower()
                                        hasBlower = true
                                    elseif IsControlJustReleased(0, Keys["H"]) then
                                        exports.rprogress:Custom({
                                            Duration = 1500,
                                            Label = "You pulling out the Back Pack...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(1500)
                                        addBackPack()
                                        hasBackPack = true
                                    elseif IsControlJustReleased(0, Keys["K"]) then
                                        exports.rprogress:Custom({
                                            Duration = 1500,
                                            Label = "You pulling out the Trimmer...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(1500)
                                        addTrimmer()
                                        hasTrimmer = true
                                    elseif IsControlJustReleased(0, Keys["L"]) then
                                        exports.rprogress:Custom({
                                            Duration = 1500,
                                            Label = "You pulling out the Lawn Mower...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(1500)
                                        addLawnMower()
                                        hasLawnMower = true
                                    end
                                elseif hasLawnMower or hasBlower or hasBackPack or hasTrimmer then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.5, "~g~[E]~s~ - Put the tool into trunk")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        exports.rprogress:Custom({
                                            Duration = 1500,
                                            Label = "You putting tool into trunk...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(1500)
                                        removeLawnMower()
                                        removeBackPack()
                                        removeLeafBlower()
                                        removeTrimmer()
                                        hasLawnMower = false
                                        hasBlower = false
                                        hasTrimmer = false
                                        hasBackPack = false
                                        ClearPedTasks(ped)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

            if Type == 'Rockford Hills' then
                for i, v in ipairs(Config.RockfordHills) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Hi, you want to clean up my garden for ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[G]~s~ - Yeah, sure | ~r~[H]~s~ - No, thanks')
                                if IsControlJustReleased(0, Keys["G"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Pull up weeds from the yard", timeout = 5000})
                                    BlipsWorkingRH()
                                elseif IsControlJustReleased(0, Keys["H"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Okay, I'll find a better gardener!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great! when you're done, let me know, I'll be at the front door")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You haven't finished cleaning garden")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Now the garden looks great, here's your paycheck")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You earned " ..salary.. "$!", timeout = 2500})
                                                ESX.Streaming.RequestAnimDict('mp_common', function()
                                                    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                end)
                                                ESX.Streaming.RequestAnimDict('mp_common', function()
                                                    TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                end)
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.RockfordHillsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Tear out the weed")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        ESX.Streaming.RequestAnimDict('amb@world_human_gardener_plant@male@enter', function()
                                            TaskPlayAnim(ped, 'amb@world_human_gardener_plant@male@enter', 'enter', 8.0, -8.0, -1, 2, 0, false, false, false)
                                        end)
                                        exports.rprogress:Custom({
                                            Duration = 3500,
                                            Label = "Tearing out the weed...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(3500)
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        done = done + 1
                                        ClearPedTasks(ped)
                                        if done == #Config.RockfordHillsWork then
                                            Paycheck = true
                                            done = 0
                                            AmountPayout = AmountPayout + 1
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>The garden is clean, go get your paycheck", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "West Vinewood" then
                for i, v in ipairs(Config.WestVinewood) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Hello, do you want to plant me trees for ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[G]~s~ - Of course | ~r~[H]~s~ - No way')
                                if IsControlJustReleased(0, Keys["G"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Plant trees in the driveway", timeout = 5000})
                                    BlipsWorkingWV()
                                elseif IsControlJustReleased(0, Keys["H"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Alright, I don't need you anymore!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "I'll wait near the pool with the money")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You didn't plant all the trees")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Now just wait until they grow up! keep your paycheck")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You earned " ..salary.. "$!", timeout = 2500})
                                                ESX.Streaming.RequestAnimDict('mp_common', function()
                                                    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                end)
                                                ESX.Streaming.RequestAnimDict('mp_common', function()
                                                    TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                end)
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.WestVinewoodWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Plant a tree")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        exports.rprogress:Custom({
                                            Duration = 5500,
                                            Label = "Planting tree...",
                                            Animation = {
                                                scenario = "WORLD_HUMAN_GARDENER_PLANT",
                                                animationDictionary = "enter",
                                            },
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        ClearPedTasks(ped)
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        done = done + 1
                                        if done == #Config.WestVinewoodWork then
                                            Paycheck = true
                                            done = 0
                                            AmountPayout = AmountPayout + 1
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>All trees planted, get your paycheck", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Vinewood Hills" then
                for i, v in ipairs(Config.VinewoodHills) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Good Morning Sir, want to earn ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[G]~s~ - Willingly | ~r~[H]~s~ - Falling off')
                                if IsControlJustReleased(0, Keys["G"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Pull the Leaf Blower out of the trunk and blow the leaves off the garden", timeout = 5000})
                                    BlipsWorkingVH()
                                elseif IsControlJustReleased(0, Keys["H"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Go away!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "I'm waiting on the terrace with the money")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You didn't blow off all the leaves")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Well done, grab the money")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasBlower then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You earned " ..salary.. "$!", timeout = 2500})
                                                    ESX.Streaming.RequestAnimDict('mp_common', function()
                                                        TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    ESX.Streaming.RequestAnimDict('mp_common', function()
                                                        TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasBlower then
                                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Put the Leaf Blower into trunk", timeout = 2500})
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.VinewoodHillsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Blow off the leaves")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasBlower then
                                            ESX.Streaming.RequestAnimDict('amb@world_human_gardener_leaf_blower@idle_a', function()
                                                TaskPlayAnim(ped, 'amb@world_human_gardener_leaf_blower@idle_a', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                            end)
                                            exports.rprogress:Custom({
                                                Duration = 5500,
                                                Label = "Blowing off the leaves...",
                                                DisableControls = {
                                                    Mouse = false,
                                                    Player = true,
                                                    Vehicle = true
                                                }
                                            })
                                            Citizen.Wait(5500)
                                            ClearPedTasks(ped)
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.VinewoodHillsWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>All leaves cleared, take cash from the customer", timeout = 2500})
                                            end
                                        elseif not hasBlower then
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You do not have a Leaf Blower", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "El Burro Heights" then
                for i, v in ipairs(Config.ElBurroHeights) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'E you! You want a quick ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[G]~s~ - Yup | ~r~[H]~s~ - Give it up')
                                if IsControlJustReleased(0, Keys["G"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Pull the grass out of the property", timeout = 5000})
                                    BlipsWorkingEBH()
                                elseif IsControlJustReleased(0, Keys["H"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Get out of here!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "When you're done, let me know ...")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You haven't pulled all the grass out!")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Hold the money, good job ...")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You earned " ..salary.. "$!", timeout = 2500})
                                                ESX.Streaming.RequestAnimDict('mp_common', function()
                                                    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                end)
                                                ESX.Streaming.RequestAnimDict('mp_common', function()
                                                    TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                end)
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.ElBurroHeightsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Pull up the grass")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        ESX.Streaming.RequestAnimDict('amb@world_human_gardener_plant@male@idle_a', function()
                                            TaskPlayAnim(ped, 'amb@world_human_gardener_plant@male@idle_a', 'idle_c', 8.0, -8.0, -1, 2, 0, false, false, false)
                                        end)
                                        exports.rprogress:Custom({
                                            Duration = 5500,
                                            Label = "Pulling up the grass...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(5500)
                                        ClearPedTasks(ped)
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        done = done + 1
                                        if done == #Config.ElBurroHeightsWork then
                                            Paycheck = true
                                            done = 0
                                            AmountPayout = AmountPayout + 1
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You pulled all the grass, go get the money", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Richman" then
                for i, v in ipairs(Config.Richman) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Good Morning buddy, you want to get rich by ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[G]~s~ - Okay | ~r~[H]~s~ - I have no time')
                                if IsControlJustReleased(0, Keys["G"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Pull the Trimmer out of the trunk and Trim the client's hedge", timeout = 5000})
                                    BlipsWorkingRM()
                                elseif IsControlJustReleased(0, Keys["H"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "No problem, have a nice day")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "I'll wait at the door")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You didn't trim the entire hedge")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Here is the money, you are the best!")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasTrimmer then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You earned " ..salary.. "$!", timeout = 2500})
                                                    ESX.Streaming.RequestAnimDict('mp_common', function()
                                                        TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    ESX.Streaming.RequestAnimDict('mp_common', function()
                                                        TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasTrimmer then
                                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Put the Trimmer into trunk", timeout = 2500})
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.RichmanWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Trim hedge")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasTrimmer then
                                            ESX.Streaming.RequestAnimDict('anim@mp_radio@garage@high', function()
                                                TaskPlayAnim(ped, 'anim@mp_radio@garage@high', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                            end)
                                            exports.rprogress:Custom({
                                                Duration = 5500,
                                                Label = "Trimming hedge...",
                                                DisableControls = {
                                                    Mouse = false,
                                                    Player = true,
                                                    Vehicle = true
                                                }
                                            })
                                            Citizen.Wait(5500)
                                            ClearPedTasks(ped)
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.RichmanWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Hedge is done, get your paycheck", timeout = 2500})
                                            end
                                        elseif not hasTrimmer then
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You do not have a Trimmer", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Mirror Park" then
                for i, v in ipairs(Config.MirrorPark) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Hi, you don't want to mow your lawn for ~g~" ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, "~g~[G]~s~ - All right | ~r~[H]~s~ - I'm in a hurry")
                                if IsControlJustReleased(0, Keys["G"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Pull the Lawn Mower out of the trunk and Mow the grass on the customer's property", timeout = 5000})
                                    BlipsWorkingMP()
                                elseif IsControlJustReleased(0, Keys["H"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "It's good that there are many gardeners in this city...")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "When you are finished, come for the payment")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You haven't mowed all the grass")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Now this garden makes sense, hold promissed money")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasLawnMower then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You earned " ..salary.. "$!", timeout = 2500})
                                                    ESX.Streaming.RequestAnimDict('mp_common', function()
                                                        TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    ESX.Streaming.RequestAnimDict('mp_common', function()
                                                        TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasLawnMower then
                                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Put the Lawn Mower into trunk", timeout = 2500})
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.MirrorParkWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Mow the grass")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasLawnMower then
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.MirrorParkWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Grass is done, get your paycheck", timeout = 2500})
                                            end
                                        elseif not hasLawnMower then
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You do not have a Lawn Mower", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "East Vinewood" then
                for i, v in ipairs(Config.EastVinewood) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Yo, you don't want to water my plants for ~g~" ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, "~g~[G]~s~ - I'm interested | ~r~[H]~s~ - I'm not interested")
                                if IsControlJustReleased(0, Keys["G"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Pull the Back Pack out of the trunk and Water the plants in the customer's backyard", timeout = 5000})
                                    BlipsWorkingEV()
                                elseif IsControlJustReleased(0, Keys["H"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Your loss, regret it")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "When you're done, come in for your paycheck")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You didn't water all the plants")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "They'll grow any minute... Hold your cash")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasBackPack then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You earned " ..salary.. "$!", timeout = 2500})
                                                    ESX.Streaming.RequestAnimDict('mp_common', function()
                                                        TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    ESX.Streaming.RequestAnimDict('mp_common', function()
                                                        TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasBackPack then
                                                    exports.pNotify:SendNotification({text = "<b>Gardener</b></br>Put the Back Pack into trunk", timeout = 2500})
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.EastVinewoodWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Water the plants")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasBackPack then
                                            ESX.Streaming.RequestAnimDict('missarmenian3_gardener', function()
                                                TaskPlayAnim(ped, 'missarmenian3_gardener', 'blower_idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                            end)
                                            exports.rprogress:Custom({
                                                Duration = 5500,
                                                Label = "Watering the plants...",
                                                DisableControls = {
                                                    Mouse = false,
                                                    Player = true,
                                                    Vehicle = true
                                                }
                                            })
                                            Citizen.Wait(5500)
                                            ClearPedTasks(ped)
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.EastVinewoodWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You watered all the plants, it's time to pay", timeout = 2500})
                                            end
                                        elseif not hasBackPack then
                                            exports.pNotify:SendNotification({text = "<b>Gardener</b></br>You do not have a Back Pack", timeout = 2500})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

function CreateWork(type)

    if type == "Rockford Hills" then
        for i, v in ipairs(Config.RockfordHills) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "West Vinewood" then
        for i, v in ipairs(Config.WestVinewood) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Vinewood Hills" then
        for i, v in ipairs(Config.VinewoodHills) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "El Burro Heights" then
        for i, v in ipairs(Config.ElBurroHeights) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Richman" then
        for i, v in ipairs(Config.Richman) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Mirror Park" then
        for i, v in ipairs(Config.MirrorPark) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "East Vinewood" then
        for i, v in ipairs(Config.EastVinewood) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    end
    Type = type
end

function CancelWork()

    if Type == "Rockford Hills" then
        for i, v in ipairs(Config.RockfordHills) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.RockfordHillsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "West Vinewood" then
        for i, v in ipairs(Config.WestVinewood) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.WestVinewoodWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Vinewood Hills" then
        for i, v in ipairs(Config.VinewoodHills) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.VinewoodHillsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "El Burro Heights" then
        for i, v in ipairs(Config.ElBurroHeights) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.ElBurroHeightsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Richman" then
        for i, v in ipairs(Config.Richman) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.RichmanWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Mirror Park" then
        for i, v in ipairs(Config.MirrorPark) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.MirrorParkWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "East Vinewood" then
        for i, v in ipairs(Config.EastVinewood) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.EastVinewoodWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    end
    Type = nil
    appointed = false
    wasTalked = false
    waitingDone = false
    CanWork = false
    Paycheck = false
    salary = nil
    AmountPayout = 0
    done = 0
end

function BlipsWorkingRH()
    for i, v in ipairs(Config.RockfordHillsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Weeds')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingWV()
    for i, v in ipairs(Config.WestVinewoodWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Trees')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingVH()
    for i, v in ipairs(Config.VinewoodHillsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Leaves')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingEBH()
    for i, v in ipairs(Config.ElBurroHeightsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Grass')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingRM()
    for i, v in ipairs(Config.RichmanWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Hedge')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingMP()
    for i, v in ipairs(Config.MirrorParkWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Grass to mow')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingEV()
    for i, v in ipairs(Config.EastVinewoodWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Watering plants')
        EndTextCommandSetBlipName(v.blip)
    end
end

function addBackPack()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    backpack = CreateObject(GetHashKey('prop_spray_backpack_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(backpack, ped, GetPedBoneIndex(ped, 56604), 0.0, -0.12, 0.28, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

function removeBackPack()
    local ped = PlayerPedId()

    DeleteEntity(backpack)
end

function addLawnMower()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    lawnmower = CreateObject(GetHashKey('prop_lawnmower_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(lawnmower, ped, GetPedBoneIndex(ped, 56604), -0.05, 1.0, -0.85, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

function removeLawnMower()
    local ped = PlayerPedId()

    DeleteEntity(lawnmower)
end

function addTrimmer()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    trimmer = CreateObject(GetHashKey('prop_hedge_trimmer_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(trimmer, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.02, 0.01, -121.0, 181.0, 187.0, true, true, false, true, 1, true)
end

function removeTrimmer()
    local ped = PlayerPedId()

    DeleteEntity(trimmer)
end

function addLeafBlower()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    leafblower = CreateObject(GetHashKey('prop_leaf_blower_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(leafblower, ped, GetPedBoneIndex(ped, 57005), 0.14, 0.02, 0.0, -40.0, -40.0, 0.0, true, true, false, true, 1, true)
end

function removeLeafBlower()
    local ped = PlayerPedId()

    DeleteEntity(leafblower)
end

-- RETURNING VEHICLE
function ReturnVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)

    ESX.Game.DeleteVehicle(vehicle)
end

-- MAIN BLIP
Citizen.CreateThread(function()
    baseBlip = AddBlipForCoord(Base.Pos.x, Base.Pos.y, Base.Pos.z)
    SetBlipSprite(baseBlip, Base.BlipSprite)
    SetBlipDisplay(baseBlip, 4)
    SetBlipScale(baseBlip, Base.BlipScale)
    SetBlipAsShortRange(baseBlip, true)
    SetBlipColour(baseBlip, Base.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Base.BlipLabel)
    EndTextCommandSetBlipName(baseBlip)
end)

-- ADDING GARAGES BLIPS
function addGarageBlip()
    garageBlip = AddBlipForCoord(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
    SetBlipSprite(garageBlip, Garage.BlipSprite)
    SetBlipDisplay(garageBlip, 4)
    SetBlipScale(garageBlip, Garage.BlipScale)
    SetBlipAsShortRange(garageBlip, true)
    SetBlipColour(garageBlip, Garage.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Garage.BlipLabel)
    EndTextCommandSetBlipName(garageBlip)
end

-- REMOVING GARAGES BLIPS
function removeGarageBlip()
    RemoveBlip(garageBlip)
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawText3DMenu(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.02+0.0125, -0.14+ factor, 0.08, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawText3Dss(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.008+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end