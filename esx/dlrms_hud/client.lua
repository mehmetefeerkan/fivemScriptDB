ESX = nil
local ui = false

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent("esx_status:onTick") 
AddEventHandler("esx_status:onTick", function(status)
    hunger, thirst = status[1].percent, status[2].percent
end)

RegisterNetEvent('dlrms_hud:ui')
AddEventHandler('dlrms_hud:ui', function(bool)
    ui = bool   
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = 'ui',
        ui = bool
    })
end)

RegisterNUICallback('dlrms_hud:close', function()
    TriggerEvent('dlrms_hud:ui', false)
end)

RegisterCommand('hud', function()
    ui = not ui
    if ui then 
        TriggerEvent('dlrms_hud:ui', true)
    else
        TriggerEvent('dlrms_hud:ui', false)
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie('minimap')
    while not HasScaleformMovieLoaded(minimap) do
      Citizen.Wait(0)
    end

    SetMinimapComponentPosition('minimap', 'L', 'B', -0.0045, -0.008, 0.150, 0.188888)
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.020, 0.025, 0.111, 0.159)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.03, 0.017, 0.266, 0.237)

    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(500)
    SetRadarBigmapEnabled(false, false)
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        local pauseMenuOn = IsPauseMenuActive()
        local clock = GetClockHours()..':'..GetClockMinutes()
        if not pauseMenuOn then
            ESX.TriggerServerCallback('dlrms_hud:getAccounts', function(label, grade, cash, bank, dirty, society)
                SendNUIMessage({
                  action = 'details',
                    id = GetPlayerServerId(PlayerId()),
                    label = label,
                    grade = grade,
                    -- cash = cash,
                    -- bank = bank,
                    -- dirty = dirty,
                    -- society = society,
                    -- clock = clock
                })
            end)
        end
    end
end)

local bigMap = false
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local pauseMenuOn = IsPauseMenuActive()
        
        if not pauseMenuOn then 
            local ped = PlayerPedId()
            local health = GetEntityHealth(ped) - 100
            local armor = GetPedArmour(ped)
            local swim = IsPedSwimming(ped)
            local breath = IsPedSwimmingUnderWater(ped)
            local vehicle = GetVehiclePedIsIn(ped, false)
            local hungerAlert = Config.HungerAlert
            local thirstAlert = Config.ThirstAlert
            local healthAlert = Config.HealthAlert
            local armorAlert = Config.ArmorAlert

            if IsPedInVehicle(ped, vehicle, false) then
                DisplayRadar(true)
                if IsControlPressed(0, 20)then 
                    bigMap = not bigMap
                    if bigMap then 
                        SetRadarBigmapEnabled(true, false)
                    else
                        SetRadarBigmapEnabled(false, false)
                    end
                end
            else
                DisplayRadar(false)
                if breath then
                    stamina = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
                else
                    stamina = GetPlayerSprintTimeRemaining(PlayerId()) * 10
                end
            end
            
            SendNUIMessage({
                action = 'hud',
                pauseMenuOn = false,
                health = health,
                healthAlert = healthAlert,
                armor = armor,
                armorAlert = armorAlert,

                hunger = hunger,
                hungerAlert = hungerAlert,
                thirst = thirst,
                thirstAlert = thirstAlert,

                stamina = stamina,
                swim = swim,
                breath = breath,

                bigMap = bigMap,
                vehicle = vehicle
            })
        else
            SendNUIMessage({
                pauseMenuOn = true
            })
        end
        Citizen.Wait(sleep)
    end
end)