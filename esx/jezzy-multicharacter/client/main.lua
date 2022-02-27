ESX = nil

local charPed = nil
local spawnedPeds = {}

Config = {
    PedCoords = {x = -813.97, y = 176.22, z = 76.74, h = -7.5, r = 1.0}, 
}

charCoords = {
    {x = -774.8, y = 320.2, z = 194.88, h = 91.81, dic = "timetable@ron@ig_3_couch", name = "base"},
    {x = -774.95, y = 318.95, z = 194.88, h = 100.08, dic = "timetable@ron@ig_5_p3", name = "ig_5_p3_base"},
    {x = -774.89, y = 318.08, z = 194.88, h = 53.7, dic = "timetable@reunited@ig_10", name = "base_amanda"},--
    {x = -775.77, y = 318.15, z = 194.944, h = 5.3, dic = "timetable@maid@couch@", name = "base"},
    {x = -776.85, y = 317.38, z = 195.36, h = 10.8, dic = "PROP_HUMAN_SEAT_BENCH"},
}

HiddenCoords = {x = -773.07, y = 325.91, z = 196.09, h = 174.64}
CamCoords = {x = -778.17, y = 321.81, z = 196.5, h = 220.6}

Citizen.CreateThread(function() 
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)    
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if ESX then
            if NetworkIsSessionStarted() then
                TriggerEvent('pant-multicharacter:client:chooseChar')
                TriggerEvent('hud:toggleui', false)
                return
            end 
        end
    end
end)

AddEventHandler('onClientResourceStop', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        print('The resource ' .. resourceName .. ' has been stopped on the client.')
        for i=1, #spawnedPeds do
            SetEntityAsMissionEntity(spawnedPeds[i], true, true)
            DeletePed(spawnedPeds[i])
        end
    end
end)

--- CODE
local choosingCharacter = false
local cam = nil

function openCharMenu(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    choosingCharacter = bool
    skyCam(bool)
end

RegisterNUICallback('closeUI', function()
    openCharMenu(false)
end)

RegisterNUICallback('disconnectButton', function()
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    TriggerServerEvent('pant-multicharacter:server:disconnect')
end)

RegisterNUICallback('selectCharacter', function(data)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('pant-multicharacter:server:loadUserData', cData)
    openCharMenu(false)
    for i=1, #spawnedPeds do
        SetEntityAsMissionEntity(spawnedPeds[i], true, true)
        DeletePed(spawnedPeds[i])
    end
end)

RegisterNetEvent('pant-multicharacter:client:closeNUI')
AddEventHandler('pant-multicharacter:client:closeNUI', function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent('pant-multicharacter:client:chooseChar')
AddEventHandler('pant-multicharacter:client:chooseChar', function()
    SetNuiFocus(false, false)
    DoScreenFadeOut(10)
    Citizen.Wait(1000)
    local interior = GetInteriorAtCoords(-773.2258, 322.8252, 194.8862)
    LoadInterior(interior)
    while not IsInteriorReady(interior) do
        Citizen.Wait(1000)
        print("[Yükleniyor... Lütfen Bekleyin!]")
    end
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), HiddenCoords.x, HiddenCoords.y, HiddenCoords.z)
    Citizen.Wait(1500)
    ShutdownLoadingScreenNui()
    NetworkSetTalkerProximity(0.0)
    openCharMenu(true)
end)

function spawnChar(charInfo)
    for i=1, #charCoords do
        if charInfo[i] then
            ESX.TriggerServerCallback('pant-multicharacter:server:getSkin', function(model, data)
                model = model ~= nil and tonumber(model) or false
                if model ~= nil then
                    Citizen.CreateThread(function()
                        if data then
                            spawnPed(charInfo, model, i, json.decode(data))
                        else
                            local randommodels = {"mp_m_freemode_01","mp_f_freemode_01"}
                            spawnPed(charInfo, GetHashKey(randommodels[math.random(1, #randommodels)]), i)
                        end
                    end)
                else
                    Citizen.CreateThread(function()
                        local randommodels = {"mp_m_freemode_01","mp_f_freemode_01"}
                        spawnPed(charInfo, GetHashKey(randommodels[math.random(1, #randommodels)]), i)
                    end)
                end
            end, charInfo[i].citizenid)
        else
            Citizen.CreateThread(function()
                local randommodels = {"mp_m_freemode_01","mp_f_freemode_01"}
                spawnPed(charInfo, GetHashKey(randommodels[math.random(1, #randommodels)]), i)
            end)
        end
    end
end

function spawnPed(charInfo, model, i, data)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    Citizen.CreateThread(function()
        local charPed = CreatePed(3, model, charCoords[i].x, charCoords[i].y, charCoords[i].z, charCoords[i].h, false, true)
        if charPed then
            SetPedComponentVariation(charPed, 0, 0, 0, 2)
            FreezeEntityPosition(charPed, true)
            SetEntityInvincible(charPed, true)
            PlaceObjectOnGroundProperly(charPed)
            SetBlockingOfNonTemporaryEvents(charPed, true)
            if data then
                TriggerEvent('pant-clothing:client:loadPlayerClothing', data, charPed, 200, 200, true)
            end
            table.insert(spawnedPeds, charPed)
            if charCoords[i].name then
                -- PantCore.Shared.RequestAnimDict( charCoords[i].dic, function() -- animasyon oynatma
                    TaskPlayAnim(charPed, charCoords[i].dic, charCoords[i].name, 2.0, 2.0, -1, 33, 0, false, false, false)
            else
                TaskStartScenarioAtPosition(charPed, charCoords[i].dic, charCoords[i].x, charCoords[i].y, charCoords[i].z, charCoords[i].h, -1, true, true)
            end
        end
    end)

    SetModelAsNoLongerNeeded(model)

    if i == 5 then
        SendNUIMessage({
            action = "setupCharacters",
            characters = charInfo
        })
    end
end

function selectChar()
    openCharMenu(true)
end

RegisterNUICallback('cDataPed', function(data)
    local cData = data.cData  
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)

    if cData ~= nil then
        ESX.TriggerServerCallback('pant-multicharacter:server:getSkin', function(model, data)
            model = model ~= nil and tonumber(model) or false
            if model ~= nil then
                Citizen.CreateThread(function()
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.h, false, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                    SetModelAsNoLongerNeeded(model)
                    data = json.decode(data)
                    TriggerEvent('pant-clothing:client:loadPlayerClothing', data, charPed)
                end)
            else
                Citizen.CreateThread(function()
                    local randommodels = {
                        "mp_m_freemode_01",
                        "mp_f_freemode_01",
                    }
                    local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.h, false, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetModelAsNoLongerNeeded(model)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                end)
            end
        end, cData.citizenid)
    else
        Citizen.CreateThread(function()
            local randommodels = {
                "mp_m_freemode_01",
                "mp_f_freemode_01",
            }
            local model = GetHashKey(randommodels[math.random(1, #randommodels)])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end
            charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.h, false, true)
            SetPedComponentVariation(charPed, 0, 0, 0, 2)
            FreezeEntityPosition(charPed, false)
            SetEntityInvincible(charPed, true)
            PlaceObjectOnGroundProperly(charPed)
            SetBlockingOfNonTemporaryEvents(charPed, true)
            SetModelAsNoLongerNeeded(model)
        end)
    end
end)

RegisterNUICallback('setupCharacters', function()
    if #spawnedPeds > 0 then for i=1, #spawnedPeds do SetEntityAsMissionEntity(spawnedPeds[i], true, true) DeletePed(spawnedPeds[i]) end end
    ESX.TriggerServerCallback("test:yeet", function(result)
        spawnChar(result)
    end)
end)

RegisterNUICallback('removeBlur', function()
    SetTimecycleModifier('default')
end)

RegisterNUICallback('createNewCharacter', function(data)
    local cData = data
    DoScreenFadeOut(150)
    if cData.gender == "Erkek" then
        cData.gender = 0
    elseif cData.gender == "Kadin" then
        cData.gender = 1
    end

    TriggerServerEvent('pant-multicharacter:server:createCharacter', cData)
    TriggerServerEvent('pant-multicharacter:server:GiveStarterItems')
    Citizen.Wait(500)
end)

RegisterNUICallback('removeCharacter', function(data)
    TriggerServerEvent('pant-multicharacter:server:deleteCharacter', data.citizenid)
end)

function skyCam(bool)
    SetRainFxIntensity(-1.0)

    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(PlayerPedId(), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", CamCoords.x, CamCoords.y, CamCoords.z, 0.0 ,0.0, CamCoords.h, 60.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    else
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
    end
end