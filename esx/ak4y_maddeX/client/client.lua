ESX = nil

local ev = vector3(2433.28, 4968.62, 42.35)
local bilgi = "[E] MaddeX'i Kontrol Et"
local maddeAlinabilirMi = false
local markerAktifMi = true
local performansCd = 1000
local maddeXSure = 900
local blipDaireBoyutu = 137
local kontrol = false
local AK4Y = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(1)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    Citizen.Wait(1000)
    ESX.TriggerServerCallback('ak4y_maddeX:bilgi', function(alindiMi, sure, bilgi)
        if bilgi then
            TriggerEvent("ak4y_maddeX:durum", true)
        end
        esyaAlinabilir = esyaAlindiData
        maddeXSure = sure
    end)
end)

RegisterNetEvent("ak4y_maddeX:durum")
AddEventHandler("ak4y_maddeX:durum", function(durum)
    markerAktifMi = durum
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(performansCd)
        local oyuncu = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(oyuncu, ev, true) < blipDaireBoyutu then
            evdeMi(true)
            if ESX.PlayerData.job.name ~= "police" and ESX.PlayerData.job.name ~= "ambulance" and ESX.PlayerData.job.name ~= "offpolice" and ESX.PlayerData.job.name ~= "offambulance" then
                if GetDistanceBetweenCoords(oyuncu, ev, true) < 20 and markerAktifMi then
                    performansCd = 5
                    DrawMarker(2, ev.x, ev.y, ev.z-0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.5, 0.3, 255, 0, 0, 150, 0, 1, 0, 0)	
                    if GetDistanceBetweenCoords(oyuncu, ev, true) < 2 then
                        DrawText3D(ev.x, ev.y, ev.z, bilgi, 0.45)
                        if IsControlJustPressed(1, 38) then
                            ESX.TriggerServerCallback('ak4y_maddeX:bilgi', function(alindiMi, sure)
                                Citizen.Wait(math.random(1,1000))
                                if not alindiMi and not maddeAlinabilirMi and not kontrol then
                                    kontrol = true
                                    maddeXSure = sure
                                    if maddeXSure == 900 then -- !!! Süreyi değiştirirseniz server tarafındakini de değiştirin yoksa script düzgün çalışmaz!!!
                                        TriggerServerEvent("ak4y_maddeX:baslat")
                                        ESX.ShowNotification("Geri Sayım Başladı " .. ESX.Math.Round((maddeXSure/1000)/60, 2) .. " Dakika Bekle")
                                    else
                                        ESX.ShowNotification("Geri Sayım Başladı " .. ESX.Math.Round((maddeXSure/1000)/60, 2) .. " Dakika Bekle")
                                    end
                                    sureBaslat()
                                elseif not alindiMi and maddeAlinabilirMi then
                                    Citizen.Wait(math.random(1,100))
                                    maddeAlinabilirMi = false
                                    TriggerServerEvent("ak4y_maddeX:maddeAl")
                                    bilgi = "MaddeX'i Aldın"
                                    ESX.ShowNotification("MaddeX'i Aldın!")
                                    AK4Y = true
                                elseif alindiMi and not maddeAlinabilirMi and not AK4Y then
                                    bilgi = "MaddeX'i Birisi Almış"
                                end
                            end)
                        end
                    end
                end
            end
        else
            performansCd = 1000
            evdeMi(false)
        end
    end
end)

evdeMi = function(durum)
    ak4y = durum
    if ak4y and not X then
        X = true
        ESX.ShowNotification("Gergin Hissediyorsun")
        AnimpostfxPlay("MenuMGSelectionTint", 1000, true)
    elseif not ak4y and X then
        X = false
        ESX.ShowNotification("Rahatlamaya Başladın")
        AnimpostfxStop("MenuMGSelectionTint")
    end
end

sureBaslat = function()
    local ak4y = false
    while not ak4y do      
        if maddeXSure > 1 then
            maddeXSure = maddeXSure - 5000
            bilgi = ESX.Math.Round((maddeXSure/1000)/60, 2) .. " Dakika Kaldı"
        else
            ak4y = true
            maddeAlinabilirMi = true
            bilgi = "[E] MaddeX'i Al"
        end
        Citizen.Wait(5000)
    end
end

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(ev)
    SetBlipSprite(blip, 84)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.75)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Madde X")
    EndTextCommandSetBlipName(blip)
    blipDaire = AddBlipForRadius(ev, blipDaireBoyutu+0.0)
    SetBlipSprite(blipDaire, 9)
    SetBlipColour(blipDaire, 49)
    SetBlipAlpha(blipDaire, 80)
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 140)
end
