--[[
Script by utku#9999, this is the second part of Real Dopes script.
With this you can produce Adrenaline Shot which which you can produce required meterial from first part (utku_realdopes).
You are free to edit and alter this code anyway you want but if you want to share or sell you must ask for my permission.
This code is free to use.
Bu scrtip utku#9999 tarafından yapılmıştır. Real Dopes scriptinin ilk bölümüdür.
Bu script ile Adrenalin Şırıngasını üretebiliyorsunuz. Gerekli olan madde bir önceki partda (utku_realdopes2) elde ediliniyor.
Kodu istediğiniz gibi değiştirebilir ve üzerinde oynayabilirsiniz. Ama eğer kodu satmak veya dağıtmak istiyorsanız önce benden izin almanız gerekiyor.
Bu code tamamen ücretsizdir.
--]]
ESX = nil

local basla2 = false -- Check if production started // Üretim başlama kontrolü
local prolok = vector3(2433.97, 4968.94, 42.35)
local prohead = 42.78
local ilerleme = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() -- Draw marker when near and check if started // Marker çizme ve aktive etme
    Citizen.Wait(100)
	while true do
		local sleepThread = 200

    	for locationIndex = 1, #Config.AdrenalinLocation do
        	local locationPos = Config.AdrenalinLocation[locationIndex]
        	local ped = PlayerPedId()
        	local pedCoords = GetEntityCoords(ped)
			local dstCheck = GetDistanceBetweenCoords(pedCoords, locationPos, true)

            if dstCheck <= 6.0 and basla2 == false then -- Distane when draw // Çizim için mesafe
                sleepThread = 5
				DrawMarker(20, 2433.97, 4968.94, 42.35, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.45, 0.45, 0.45, 0.0, 0.0, 133.0, 0.0012, false, false, 2, 0, nil, nil, false)
				ESX.Game.Utils.DrawText3D({x = 2433.97, y = 4968.94, z = 42.35}, _U("marker"), 1.0)
				if dstCheck <= 1.5 then -- Distance to press // Tuşa basmak için mesafe
                    if IsControlJustReleased(0, 38) and basla2 == false then -- Check if already started and pressed "E" // Zaten başladı mı ve "E" ye bastımı kontrolü
						TriggerServerEvent("utku_realdopes2:üretim")
					end
				end
			end
        	Citizen.Wait(sleepThread)
	 	end
	end
end)

Citizen.CreateThread(function() -- Check if still near location // Hala lokasyonun yakınında mı kontrolü
    Citizen.Wait(100)
	while true do
		local sleepThread = 200

    	for locationIndex = 1, #Config.AdrenalinLocation do
        	local locationPos = Config.AdrenalinLocation[locationIndex]
        	local ped = PlayerPedId()
        	local pedCoords = GetEntityCoords(ped)
        	local dstCheck = GetDistanceBetweenCoords(pedCoords, locationPos, true)

			if dstCheck >= 6.0 and basla2 == true then  -- Distance // Uzaklık
				sleepThread = 5
				TriggerEvent("utku_realdopes2:aniDurdur") -- Activate if player leaves the area / Oyuncu alandan çıkarsa aktive olur
			end
        	Citizen.Wait(sleepThread)
	 	end
	end
end)

RegisterNetEvent("utku_realdopes2:aniDurdur") -- Stopping process if player leaves the area // Oyuncu alandan çıkmış ise üretimi durdurur
AddEventHandler("utku_realdopes2:aniDurdur", function()
	basla2 = false
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	ESX.ShowNotification(_U("leave_area"))
end)

RegisterNetEvent("utku_realdopes2:üretimBaşla")  -- Production // Üretim
AddEventHandler("utku_realdopes2:üretimBaşla", function()
	basla2 = true
	ProductionStart()
	ESX.ShowNotification(_U("prod_start"))
	ESX.ShowNotification(_U("prog") .. ilerleme .. "% ".. _U("prog0"))
	Citizen.Wait(5000)
	ilerleme = 10
	if basla2 == true then  -- Each of this checks if started true in case player has leaved the area // Her yüzdeklikte başlama true mu diye kontrol ediyor ki oyuncu lokasyonun yakınında mı hala
		ProductionStart()
		ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog1"))
		Citizen.Wait(6000)
		ilerleme = 20
		if basla2 == true then
			ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog2"))
			Citizen.Wait(8000)
			ilerleme = 30
			if basla2 == true then
				ProductionStart()
				ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog3"))
				Citizen.Wait(6000)
				ilerleme = 40
				if basla2 == true then
					ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog4"))
					Citizen.Wait(10000)
					ilerleme = 50
					if basla2 == true then
						ProductionStart()
						ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog5"))
						Citizen.Wait(12000)
						ilerleme = 60
						if basla2 == true then
							ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog6"))
							Citizen.Wait(12000)
							ilerleme = 70
							if basla2 == true then
								ProductionStart()
								ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog7"))
								Citizen.Wait(5000)
								ilerleme = 80
								if basla2 == true then
									ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog8"))
									Citizen.Wait(10000)
									ilerleme = 90
									if basla2 == true then
										ProductionStart()
										ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog9"))
										Citizen.Wait(9000)
										ilerleme = 100
										if basla2 == true then
											ESX.ShowNotification(_U("prog") .. ilerleme .. "% " .. _U("prog10"))
											Citizen.Wait(5000)
											ESX.ShowNotification(_U("prod_comp"))
											ClearPedTasks(PlayerPedId())
											FreezeEntityPosition(PlayerPedId(), false)
											basla2 = false
											TriggerServerEvent("utku_realdopes2:bitti")
											ilerleme = 0
										else
											TriggerEvent("utku_realdopes2:aniDurdur") -- Each of these are for if player leaves the are // Eğer oyuncu alan terk ederse aktive olacaklar
										end
									else
										TriggerEvent("utku_realdopes2:aniDurdur")
									end
								else
									TriggerEvent("utku_realdopes2:aniDurdur")
								end
							else
								TriggerEvent("utku_realdopes2:aniDurdur")
							end
						else
							TriggerEvent("utku_realdopes2:aniDurdur")
						end
					else
						TriggerEvent("utku_realdopes2:aniDurdur")
					end
				else
					TriggerEvent("utku_realdopes2:aniDurdur")
				end
			else
				TriggerEvent("utku_realdopes2:aniDurdur")
			end
		else
		    TriggerEvent("utku_realdopes2:aniDurdur")
		end
	else
		TriggerEvent("utku_realdopes2:aniDurdur")
	end
end)

function ProductionStart()
	local playerPed = PlayerPedId()
	Citizen.Wait(200)
	TaskStartScenarioAtPosition(playerPed, "PROP_HUMAN_BUM_BIN", prolok, prohead, 0, 0, 1)
	FreezeEntityPosition(playerPed, true)
end