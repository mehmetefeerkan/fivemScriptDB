local charPed = nil
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if ESX ~= nil then
            if NetworkIsSessionStarted()  then
                TriggerEvent('mbl-mchar:client:chooseChar')
                return
            end
        end
	end
end)

Config2 = {
    PedCoords = {x = -813.97, y = 176.22, z = 76.74, h = -7.5, r = 1.0}, 
    HiddenCoords = {x = -812.23, y = 182.54, z = 76.74, h = 156.5, r = 1.0}, 
    CamCoords = {x = -814.02, y = 179.56, z = 76.74, h = 198.5, r = 1.0}, 
}

--- CODE

local choosingCharacter = false
local cam = nil

function openCharMenu(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "openUI",
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
    TriggerServerEvent('mbl-mchar:server:disconnect')
end)

RegisterNUICallback('selectCharacter', function(data)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('mbl-mchar:server:loadUserData', cData)
    openCharMenu(false)
    SetEntityAsMissionEntity(charPed, false, true)
    DeleteEntity(charPed)
end)

RegisterNetEvent('mbl-mchar:client:closeNUI')
AddEventHandler('mbl-mchar:client:closeNUI', function()
    openCharMenu(false)
end)

RegisterNetEvent('mbl-mchar:client:chooseChar')
AddEventHandler('mbl-mchar:client:chooseChar', function()
    SetNuiFocus(false, false)

    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), 296.22, -992.08, -99.0)
    Citizen.Wait(100)
    
    ShutdownLoadingScreenNui()
    DoScreenFadeOut(0)
    DoScreenFadeIn(1000)
    openCharMenu(true)
end)

function selectChar()
    openCharMenu(true)
end

RegisterNetEvent('apartments:client:setupSpawnUI')
AddEventHandler('apartments:client:setupSpawnUI', function(bool,pos,cData)
    TriggerEvent('qb-spawn:client:setupSpawns', cData, false, nil)
    TriggerEvent('qb-spawn:client:openUI', bool,pos,true)
end)

RegisterNUICallback('cDataPed', function(data)
    local cData = data.cData
	RequestModel(GetHashKey("mp_m_freemode_01"))

	while not HasModelLoaded(GetHashKey("mp_m_freemode_01")) do
	    Wait(1)
    end
    
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)

    if cData ~= nil then
        ESX.TriggerServerCallback('mbl-mchar:server:getSkin', function(model, data)
            if model ~= nil then
                model = model ~= nil and tonumber(model) or false

                if not IsModelInCdimage(model) or not IsModelValid(model) then setDefault() return end
            
                Citizen.CreateThread(function()
                    RequestModel(model)
            
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end


                    charPed = CreatePed(3, model, 392.6417, -957.502, -100.0, 100.5, false, true)
                    SetPedCanPlayAmbientAnims(charPed, true) -- değiştirmeyin / do not touch
                    TaskStartScenarioInPlace(charPed, "WORLD_HUMAN_SMOKING", 0, true)
                    
                    data = json.decode(data)
            
                    TriggerEvent('cash-clothes:client:loadPlayerClothing', data, charPed)
                end)
            else
                charPed = CreatePed(4, GetHashKey("mp_m_freemode_01"), 392.6417, -958.502, -99.50, 89.5, false, true)
            end
        end, cData.citizenid)
    else
        charPed = CreatePed(4, GetHashKey("mp_m_freemode_01"), 392.6417, -957.502, -99.50, 89.5, false, true)
    end

    Citizen.Wait(100)
    
    SetEntityHeading(charPed, 89.5)
    FreezeEntityPosition(charPed, false)
    SetEntityInvincible(charPed, true)
    PlaceObjectOnGroundProperly(charPed)
    SetBlockingOfNonTemporaryEvents(charPed, true)
end)





RegisterNUICallback('setupCharacters', function()
    ESX.TriggerServerCallback("test:yeet", function(result)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
        SetTimecycleModifier('default')
    end)
end)

RegisterNUICallback('createNewCharacter', function(data)
    local cData = data
    DoScreenFadeOut(150)
    -- if cData.gender == "man" then
    --     cData.gender = 0
    -- elseif cData.gender == "vrouw" then
    --     cData.gender = 1
    -- end

    TriggerServerEvent('mbl-mchar:server:createCharacter', cData)
    -- TriggerServerEvent('mbl-mchar:server:GiveStarterItems')
    Citizen.Wait(500)
end)

RegisterNUICallback('removeCharacter', function(data)
    if DoesEntityExist(charPed) then
        --SetEntityAsMissionEntity(charPed, true, true)
        SetPedAsNoLongerNeeded(charPed)
        DeleteEntity(charPed)
        DeletePed(charPed)
    end
    TriggerServerEvent('mbl-mchar:server:deleteCharacter', data.citizenid)
end)

function skyCam(bool)
    SetRainFxIntensity(0.0)
    -- TriggerEvent('qb-weathersync:client:DisableSync')
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(12, 0, 0)

    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(PlayerPedId(), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -813.46, 178.95, 76.85, 0.0 ,0.0, 174.5, 60.00, false, 0)
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