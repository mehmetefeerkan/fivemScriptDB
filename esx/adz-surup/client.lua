local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }


ESX = nil
local selling = 0
local xps = 0
local sleep

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(2000)
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

Citizen.CreateThread(function ()
    while true do
        local sleep = 1000
        local player = PlayerPedId()
          for i = 1, #KVL do
             if #(GetEntityCoords(player) - KVL[i].coords) <= 2 then -- 2'yi arttırır iseniz yazıları görüş mesafesi artar
                  sleep = 7 
                  if KVL[i].type == "collecting" then
                    text = "~r~[E]~s~ 1) Fırından Hammade Al"
                    if IsControlJustReleased(0, 38) then;
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "collecting",
                            duration = 5000,
                            label = 'Hammaddeyi Topluyorsun...',
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
                                TriggerServerEvent("kvl-terzi:yuntopla", coords, k, v, i)
                            else
                                ESX.ShowNotification('İşlem iptal edildi')
                            end
                        end)
                    end
                  elseif KVL[i].type == "processing" then
                      text = "~r~[E]~s~ 2) Hammeddeyi Damıt"
                      if IsControlJustReleased(0, 38) then;
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "processing",
                            duration = 5000,
                            label = 'Hammaddeyi Damitiyorsun...',
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
                                TriggerServerEvent("kvl-terzi:yunprocess", coords, k, v, i)
                            else
                                ESX.ShowNotification('İşlem iptal edildi')
                            end
                        end)
                      end
                  elseif KVL[i].type == "fabric" then
                      text = "~r~[E]~s~ 3) Hammaddeyi Isle"
                      if IsControlJustReleased(0, 38) then;
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "fabric",
                            duration = 5000,
                            label = 'Hammadde İşleniyor',
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
                                TriggerServerEvent("kvl-terzi:kumasuret", coords, k, v, i)
                            else
                                ESX.ShowNotification('İşlem iptal edildi')
                            end
                        end)
                      end
                  elseif KVL[i].type == "gomlekdikme" then
                     text = "~r~[E]~s~ Nefret Surubu"
                     if IsControlJustReleased(0, 38) then;
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "gomlekdikme",
                            duration = 5000,
                            label = 'İksir üretiliyor',
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
                                TriggerServerEvent("kvl-terzi:gomlekdik", coords, k, v, i)
                            else
                                ESX.ShowNotification('İşlem iptal edildi')
                            end
                        end)
                     end
                  elseif KVL[i].type == "pantolondikme" then
                    text = "~r~[E]~s~ Felix Surubu"
                    if IsControlJustReleased(0, 46) then;
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "pantolondikme",
                            duration = 5000,
                            label = 'İksir üretiliyor',
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
                                TriggerServerEvent("kvl-terzi:pantolondik", coords, k, v, i)
                            else
                                ESX.ShowNotification('İşlem iptal edildi')
                            end
                        end)
                    end
                  elseif KVL[i].type == "tshirtdikme" then
                    text = "~r~[E]~s~ Unicorn Surubu"
                    if IsControlJustReleased(0, 46) then;
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "tshirtdikme",
                            duration = 5000,
                            label = 'İksir üretiliyor',
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
                                TriggerServerEvent("kvl-terzi:tshirtdik", coords, k, v, i)
                            else
                                ESX.ShowNotification('İşlem iptal edildi')
                            end
                        end)
                    end   
                end
                DrawText3D(KVL[i].coords.x, KVL[i].coords.y, KVL[i].coords.z, text or "Empty")
             end
          end
          Citizen.Wait(sleep)
      end
end)

function DrawText3D(x,y,z, text) local onScreen,_x,_y=World3dToScreen2d(x,y,z) SetTextScale(0.35, 0.35) SetTextFont(4) SetTextProportional(1) SetTextColour(255, 255, 255, 215) SetTextEntry("STRING") SetTextCentre(1) AddTextComponentString(text) DrawText(_x,_y) local factor = (string.len(text)) / 370 DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68) end

Citizen.CreateThread(function()
    
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.NPCText.x, Config.NPCText.y, Config.NPCText.z, false)
        if distance < 5 then
            sleep = 7
            DrawText3D(Config.NPCText.x, Config.NPCText.y, Config.NPCText.z, '[E] - ADEZ')
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

-- NPCText
function OpenMenu()
    local el = {}
    Citizen.Wait(100)
         if xps >= 0 and xps < 2 then -- ? Eğer xpim 0'dan büyük 2 den küçükse aşağıdaki menüyü getir.
            el = {
                {label = 'Unicorn İksiri $35', value = 'tshirt', price = 35},
                {label = 'Felix İksiri $35', value = 'pantolon', price = 35},
                {label = 'Nefret İksiri $35', value = 'gomlek', price = 35},
            }
         elseif xps >= 3 and xps < 5 then
            el = {
                {label = 'Unicorn İksiri $40', value = 'tshirt', price = 40},
                {label = 'Felix İksiri $40', value = 'pantolon', price = 40},
                {label = 'Nefret İksiri $40', value = 'gomlek', price = 40},
            }
         elseif xps >= 6 and xps < 10 then
            el = {
                {label = 'Unicorn İksiri $45', value = 'tshirt', price = 45},
                {label = 'Felix İksiri $45', value = 'pantolon', price = 45},
                {label = 'Nefret İksiri $45', value = 'gomlek', price = 45},
            }
         end
     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kvl-terzi', {
	 	title    = 'Terzi',
	 	align    = 'top-left',
	 	elements  = el
     }, function(data, menu)
        if data.current.value == "tshirt" then
            ESX.TriggerServerCallback('kvl-terzi:GetMyItems', function(items)
                if items >= 0 then
                    selling = selling + tonumber(items)
                    TriggerServerEvent('kvl-terzi:Sell', 1, selling, "tshirt", items, data.current.price)
                else
                    ESX.ShowNotification("Üstünde yeterli sayıda tshirt yok")
                end
        end, "tshirt")
        elseif data.current.value == "pantolon" then
                ESX.TriggerServerCallback('kvl-terzi:GetMyItems', function(items)
                
                selling = selling + tonumber(items)
                TriggerServerEvent('kvl-terzi:Sell', 2, selling, "pantolon", items, data.current.price)
            end, "pantolon")
         elseif data.current.value == "gomlek" then
                 ESX.TriggerServerCallback('kvl-terzi:GetMyItems', function(items)
        
                 selling = selling + tonumber(items)
                 TriggerServerEvent('kvl-terzi:Sell', 2, selling, "gomlek", items, data.current.price)
            end, "gomlek")
        end
	 end, function(data, menu)
	 	menu.close()
	 end)
end

function Chatting()
    ExecuteCommand('e kutu')
     text31("Finn : Bugün bana neler getirdin dostum?", 3)
     Citizen.Wait(1700)
     text31("Sen : Neler getirmedim diye sorsan daha iyi dostum", 3)
     Citizen.Wait(1700)
     exports["np-taskbar"]:taskBar(3000, "Pazarlık yapıyorsun")
     Citizen.Wait(300)
     OpenMenu()
     ExecuteCommand('e c')
     Citizen.Wait(400)
     text31("Finn : Bence bu fiyatta anlaşalım, sana en iyi teklifimi yaptım!", 3)
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
  