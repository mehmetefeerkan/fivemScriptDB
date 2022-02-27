local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX = nil
local sleep = 1000
local text = false

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function ()
    while true do
        sleep = 1000
        local player = PlayerPedId()
          for i = 1, #KVL do
             if #(GetEntityCoords(player) - KVL[i].coords) <= 1.5 then
                  sleep = 7
                  if KVL[i].type == "shipments" then
                    text = "~r~[E]~s~ Malzemeleri Al"             
                  elseif KVL[i].type == "processmeat" then
                      text = "~r~[E]~s~ Et Pisir"
                  elseif KVL[i].type == "processbread" then
                      text = "~r~[E]~s~ Ekmek Hazırla"
                  elseif KVL[i].type == "washmarul" then
                      text = "~r~[E]~s~ Marul Yıka"
                  elseif KVL[i].type == "cooking" then
                      text = "~r~[E]~s~ Hamburger Hazırla"
                  end
                  DrawText3D(KVL[i].coords.x, KVL[i].coords.y, KVL[i].coords.z, text or "Empty")
                  if IsControlJustReleased(0, 38) and #(GetEntityCoords(player) - KVL[i].coords) <= 1.5 then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "collecting",
                        duration = 5000,
                        label = 'Yapıyorsun...',
                        useWhileDead = false,
                        canCancel = false,
                         controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "mp_arresting",
                            anim = "a_uncuff",
                            flags = 49,
                        },
                        }, function(status)
                        if not status then
                            TriggerServerEvent('kvl-burger:Product', KVL[i].Items, KVL[i].ReqItems)
                        else
                            ESX.ShowNotification('İşlem iptal edildi')
                        end
                    end)
                end
             end
          end
          Citizen.Wait(sleep)
      end
end)

function DrawText3D(x,y,z, text) local onScreen,_x,_y=World3dToScreen2d(x,y,z) SetTextScale(0.35, 0.35) SetTextFont(4) SetTextProportional(1) SetTextColour(255, 255, 255, 215) SetTextEntry("STRING") SetTextCentre(1) AddTextComponentString(text) DrawText(_x,_y) local factor = (string.len(text)) / 370 DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68) end

Citizen.CreateThread(function()
	local coords = vector3(-1194.29, -885.977, 13.995)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 104)
	SetBlipScale(blip, 0.6)
	SetBlipColour(blip, 7)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Hamburger Dükkanı')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.NPCText.x, Config.NPCText.y, Config.NPCText.z, false)
        if distance < 5 then
            sleep = 5
            DrawText3D(Config.NPCText.x, Config.NPCText.y, Config.NPCText.z, '[E] - Sisman Jack')
            if IsControlJustPressed(0, 38) then
                Chatting()
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- NPC KISMI
Citizen.CreateThread(function()
    if Config.NPCEnable == true then
        RequestModel(Config.NPCHash)
        while not HasModelLoaded(Config.NPCHash) do
            Wait(1)
        end
    
        stanley = CreatePed(1, Config.NPCHash, Config.NPCDealer.x, Config.NPCDealer.y, Config.NPCDealer.z, Config.NPCDealer.h, false, true)
        SetBlockingOfNonTemporaryEvents(stanley, true)
        SetPedDiesWhenInjured(stanley, false)
        SetPedCanPlayAmbientAnims(stanley, true)
        SetPedCanRagdollFromPlayerImpact(stanley, false)
        SetEntityInvincible(stanley, true)
        FreezeEntityPosition(stanley, true)
        TaskStartScenarioInPlace(stanley, "WORLD_HUMAN_CLIPBOARD", 0, true);
    end
end)

function Chatting()
     TriggerEvent('CinematicCamDisplay(bool)')
     text31("Jack : Yemeğim nerede dostum", 3)
     Citizen.Wait(1700)
     text31("Sen : Burada dostum sakin ol", 3)
     Citizen.Wait(1700)
     TriggerEvent("mythic_progbar:client:progress", {
        name = "selling",
        duration = 5000,
        label = 'Paketi Teslim Ediyorsun',
        useWhileDead = false,
        canCancel = false,
         controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        --animation = {
        --    animDict = "timetable@jimmy@doorknock@",
        --    anim = "knockdoor_idle",
        --    flags = 49,
        --},
        }, function(status)
        if not status then
            OpenMenu()
        else
            ESX.ShowNotification('İşlem iptal edildi')
        end
    end)
     Citizen.Wait(1000)
     text31("Jack : Yemekler leziz görüyor adamım!", 3)
end

RegisterCommand("menufix",function()
    ESX.UI.Menu.CloseAll()
end)

text31 = function(text, duration)
    local sure = duration * 1000
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(sure, 1)
  end
  
function OpenMenu()
    local elements = {
        {label = 'Hamburgerleri Sat',   value = 'hamburger'},
        {label = 'Kapat',       value = 'closemenu'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_actions', {
        title    = 'Hamburger Satış',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'hamburger' then
            TriggerServerEvent("kvl-burger:Sell")
        elseif data.current.value == 'closemenu' then
            menu.close()
        end
    end)
end
