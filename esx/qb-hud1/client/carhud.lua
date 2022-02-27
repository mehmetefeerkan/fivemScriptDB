local tekerPatlak, seatbeltDisableExit, cruiseIsOn, seatbelt, vehIsMovingFwd, alarmset, engineRunning, driverSeat = false, false, false, false, false, false, false, false
local curSpeed, prevSpeed, kemerSayi, cruiseSpeed, speedLimit, vehicleClass, vehicle = 0.0, 0.0, 0, 999.0, 80.0, 0, 0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local compassOn = true
local vehAcc = false
local clock = ""
local zoneNames = {
    AIRP = "Los Santos Uluslararası Havalimanı",
    ALAMO = "Alamo Denizi",
    ALTA = "Alta",
    ARMYB = "Fort Zancudo",
    BANHAMC = "Banham Kanyonu",
    BANNING = "Banning",
    BAYTRE = "Baytree Kanyonu", 
    BEACH = "Vespucci Sahili",
    BHAMCA = "Banham Kanyonu",
    BRADP = "Braddock Geçişi",
    BRADT = "Braddock Tüneli",
    BURTON = "Burton",
    CALAFB = "Calafia Köprüsü",
    CANNY = "Raton Kanyonu",
    CCREAK = "Cassidy Deresi",
    CHAMH = "Chamberlain Tepeleri",
    CHIL = "Vinewood Tepeleri",
    CHU = "Chumash",
    CMSW = "Chiliad Dağ Eyaleti",
    CYPRE = "Cypress Bölgesi",
    DAVIS = "Davis",
    DELBE = "Del Perro Sahili",
    DELPE = "Del Perro",
    DELSOL = "La Puerta",
    DESRT = "Grand Senora Çölü",
    DOWNT = "Downtown",
    DTVINE = "Downtown Vinewood",
    EAST_V = "Doğu Vinewood",
    EBURO = "El Burro Tepeleri",
    ELGORL = "El Gordo Deniz Feneri",
    ELYSIAN = "Elysian Adası",
    GALFISH = "Galilee",
    GALLI = "Galileo Parkı",
    golf = "GWC ve Golf Sosyetesi",
    GRAPES = "Grapeseed",
    GREATC = "Great Chaparral",
    HARMO = "Harmony",
    HAWICK = "Hawick",
    HORS = "Vinewood Yarış Pisti",
    HUMLAB = "Humane Laboratuvarı",
    JAIL = "Bolingbroke Arazisi",
    KOREAT = "Little Seoul",
    LACT = "Land Act Rezervuarı",
    LAGO = "Lago Zancudo",
    LDAM = "Land Act Barajı",
    LEGSQU = "Legion Meydanı",
    LMESA = "La Mesa",
    LOSPUER = "La Puerta",
    MIRR = "Mirror Parkı",
    MORN = "Morningwood",
    MOVIE = "Richards Majestic",
    MTCHIL = "Chiliad Dağı",
    MTGORDO = "Gordo Dağı",
    MTJOSE = "Josiah Dağı",
    MURRI = "Murrieta Tepeleri",
    NCHU = "North Chumash",
    NOOSE = "N.O.O.S.E",
    OCEANA = "Pasifik Okyanusu",
    PALCOV = "Paleto Koyu",
    PALETO = "Paleto Bay",
    PALFOR = "Paleto Ormanı",
    PALHIGH = "Palomino Tepeleri",
    PALMPOW = "Palmer-Taylor Enerji Santrali",
    PBLUFF = "Pasifik Uçurumu",
    PBOX = "Pillbox Tepesi",
    PROCOB = "Procopio Sahili",
    RANCHO = "Rancho",
    RGLEN = "Richman Glen",
    RICHM = "Richman",
    ROCKF = "Rockford Tepeleri",
    RTRAK = "Redwood Işıkları Pisti",
    SanAnd = "San Andreas",
    SANCHIA = "San Chianski Dağ Arazisi",
    SANDY = "Sandy Kıyıları",
    SKID = "Mission Row",
    SLAB = "Stab Şehri",
    STAD = "Maze Bank Arenası",
    STRAW = "Strawberry",
    TATAMO = "Tataviam Dağları",
    TERMINA = "Terminal",
    TEXTI = "Tekstil Şehri",
    TONGVAH = "Tongva Tepeleri",
    TONGVAV = "Tongva Vadisi",
    VCANA = "Vespucci Kanalları",
    VESP = "Vespucci",
    VINE = "Vinewood",
    WINDF = "Ron Alternates Rüzgar Çiftliği",
    WVINE = "West Vinewood",
    ZANCUDO = "Zancudo Deresi",
    ZP_ORT = "Güney Los Santos Limanı",
    ZQ_UAR = "Davis Quartz"
}

-- araç arazi vs
local offRoad = 0
Citizen.CreateThread(function()
	while true do
        local time = 1000
		if inVehicle then 
            time = 200
            local wheel_type = GetVehicleWheelType(vehicle)
            if wheel_type ~= 3 and wheel_type ~= 4 and wheel_type ~= 6 then -- If have Off-road/Suv's/Motorcycles wheel grip its equal
                if not cruiseIsOn then
                    local maxSpeed = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
                    SetEntityMaxSpeed(vehicle, maxSpeed)
                end

                local material_id = GetVehicleWheelSurfaceMaterial(vehicle, 1)
                if material_id == 4 or material_id == 1 or material_id == 3 then -- All road (sandy/los santos/paleto bay)
                    offRoad = 0
					SetVehicleGravityAmount(vehicle, 9.8000001907349) -- On road
                else
                    offRoad = offRoad + 1
                    if offRoad > 4 then
                        SetVehicleGravityAmount(vehicle, 5.8000001907349) -- Off road
                    end
                end
            else
                if not cruiseIsOn then
                    local maxSpeed = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
                    SetEntityMaxSpeed(vehicle, maxSpeed-25)
                end
			end
        end
        Citizen.Wait(time)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if isLoggedIn then
            local hours = GetClockHours()
            local mins = GetClockMinutes()
            if string.len(tostring(hours)) == 1 then hours = '0'..hours end
            if string.len(tostring(mins)) == 1 then mins = '0'..mins end
            clock = hours .. ':' .. mins

            if inVehicle then 
                vehicle = GetVehiclePedIsIn(playerPed, false)
                vehicleClass = GetVehicleClass(vehicle)
                local street = ""
                local streetSol = ""
                local streetSag = ""

                if compassOn then
                    local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
                    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
                    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
                    local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
                    local zone = tostring(GetNameOfZone(x, y, z))
                    
                    if not zone then
                        zone = "UNKNOWN"
                        zoneNames['UNKNOWN'] = zone
                    elseif not zoneNames[zone] then
                        local undefinedZone = zone .. " " .. x .. " " .. y .. " " .. z
                        zoneNames[zone] = "Bilinmiyor"
                    end

                    street = zoneNames[zone]
                    streetSag = "Bilinmiyor"
                    streetSol = "[".. street .. "]"

                    if intersectStreetName ~= nil and intersectStreetName ~= "" then
                        street = currentStreetName .. " | " .. intersectStreetName .. " | [" .. zoneNames[zone] .. "]"
                        streetSag = currentStreetName .. " | " .. intersectStreetName
                    elseif currentStreetName ~= nil and currentStreetName ~= "" then
                        street = currentStreetName .. " | [" .. zoneNames[zone] .. "]"
                        streetSag = currentStreetName
                    else
                        street = "[".. zoneNames[tostring(zone)] .. "]"
                    end
                end
                local Fuel = 0
                if DoesEntityExist(vehicle) then
                    Fuel = GetVehicleFuelLevel(vehicle)
                    if Fuel < 20 then
                        if not IsThisModelABike(GetEntityModel(vehicle)) then
                            TriggerEvent("CarFuelAlarm")
                        end
                    else
                        if Fuel < 10 then
                            if not IsThisModelABike(GetEntityModel(vehicle)) then
                                TriggerEvent("CarFuelAlarm")
                            end
                        end
                    end
                end
                
                local Kmh = (prevSpeed * 3.6)

                if vehicleClass == 8 then
                    beltNui = "close"
                else
                    beltNui = seatbelt
                end

                if not engineRunning then
                    SendNUIMessage({
                        action = "two",
                        mph = Kmh,
                        fuel = math.ceil(Fuel),
                        street = street,
                        belt = beltNui,
                        time = clock,
                        streetSol = streetSol,
                        streetSag = streetSag,
                        cruise = cruiseIsOn,
                        colorblind = colorblind,
                        seatbeltmod = seatbeltDisableExit,
                        engine = false
                    }) 
                else
                    SendNUIMessage({
                        action = "two",
                        mph = Kmh,
                        fuel = math.ceil(Fuel),
                        street = street,
                        streetSol = streetSol,
                        streetSag = streetSag,
                        belt = beltNui,
                        time = clock,
                        cruise = cruiseIsOn,
                        colorblind = colorblind,
                        seatbeltmod = seatbeltDisableExit,
                        engine = true
                    }) 

                    
                end

            else
                if not compassOn then
                    SendNUIMessage({
                        action = "timeSet",
                        time = clock
                    })
                end
            end
        end

    end
end)

RegisterCommand("hızsabitle", function(source, args)
    if args[1] == nil then args[1] = 1 end
    if driverSeat and tonumber(args[1]) > 0 then
        -- if not IsVehicleTyreBurst(vehicle, 0) and not IsVehicleTyreBurst(vehicle, 1) and not IsVehicleTyreBurst(vehicle, 4) and not IsVehicleTyreBurst(vehicle, 5) then 
            cruiseIsOn = true
            cruiseSpeed = (tonumber(args[1]) / 3.6) / 1.3
        -- end
    end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/hızsabitle', 'Aracın hızını sabitlemek için bu komutu kullanabilirsin.', {{ name="Sabitlenecek Hız", help="35-999"}})
end)

RegisterNetEvent("ustun-hud:car:eject-other-player-car-client")
AddEventHandler("ustun-hud:car:eject-other-player-car-client", function(velocity)
    ejectPlayer()
end)

RegisterNetEvent('remove:harness')
AddEventHandler('remove:harness', function()
    if seatbeltDisableExit then 
        if seatbelt then
            exports['mythic_progbar']:Progress({
                name = "seatbelt",
                duration = 12000,
                label = 'Kemeri Çıkartıyorsun',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(cancelled)
                if not cancelled then
                    ESX.ShowNotification("Kemer çıkartıldı", "error")
                    PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
                    -- TriggerEvent('InteractSound_CL:PlayOnOne', 'cikar', 0.5)
                    seatbelt = false
                    seatbeltDisableExit = false
                end
            end)
        end
    end
end)

-- Secondary thread to update strings
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(4000)
--         -- if inVehicle and vehIsMovingFwd and not seatbelt and driverSeat and engineRunning and vehicleClass ~= 13 and vehicleClass ~= 8 and vehicleClass ~= 21 and vehicleClass ~= 14 and vehicleClass ~= 16 and vehicleClass ~= 15 then
--             -- TriggerEvent('InteractSound_CL:PlayOnOne', 'alarm', 0.5)
--         end
--     end
-- end)

-- CODE --
local zone = "Unknown";
local time = "12:00"
local uiopen = false
local colorblind = false
local busy = false
local VehicleNormalMaxSpeed = false

-- Sıkı Kemer
Citizen.CreateThread(function()
    while true do
        local waitTime = 500
        if inVehicle then
            waitTime = 1
            if IsControlJustReleased(0, 311) and vehicleClass ~= 8 then
                if kemerSayi < 2 and not busy then
                    if not seatbeltDisableExit then 
                        seatbelt = not seatbelt
                        if seatbelt then
                            --ESX.ShowNotification("Kemer takıldı!", "success")
                            --DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
                            --DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
                            -- TriggerEvent('InteractSound_CL:PlayOnOne', 'tak', 0.5)
                            --PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
                        else
                            --ESX.ShowNotification("Kemer çıkartıldı!", "error")
                            --PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
                            -- TriggerEvent('InteractSound_CL:PlayOnOne', 'cikar', 0.5)
                        end
                    end
                end
            end
        else
            waitTime = 500
        end
        Citizen.Wait(waitTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        local waitTime = 1
        if isLoggedIn then
            if inVehicle then
                engineRunning = GetIsVehicleEngineRunning(vehicle)
                driverSeat = GetPedInVehicleSeat(vehicle, -1) == playerPed
                prevSpeed = curSpeed
                curSpeed =  GetEntitySpeed(vehicle)
                vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                if seatbeltDisableExit and seatbelt then DisableControlAction(0, 75) else EnableControlAction(0, 75) end  
                vehAcc = (prevSpeed - curSpeed) / GetFrameTime() > 981
                
                if not seatbelt then
                    if vehIsMovingFwd and prevSpeed > 220 and vehAcc then
                        ejectPlayer()
                    else
                        prevVelocity = GetEntityVelocity(vehicle)
                    end
                end
                
                if GetPedInVehicleSeat(vehicle, 0) == playerPed then
                    if GetIsTaskActive(playerPed, 165) then
                        ClearPedTasks(playerPed)
                        SetPedIntoVehicle(playerPed, vehicle, 0)
                    end
                end
 
                -- When playerPed in driver seat, handle cruise control
                if driverSeat and engineRunning then
                    -- if IsEntityInAir(vehicle) then
                    --     DisableControlAction(2, 59)
                    --     DisableControlAction(2, 60)
                    -- end

                    if IsControlJustReleased(0, 246) then
                        if not cruiseIsOn and vehIsMovingFwd then
                            ESX.ShowNotification("Hız sabitleyici aktif!", "success")
                            cruiseSpeed = prevSpeed
                            cruiseIsOn = not cruiseIsOn
                        elseif cruiseIsOn then
                            ESX.ShowNotification("Hız sabitleyici pasif!", "error")
                            cruiseIsOn = not cruiseIsOn
                        end
                    end

                    local cruiseOn = cruiseIsOn and cruiseSpeed or tekerPatlak and 25.0
                    if not VehicleNormalMaxSpeed and not cruiseOn then
                        VehicleNormalMaxSpeed = true
                        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                        SetEntityMaxSpeed(vehicle, maxSpeed)
                    elseif cruiseOn and VehicleNormalMaxSpeed  then
                        VehicleNormalMaxSpeed = false
                        maxSpeed = cruiseOn
                    end
                    
                    if prevSpeed > maxSpeed then
                        SetEntityMaxSpeed(vehicle, prevSpeed-0.5)
                    end

                    if vehicleClass ~= 13 and vehicleClass ~= 8 and vehicleClass ~= 14 then
                        local triggerSpeed = 130.0
                        if seatbeltDisableExit then triggerSpeed = 10060.0 end
                        local maxSpeedTyre = 70.0
                        if vehicleClass == 18 then maxSpeedTyre = 85.0 end

                        if vehIsMovingFwd and vehAcc then
                            if prevSpeed*3.6 > triggerSpeed then
                                -- TriggerEvent("iens:motortamiret", vehicle, 10.0)
                                -- tyreBrustSet(false)
                                local seatPlayerId = {}
                                for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) do
                                    if i ~= 1 then
                                        if not IsVehicleSeatFree(vehicle, i-2) then 
                                            local otherPlayerId = GetPedInVehicleSeat(vehicle, i-2) 
                                            local playerHandle = NetworkGetPlayerIndexFromPed(otherPlayerId)
                                            local playerServerId = GetPlayerServerId(playerHandle)
                                            table.insert(seatPlayerId, playerServerId)
                                        end
                                    end
                                end
                                
                                if #seatPlayerId > 0 then
                                    TriggerServerEvent("ustun-hud:car:eject-other-player-car", seatPlayerId, prevVelocity)
                                end
                                ejectPlayer()
                            --elseif prevSpeed*3.6 > maxSpeedTyre then
                                --tyreBrustSet(true)
                            end
                        end
                    end

                    if IsVehicleTyreBurst(vehicle, 0) or IsVehicleTyreBurst(vehicle, 1) or IsVehicleTyreBurst(vehicle, 4) or IsVehicleTyreBurst(vehicle, 5) then 
                        tekerPatlak = true
                    else
                        tekerPatlak = false
                    end

                    prevVelocity = GetEntityVelocity(vehicle)
                else
                    cruiseIsOn = false
                end

            else
                inVehicle = false
                cruiseIsOn = false
                vehAcc = false
                seatbelt = false
                prevSpeed = 0.0
                waitTime = 1000
                vehIsMovingFwd = false
            end
        end
        Citizen.Wait(waitTime)
    end
end)

-- function tyreBrustSet(engine)
--     local lastVehicle = GetPlayersLastVehicle(playerPed)
--     local RastgeleTeker = (math.random(1,4))
--     if RastgeleTeker == 1 then
--         SetVehicleTyreBurst(lastVehicle, 0, 1, 100.0)
--     elseif RastgeleTeker == 2 then
--         SetVehicleTyreBurst(lastVehicle, 0, 1, 100.0)
--         SetVehicleTyreBurst(lastVehicle, 4, 1, 100.0)
--     elseif RastgeleTeker == 3 then
--         SetVehicleTyreBurst(lastVehicle, 0, 1, 100.0)
--         SetVehicleTyreBurst(lastVehicle, 1, 1, 100.0)
--         SetVehicleTyreBurst(lastVehicle, 4, 1, 100.0)
--         if engine then TriggerEvent("iens:motortamiret", lastVehicle, 10.0) end
--     elseif RastgeleTeker == 4 then
--         SetVehicleTyreBurst(lastVehicle, 0, 1, 100.0)
--         SetVehicleTyreBurst(lastVehicle, 1, 1, 100.0)
--         SetVehicleTyreBurst(lastVehicle, 4, 1, 100.0)
--         SetVehicleTyreBurst(lastVehicle, 5, 1, 100.0)
--         if engine then  TriggerEvent("iens:motortamiret", lastVehicle, 10.0) end
--     end
-- end

function ejectPlayer()
    local position = GetEntityCoords(playerPed)
    SetEntityCoords(playerPed, position.x, position.y, position.z - 0.47, true, true, true)
    SetEntityVelocity(playerPed, prevVelocity.x, prevVelocity.y, prevVelocity.z)
    Citizen.Wait(1)
    SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)
    Citizen.Wait(1000)
    if math.random(1, 3) == 1 then SetEntityHealth(playerPed, 0) end
end

RegisterNUICallback('set-compass', function(data, cb)
    compassOn = data.compassOn
end)

Citizen.CreateThread(function()
    while true do
        local waitTime = 1000
        if isLoggedIn then
            waitTime = 50
            if not uiopen then
                uiopen = true
                SendNUIMessage({action = "one"})
            end
            if compassOn then
                if inVehicle then
                    SendNUIMessage({
                        action = "two",
                        direction = -GetEntityHeading(playerPed) % 360,
                    })
                else
                    SendNUIMessage({
                        action = "four",
                        time = clock,
                        direction = -GetEntityHeading(playerPed) % 360,
                    })
                end
            else
                waitTime = 1000
            end
        end
        Citizen.Wait(waitTime)
    end
end)

RegisterNetEvent("CarFuelAlarm")
AddEventHandler("CarFuelAlarm",function()
    if not alarmset then
        alarmset = true
        local i = 5
        -- TriggerEvent("DoLongHudText", "Low fuel.",1)
        while i > 0 do
            PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
            i = i - 1
            Citizen.Wait(300)
        end
        Citizen.Wait(60000)
        alarmset = false
    end
end)