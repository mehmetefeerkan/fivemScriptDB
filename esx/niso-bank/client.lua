ESX = nil
local Atm = true

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

RegisterNetEvent("niso-bank:checkATM")
AddEventHandler("niso-bank:checkATM", function()
    if PlayerNearATM() then
        Atm = true
        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
        local LocalPlayer = ESX.GetPlayerData()
        SendNUIMessage({['action'] = "showATM"})
        -- SendNUIMessage({['action'] = "update", ["data"] = LocalPlayer})
        TriggerServerEvent("niso-bank:checkWallet")
        SetNuiFocus(true, true)
    else
        TriggerEvent("notification", "You're not near an ATM.", 2)
    end
end)

CreateThread(function()
    for k,v in pairs(Config.Banks) do
        v.blip = AddBlipForCoord(v.Location, v.Location, v.Location)
        SetBlipSprite(v.blip, v.id)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        EndTextCommandSetBlipName(v.blip)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if ESX ~= nil then
            local plyPed = PlayerPedId()
            local pos = GetEntityCoords(plyPed)

            for k,v in pairs(Config.Banks) do
                if (#(v.Location - pos) < 1) then
                    drawTxt(v.Location.x, v.Location.y, v.Location.z, "[E] Use Banks..")
                    if IsControlJustPressed(0, 38) then
                        local LocalPlayer = ESX.GetPlayerData()
                        SendNUIMessage({['action'] = "show"})
                        -- SendNUIMessage({['action'] = "update", ["data"] = LocalPlayer})
                        TriggerServerEvent("niso-bank:checkWallet")
                        print(json.encode(LocalPlayer))
                        SetNuiFocus(true, true)
                    end
                elseif (#(v.Location - pos) < 4.5) then
                    drawTxt(v.Location.x, v.Location.y, v.Location.z, "Use Banks")
                end
            end
        end
    end
end)


RegisterNetEvent("checkWallet")
AddEventHandler("checkWallet", function(bank, cash)
    local id = PlayerId()
    local Name = GetPlayerName(id)
    SendNUIMessage({["action"] = "checkWallet", ["bank"] = bank, ["cash"] = cash, ["player"] = Name}) 
end)

RegisterNetEvent("niso-bank:refreshBank")
AddEventHandler("niso-bank:refreshBank", function()
    OpenBankAccount()
end)

RegisterNetEvent("niso-bank:refreshAtm")
AddEventHandler("niso-bank:refreshAtm", function()
    OpenAtmAccount()
end)

RegisterNUICallback("doDeposit", function(data)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent("niso-bank:doQuickDeposit", data.amount)
        OpenBankAccount()
    end
end)

RegisterNUICallback("doWithdraw", function(data)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent("niso-bank:doQuickWithdraw", data.amount)
        OpenBankAccount()
    end
end)

RegisterNUICallback("doWithdrawATM", function(data)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent("niso-bank:doQuickWithdrawATM", data.amount)
        OpenAtmAccount()
    end
end)

RegisterNUICallback("closeNUI", function()
    NuiCloser()
end)

RegisterCommand("hidenui", function()
    NuiCloser()
end)

RegisterCommand("atm", function()
    TriggerEvent("niso-bank:checkATM")
end)

-- functions
function drawTxt(x, y, z, text)
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

function OpenBankAccount()
    local LocalPlayer = ESX.GetPlayerData()
    SetNuiFocus(true, true)
    SendNUIMessage({['action'] = "show"})
    SendNUIMessage({['action'] = "update", ["data"] = LocalPlayer})
    TriggerServerEvent("niso-bank:checkWallet")
end

function OpenAtmAccount()
    local LocalPlayer = ESX.GetPlayerData()
    SetNuiFocus(true, true)
    SendNUIMessage({['action'] = "showATM"})
    SendNUIMessage({['action'] = "update", ["data"] = LocalPlayer})
    TriggerServerEvent("niso-bank:checkWallet")
end

function NuiCloser()
    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())
end

function PlayerNearATM()
    for i = 1, #Config.Atms do
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 0.75, Config.Atms[i], 0, 0, 0)
        if DoesEntityExist(obj) then
            TaskTurnPedToFaceEntity(PlayerPedId(), obj, 3.0)
            return true
        end
    end
    return false
end
