Show = false
PlayerData = {}
isLoggedIn = false
inVehicle = false
playerPed = 0
pauseMenuState, lastpauseMenuState = 0, 0
bilgiler = {}

ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
  DisplayRadar(false)
end)

local hunger = 0
local thrist = 0
local stres = 0
local sesSeviyesi = 1
local bigMap = false
local onMap = false
local minimap = nil
local cashAmount = 0
local bankAmount = 0

function UIStuff()
    Citizen.CreateThread(function()
        while isLoggedIn do
            SendNUIMessage({
                action = 'tick',
                show = IsPauseMenuActive(),
                health = (GetEntityHealth(playerPed)-100),
                armor = GetPedArmour(playerPed),
                stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
                oxy = 100 - GetPlayerUnderwaterTimeRemaining(PlayerId()),
            })
            if IsBigmapActive() or IsBigmapFull() then
				SetBigmapActive(false, false)
			end
            Citizen.Wait(200)
        end
    end)
    
    Citizen.CreateThread(function()
        minimap = RequestScaleformMovie("minimap")
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(200)
        SetRadarBigmapEnabled(false, false)

        while Show do
            Citizen.Wait(500)
            pauseMenuState = GetPauseMenuState()
            if pauseMenuState ~= lastpauseMenuState then
                lastpauseMenuState = pauseMenuState
                removeHealthBar()
            end

            playerPed = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(playerPed, false) and not IsVehicleModel(GetVehiclePedIsIn(playerPed, false), wheelchair)
            if inVehicle and not onMap then
                SetPedConfigFlag(playerPed, 35, false)
                onMap = true
                if not bigMap then DisplayRadar(true) end
                removeHealthBar()
            elseif not inVehicle and onMap then
                onMap = false
                if not bigMap then DisplayRadar(false) end
                removeHealthBar()
            end
            
        end
    end)
end

function removeHealthBar()
    BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(3)
    EndScaleformMovieMethod()
end

RegisterNetEvent('reka:hud:client:sendStatus')
AddEventHandler('reka:hud:client:sendStatus', function(data)
    SendNUIMessage({
        action = "updateStatus",
        st = {yemek = data.hunger, su = data.thirst},
    })
end)

RegisterNetEvent('ustun-hud:big-map')
AddEventHandler('ustun-hud:big-map', function(bool)
    if Show then
        if bool then
            if not inVehicle then
                bigMap = true
                DisplayRadar(true)
            end
            SendNUIMessage({action = 'hideui'})
            SetBigmapActive(true,false)
        else
            if not inVehicle then
                bigMap = false
                DisplayRadar(false)
            end
            SendNUIMessage({action = 'showui'})
            SetBigmapActive(false,false)
        end
        Citizen.Wait(10)
        removeHealthBar()
    end
end)

exports('setVoipMode', function(seviye)
    if seviye == 3.5 then
        SendNUIMessage({action = 'ses-0'})
    elseif seviye == 8.0 then
        SendNUIMessage({action = 'ses-1'})
    elseif seviye == 15.0 then
        SendNUIMessage({action = 'ses-2'})
    end
end)

--[[ local capsAktif = false
RegisterNetEvent('ustun-hud:client:caps-lock')
AddEventHandler('ustun-hud:client:caps-lock', function(status)
    if status and not capsAktif then
        capsAktif = true
        SendNUIMessage({action = 'ses-aktif-telsiz'})
    elseif not status and capsAktif then
        capsAktif = false
        SendNUIMessage({action = 'ses-pasif'})
    end
end) ]]
local normalKonusmaAktif = false
RegisterNetEvent('SaltyChat_TalkStateChanged')
AddEventHandler('SaltyChat_TalkStateChanged', function(status)
    if status and not normalKonusmaAktif then
        normalKonusmaAktif = true
        SendNUIMessage({action = 'ses-aktif'})
    elseif not status and normalKonusmaAktif then
        normalKonusmaAktif = false
        SendNUIMessage({action = 'ses-pasif'})
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    PlayerData = ESX.GetPlayerData()
    SendNUIMessage({action = 'showui'})
    isLoggedIn = true
    Show = true
    UIStuff()
    Citizen.Wait(10000)
  --  ESX.ShowNotification("/hud Yazarak Hud'u İstediğin Gibi Ayarlayabilirsin!", "primary", 15000)
end)

--RegisterCommand('hud', function()
    --TriggerEvent('ustun-hud:open-hud')
    --ESX.TriggerServerCallback('tgian-hud:getAccounts', function(accounts)
      --  cashAmount = accounts.cash
        --bankAmount = accounts.bank
    --end)
--end)

RegisterNetEvent('ustun-hud:open-hud')
AddEventHandler('ustun-hud:open-hud', function()
    if not Show then
        PlayerData = ESX.GetPlayerData()
        TriggerEvent("tgian-hud:load-data")
        SendNUIMessage({action = 'showui'})
        UIStuff()
        isLoggedIn = true
        Show = true
    end
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'showMenu'})
end)

RegisterNUICallback('close-ayar-menu', function()
    SetNuiFocus(false, false)
    --SendNUIMessage({action = 'showMenu'})
end)

RegisterNUICallback('set-emotechat', function(data)
    TriggerEvent("3dme-chat", data.status)
end)

RegisterNUICallback('fh4speed', function(data)
    TriggerEvent("fh4speed:hud", data.status)
end)

RegisterNetEvent('tgian-hud:load-data')
AddEventHandler('tgian-hud:load-data', function(health, armor)
    while not isLoggedIn do 
        Citizen.Wait(1000)
    end
    local playerPed = PlayerPedId()
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    SetPedMaxTimeUnderwater(playerPed, 80.0)
    bilgiler.yemek = exports["esx_status"]:getStatus("hunger")
    bilgiler.su = exports["esx_status"]:getStatus("thirst")
    bilgiler.zirh = GetPedArmour(playerPed)
    bilgiler.heal = GetEntityHealth(playerPed)
    SetEntityMaxHealth(playerPed, 200)
    if health then
        SetEntityHealth(playerPed, health)
        SetPedArmour(playerPed, armor)
    else
        SetEntityHealth(playerPed, bilgiler.heal)
        SetPedArmour(playerPed, bilgiler.zirh)
    end
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    oyuncuYulendi = true
end)

RegisterNetEvent('esx:onaddMoney')
AddEventHandler('esx:onaddMoney', function(money)
    cashAmount = cashAmount + money
    SendNUIMessage({
        action = "update",
        cash = cashAmount,
        bank = bankAmount,
        amount = money,
        minus = false,
        type = 'cash',
    })
end)

RegisterNetEvent('esx:onremoveMoney')
AddEventHandler('esx:onremoveMoney', function(money)
    cashAmount = cashAmount - money
    SendNUIMessage({
        action = "update",
        cash = cashAmount,
        bank = bankAmount,
        amount = money,
        minus = true,
        type = 'cash',
    })
end)