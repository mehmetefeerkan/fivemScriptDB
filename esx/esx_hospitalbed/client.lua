local Cinema, receptionPeds, sleep = false, {}, 2000
local bleeding = false

Citizen.CreateThread(function()
    while true do
        sleep = 2000
        if Cinema then
            sleep = 7
            local hasActivated = false
            local waitedMS = 0.00
            while not hasActivated do
                Wait(5)
                waitedMS = waitedMS + 0.001
                DrawRect(0.5, -0.08+waitedMS, 1.0, 0.15, 0, 0, 0, 255)
                DrawRect(0.5, 1.08-waitedMS, 1.0, 0.15, 0, 0, 0, 255)
                if waitedMS > 0.105 then
                    hasActivated = true
                end
            end
            while Cinema do
                Wait(1)
                DrawRect(0.5, 0.025, 1.0, 0.15, 0, 0, 0, 255)
                DrawRect(0.5, 0.975, 1.0, 0.15, 0, 0, 0, 255)
            end
            while hasActivated do
                Wait(5)
                waitedMS = waitedMS - 0.001
                DrawRect(0.5, -0.08+waitedMS, 1.0, 0.15, 0, 0, 0, 255)
                DrawRect(0.5, 1.08-waitedMS, 1.0, 0.15, 0, 0, 0, 255)
                if waitedMS < 0 then
                    hasActivated = false
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    for k, v in pairs(Config.Hospitals) do
        receptionPeds[k] = createPed(v.Peds.pedHash, v.Peds.reception.coords, v.Peds.reception.heading, false)  
        FreezeEntityPosition(receptionPeds[k], true) 
    end
    while true do
        sleep = 2000
        local me = PlayerPedId()
        -- if IsEntityPlayingAnim(GetPlayerPed(-1), 'misslamar1dead_body', 'dead_idle', 3) then
            
            for k, v in pairs(receptionPeds) do
                if DoesEntityExist(v) then
                    if GetDistanceBetweenCoords(GetEntityCoords(me), GetOffsetFromEntityInWorldCoords(v, 0.0, 2.0, 0.0), true) <= 5.5 then 
                        sleep = 7
                        drawTxt((Strings['get_help']):format('~b~[E]~w~', Config.Price))
                        if IsControlJustReleased(0, 38) or IsDisabledControlJustReleased(0, 38) then
                            TriggerServerEvent('esx_beds:gethelp', k)
                        end
                    end
                end
            end
        -- end
        Citizen.Wait(sleep)
    end
end) 

RegisterNetEvent('esx_beds:revive')
AddEventHandler('esx_beds:revive', function(hospital)
    -- Cinema = true
    TriggerEvent('esx_ambulancejob:revive')
    TaskStartScenarioInPlace(receptionPeds[hospital], 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, false)
    local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
    SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(receptionPeds[hospital], 0.0, 1.5, 0.75))
    RenderScriptCams(1, 0, 0, 1, 1)
    PointCamAtEntity(cam, receptionPeds[hospital], 0.0, 0.0, 0.0, true)
    local timer = GetGameTimer() + 7500
    while timer >= GetGameTimer() do for i = 0, 31 do DisableAllControlActions(i) end Wait(0) end
    ClearPedTasks(receptionPeds[hospital])

    local ped, me = receptionPeds[hospital], PlayerPedId()
    -- while IsEntityPlayingAnim(GetPlayerPed(-1), 'misslamar1dead_body', 'dead_idle', 3) do Wait(0) end
    Wait(250)
    if DoesEntityExist(ped) then
        DoScreenFadeOut(750)
        while not IsScreenFadedOut() do Wait(0) end
        -- local doctor = createPed(Config.Hospitals[hospital].Peds.pedHash, Config.Hospitals[hospital].Peds.doctor.coords, Config.Hospitals[hospital].Peds.doctor.heading, true)
        -- FreezeEntityPosition(doctor, true)
        cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
        SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(doctor, 0.0, -1.5, 1.1))
        RenderScriptCams(1, 0, 0, 1, 1)
        local dict = requestDict('anim@gangops@morgue@table@')
        DoScreenFadeIn(7500)
        -- SetEntityCoords(me, Config.QuitCoords.coords, false, false, false, true)
        -- SetEntityHeading(me, Config.QuitCoords.heading)
        SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(me, 0.0, -1.5, 1.1))
        -- local doctorDict = requestDict('mini@repair')
        timer = GetGameTimer() + Config.ReviveTime * 1000
        while timer >= GetGameTimer() do 
            if not IsEntityPlayingAnim(me, dict, 'ko_front', 3) then
                SetEntityCoords(me, Config.Hospitals[hospital].Bed.coords)
                SetEntityHeading(me, Config.Hospitals[hospital].Bed.heading)

            --     TriggerEvent('skinchanger:getSkin', function(skin)
            --         local clothesSkin = {
            --             ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            --             ['torso_1'] = 15, ['torso_2'] = 0,
            --             ['arms'] = 15, ['arms_2'] = 0,
            --             ['decals_1'] = 0, ['decals_2'] = 0
            --             }
            --         TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            --     end)

                dict = requestDict('anim@gangops@morgue@table@')
                TaskPlayAnim(me, dict, 'ko_front', 8.0, -8.0, -1, 1, 0, false, false, false)
            end
            -- TaskStartScenarioInPlace(doctor, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, false)
            -- if not IsEntityPlayingAnim(doctor, doctorDict, 'fixing_a_ped', 3) then
            --     doctorDict = requestDict('mini@repair')
            --     TaskPlayAnim(doctor, doctorDict, 'fixing_a_ped', 8.0, -8.0, -1, 1, 0, false, false, false)
            -- end
            PointCamAtEntity(cam, me, 0.0, 0.0, 0.0, true)
            -- for i = 0, 31 do DisableAllControlActions(i) end
            local timeLeft = math.floor((timer-GetGameTimer())/1000)
            drawTxt(('Yataga transfer ediliyorsun %s'):format(timeLeft))
            Wait(0) 
        end
        DoScreenFadeOut(750)
        while not IsScreenFadedOut() do Wait(0) end
        Cinema = false
        -- DeletePed(doctor)
        ClearPedTasks(me)
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam)

        if not bleeding then
            bleeding = true
            bleedingtime = Config.BleedingTime * 1000
        end
        DoScreenFadeIn(1500)
    end
end)  

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if bleeding then
            SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - 2)
            TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Kanaman var!', length = 500})
            bleedingtime = bleedingtime - 1000
            if bleedingtime == 0 then
                bleeding = false
                bleedingtime = Config.BleedingTime * 1000
            end
        end
    end
end)

local stopbleed = false
RegisterNetEvent('esx_beds:stopBleed')
AddEventHandler('esx_beds:stopBleed', function()
    local ped = GetPlayerPed(-1)
	if not IsPedInVehicle(ped, false, false) then
        exports['mythic_progbar']:Progress({
            name = "stopbleeding",
            duration = 4000,
            label = 'Kanama durdurucu hap içiliyor...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_suicide",
                anim = "pill_fp",
                flags = 49,
            },
        }, function(cancelled)
            if not cancelled then
                -- SetEntityHealth(ped, 140)
                bleeding = false
                stopbleed = true
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = '1 dakika boyunca kanaman olmayacak!', length = 5000})
                Citizen.Wait(60000)
                stopbleed = false
            end
        end)
    else
        exports['mythic_progbar']:Progress({
            name = "stopbleeding",
            duration = 4000,
            label = 'Kanama durdurucu hap içiliyor...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(cancelled)
            if not cancelled then
                -- SetEntityHealth(ped, 140)
                bleeding = false
                stopbleed = true
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = '1 dakika boyunca kanaman olmayacak!', length = 5000})
                Citizen.Wait(60000)
                stopbleed = false
            end
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if not bleeding then
            local pPed = GetPlayerPed(-1)
            local pHealth = GetEntityHealth(pPed)
            if pHealth <= 125 and not stopbleed then
                SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - 1)
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Kanaman var!', length = 500})
            end
        end
    end
end)


RegisterNetEvent('esx_beds:notify')
AddEventHandler('esx_beds:notify', function(txt)
    local timer = GetGameTimer() + 7000
    while timer >= GetGameTimer() do
        drawTxt(txt)
        Wait(0)
    end
end)

requestDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

drawTxt = function(text)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.95)
end

createPed = function(hash, coords, heading, networked)
    while not HasModelLoaded(hash) do Wait(0) RequestModel(hash) end
    local ped = CreatePed(4, hash, coords, heading, networked, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end