--[[
Script by utku#9999, this is the first part of Real Dopes script.
With this you can produce Epinephrine metarial which can later used for producing adrenaline shot (utku_realdopes2).
You are free to edit and alter this code anyway you want but if you want to share or sell you must ask for my permission.
This code is free to use.
-------------------------------------------------------------------------------------------------------------------------
Bu scrtip utku#9999 tarafından yapılmıştır. Real Dopes scriptinin ilk bölümüdür.
Bu script ile Efinerfin maddesini üretebiliyorsunuz. Bu madde daha sonra adrenalin iğnesi (utku_realdopes2) yapımında kullanılıyor.
Kodu istediğiniz gibi değiştirebilir ve üzerinde oynayabilirsiniz. Ama eğer kodu satmak veya dağıtmak istiyorsanız önce benden izin almanız gerekiyor.
Bu code tamamen ücretsizdir.
--]]
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
-- Don't edit this if you don't know what you're doing. // Ne yaptığınızı bilmiyorsanız bunlarla oynamayın. --
local basla = false -- Control of wether production has started or not. // Üretim başladı mı başlamadı mı kontrolü.
local ilerleme = 0 -- Progression // Kaydedilen ilerleme.
local dur = false -- Stop check // Durma kontrolü.
local secim = 0 -- Selection check // Seçim kontrolü.
local kalite = 0 -- Quality of product which later transformed to number of given items. // Maddenin kalitesi, sonradan oyuncuya verilecek item sayısınıa dönüştürülür.
local durDmg = true
local itemVarFlor = false
local itemVarGas = false
local itemVarPhone = false
local itemVarParca = false
local itemVarBlow = false
local itemVarSiringa = false
local itemVarLith = false
local itemVarSu = false
local itemVarAseton = false
Uretimlokasyon = vector3(1443.23, 6332.05, 23.98)
Uretimheading = 177.48
Damitmalokasyon = vector3(1443.025, 6332.24, 22.98)
Damitmaheading = 159.53

ESX = nil

local LastPlayerPed

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() -- To check if you are close enough to marker so that marker can be drawn // Markera yakınlığınızı ölçüp ona göre spawnlıyor.
    Citizen.Wait(100)
	while true do
		local sleepThread = 200
    	for locationIndex = 1, #Config.ProductionLocations do
        	local locationPos = Config.ProductionLocations[locationIndex]

        	local ped = PlayerPedId()
        	local pedCoords = GetEntityCoords(ped)
        	local dstCheck = GetDistanceBetweenCoords(pedCoords, locationPos, true)
            	if dstCheck <= 6.0 and basla == false then  -- distance // uzaklık
                	sleepThread = 5
					DrawMarker(20, 1443.61, 6332.17, 24.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.45, 0.45, 0.45, 133.0, 0.0, 0.0, 0.0012, false, false, 2, 0, nil, nil, false)
					ESX.Game.Utils.DrawText3D({x = 1443.61, y = 6332.17, z = 24.20}, _U("epi_marker"), 1.0)
					if dstCheck <= 1.5 then  -- start distance // başlama uzaklığı
                        if IsControlJustReleased(0, 38) and basla == false then
							TriggerServerEvent("utku_realdopes:üretim")
						end
					end
				end
        	Citizen.Wait(sleepThread)
	 	end
	end
end)

Citizen.CreateThread(function() -- Check if player is alive // Oyuncu hayatta mı kontrolü
	while true do
		Citizen.Wait(300)
		while basla and IsPlayerDead() == true do
			Citizen.Wait(100)
			TriggerEvent('utku_realdopes:dur')
		end
	end
end)

Citizen.CreateThread(function() -- To check if you remain in the area // Üretim boyunca hala alanda mısınız kontrolü
    Citizen.Wait(100)
	while true do
		local sleepThread = 200
    	for locationIndex = 1, #Config.ProductionLocations do
        	local locationPos = Config.ProductionLocations[locationIndex]

        	local ped = PlayerPedId()
        	local pedCoords = GetEntityCoords(ped)
        	local dstCheck = GetDistanceBetweenCoords(pedCoords, locationPos, true)
            	if dstCheck > 6.0 and basla == true then  -- area distance // alanın uzaklığı
					sleepThread = 5
					TriggerEvent("utku_realdopes:aniDurdur")
				end
        	Citizen.Wait(sleepThread)
	 	end
	end
end)

Citizen.CreateThread(function() -- Apply dmg to player when certain event starts // Belirli bir olay başlayınca oyuncuya hasar ver
	Citizen.Wait(150)
	while true do
		Citizen.Wait(150)
		while durDmg == false and basla == true do
			Citizen.Wait(150)
			ApplyDamageToPed(PlayerPedId(), 1, false)
			Citizen.Wait(280)
		end
	end
end)

Citizen.CreateThread(function()  -- Production // Üretim
	while true do
		Citizen.Wait(10)

		local playerPed = PlayerPedId()
		local pos = GetEntityCoords(PlayerPedId())

		if basla == true and IsPlayerDead() == false then

			if ilerleme < 96 then
				-- TriggerEvent('utku_realdopes:dumanKüçük', "proj_grenade_smoke", 2, 1.0, 1.0)
				Citizen.Wait(6000)
				if not dur then
					ilerleme = ilerleme +  1  -- Progress add on start and after every event // Başlangıçta ve her olaydan sonra ilerlemeye eklenecek değer.
					ESX.ShowNotification(_U("prod") .. ilerleme .. '%')
					Citizen.Wait(6000)
				end
				--
				--   EVENT 1 // OLAY 1
				--
				if ilerleme > 20 and ilerleme < 25 then
					dur = true

					if secim == 0 then
						ESX.ShowNotification(_U("event1"))
						ESX.ShowNotification(_U("e1_o1"))
						ESX.ShowNotification(_U("e1_o2"))
						ESX.ShowNotification(_U("e1_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "phone")
						Citizen.Wait(100)
						if itemVarPhone then
							ClearPedTasks(playerPed)
							Citizen.Wait(400)
							FreezeEntityPosition(playerPed, true)
							TaskStartScenarioAtPosition(playerPed, "WORLD_HUMAN_STAND_MOBILE", Uretimlokasyon, Uretimheading, 0, 0, 1)
							Citizen.Wait(6000)
							ClearPedTasks(playerPed)

							RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
							while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
								Citizen.Wait(100)
							end
							SetEntityCoords(playerPed, Damitmalokasyon, 0, 0, 0, 1)
							SetEntityHeading(playerPed, Damitmaheading)
							TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
							Citizen.Wait(5000)
							ClearPedTasks(playerPed)
							local sans = math.random(1, 100)

							if sans <= 85 then -- Chanse of success(default = %85) // Başarılı olma şansı (varsayılan = %85)
								ESX.ShowNotification(_U("e1_a1_1"))
								ProductionLocation()
								kalite = kalite - 1
								dur = false
								itemVarPhone = false
							else
								ESX.ShowNotification(_U("e1_a1_2"))
								Citizen.Wait(3000)
								kalite = 0
								basla = false
								ApplyDamageToPed(PlayerPedId(), 110, false) -- Player dmg in case explosion is not enough. // Patlama yetmez diye oyuncuya hasar.
								TriggerServerEvent('utku_realdopes:patla', pos.x, pos.y, pos.z) -- Explosion // Patlama
							end
						else
							ESX.ShowNotification(_U("e1_a1_3"))
							secim = 0
						end
					end
					if secim == 2 then
						ESX.ShowNotification(_U("e1_a2"))
						Citizen.Wait(3000)
						kalite = 0
						basla = false
						ApplyDamageToPed(PlayerPedId(), 110, false) -- Player dmg in case explosion is not enough. // Patlama yetmez diye oyuncuya hasar.
						TriggerServerEvent('utku_realdopes:patla', pos.x, pos.y, pos.z) -- Explosion // Patlama
					end
					if secim == 3 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "spare_parts")
						Citizen.Wait(100)
						if itemVarParca == true then
							RequestAnimDict("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@")
							while not HasAnimDictLoaded("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@") do
								Citizen.Wait(100)
							end
							ClearPedTasks(playerPed)
							Citizen.Wait(200)
							SetEntityCoords(playerPed, 1442.97, 6331.77, 22.98, 0, 0, 0, 1)
							SetEntityHeading(playerPed, Damitmaheading)
							TaskPlayAnim(playerPed, "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_vertical", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
							Citizen.Wait(1500)
							ClearPedTasks(playerPed)
							ProductionLocation()
							ESX.ShowNotification(_U("e1_a3_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "spare_parts", 1)
							dur = false
							kalite = kalite + 4
							itemVarParca = false
						else
							ESX.ShowNotification(_U("e1_a3_2"))
							secim = 0
						end
					end
				end
				--
				--  EVENT 2 // OLAY 2
				--
				if ilerleme > 26 and ilerleme < 31 then
					dur = true
					if secim == 0 then
						TriggerEvent('utku_realdopes:dumanZehirli', "veh_respray_smoke")
						durDmg = false -- Start applying dmg // Dmg atmaya başla
						ESX.ShowNotification(_U("event2"))
						ESX.ShowNotification(_U("e2_o1"))
						ESX.ShowNotification(_U("e2_o2"))
						ESX.ShowNotification(_U("e2_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						TriggerServerEvent('utku_realdopes:itemKontrol', "fluor_stick")
						Citizen.Wait(100)
						if itemVarFlor == true then
							TriggerServerEvent("utku_realdopes:itemSil", "fluor_stick", 1)
							ClearPedTasks(playerPed)
							Citizen.Wait(400)
							FreezeEntityPosition(playerPed, true)
							TaskStartScenarioAtPosition(playerPed, "WORLD_HUMAN_CAR_PARK_ATTENDANT", Uretimlokasyon, Uretimheading, 0, 0, 1)
							Citizen.Wait(8000)
							ClearPedTasks(playerPed)
							ProductionLocation()
							StopParticleFxLooped(Smoke2, 0)
							durDmg = true -- Stop dmg // Dmg durdur
							ESX.ShowNotification(_U("e2_a1_1"))
							kalite = kalite - 1
							dur = false
						else
							ESX.ShowNotification(_U("e2_a1_2"))
							secim = 0
						end
					end
					if secim == 2 then
						RequestAnimDict("timetable@gardener@smoking_joint")
						while not HasAnimDictLoaded("timetable@gardener@smoking_joint") do
							Citizen.Wait(100)
						end
						ClearPedTasks(playerPed)
						Citizen.Wait(200)
						SetEntityCoords(playerPed, 1443.23, 6332.05, 22.98, 0, 0, 0, 1)
						SetEntityHeading(playerPed, Uretimheading)
						TaskPlayAnim(playerPed, "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
						Citizen.Wait(3000)
						ClearPedTasks(playerPed)
						ProductionLocation()
						ESX.ShowNotification(_U("e2_a2"))
						dur = false
						TriggerEvent('utku_realdopes:uyuştu')
					end
					if secim == 3 then
						TriggerServerEvent('utku_realdopes:itemKontrol', "gas_mask")
						Citizen.Wait(100)
						if itemVarGas then
							TriggerServerEvent("utku_realdopes:itemSil", "gas_mask", 1)
							RequestAnimDict("clothingspecs")
							while not HasAnimDictLoaded("clothingspecs") do
								Citizen.Wait(100)
							end
							ClearPedTasks(playerPed)
							Citizen.Wait(200)
							SetEntityCoords(playerPed, 1443.23, 6332.05, 22.98, 0, 0, 0, 1)
							SetEntityHeading(playerPed, Uretimheading)
							TaskPlayAnim(playerPed, "clothingspecs", "put_on", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0) -- Sorry couldn't find a better anim // Daha iyi animasyon bulamadım
							Citizen.Wait(2000)
							SetPedPropIndex(playerPed, 1, 26, 7, true)
							ClearPedTasks(playerPed)
							ProductionLocation()
							durDmg = true -- Stop dmg // Dmg durdur
							ESX.ShowNotification(_U("e2_a3_1"))
							dur = false
						end
						if itemVarGas == false then
							ESX.ShowNotification(_U("e2_a3_2"))
							secim = 0
						end
					end
				end
				--
				--   EVENT 3 // OLAY 3
				--
				if ilerleme > 33 and ilerleme < 38 then
					dur = true
					if secim == 0 then
						ESX.ShowNotification(_U("event3"))
						ESX.ShowNotification(_U("e3_o1"))
						ESX.ShowNotification(_U("e3_o2"))
						ESX.ShowNotification(_U("e3_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						ESX.ShowNotification(_U("e3_a1"))
						kalite = kalite - 2
						Citizen.Wait(1000)
						dur = false
					end
					if secim == 2 then
						ESX.ShowNotification(_U("e3_a2"))
						kalite = kalite + 3
						Citizen.Wait(1000)
						dur = false
					end
					if secim == 3 then
						ESX.ShowNotification(_U("e3_a3"))
						dur = false
						Citizen.Wait(1000)
						kalite = kalite - 4
					end
				end
				--
				--   EVENT 4 // OLAY 4
				--
				if ilerleme > 40 and ilerleme < 45 then
					dur = true
					if secim == 0 then
						ESX.ShowNotification(_U("event4"))
						ESX.ShowNotification(_U("e4_o1"))
						ESX.ShowNotification(_U("e4_o2"))
						ESX.ShowNotification(_U("e4_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						ESX.ShowNotification(_U("e4_a1"))
						kalite = kalite - 2
						dur = false
					end
					if secim == 2 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "syringe")
						Citizen.Wait(100)
						if itemVarSiringa then
							ESX.ShowNotification(_U("e4_a2_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "syringe", 1)
							dur = false
							kalite = kalite - 1
						else
							ESX.ShowNotification(_U("e4_a2_2"))
							secim = 0
						end
					end
					if secim == 3 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "lithium")
						Citizen.Wait(100)
						if itemVarLith then
							Citizen.Wait(4000)
							ESX.ShowNotification(_U("e4_a3_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "lithium", 5)
							dur = false
							kalite = kalite + 3
						else
							ESX.ShowNotification(_U("e4_a3_2"))
							secim = 0
						end
					end
				end
				--
				--   EVENT 5 // OLAY 5
				--
				if ilerleme > 47 and ilerleme < 53 then
					dur = true
					if secim == 0 then
						ESX.ShowNotification(_U("event5"))
						ESX.ShowNotification(_U("e5_o1"))
						ESX.ShowNotification(_U("e5_o2"))
						ESX.ShowNotification(_U("e5_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						ESX.ShowNotification(_U("e5_a1"))
						kalite = kalite -1
						dur = false
					end
					if secim == 2 then
						ESX.ShowNotification(_U("e5_a2"))
						kalite = kalite + 2
						dur = false
					end
					if secim == 3 then
						ClearPedTasks(playerPed)
						ClearPedSecondaryTask(playerPed)
						Citizen.Wait(1000)
						FreezeEntityPosition(playerPed, false)
						local prop_name ='prop_energy_drink'
						local player = PlayerPedId()
						local x,y,z = table.unpack(GetEntityCoords(player))
						local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
						local boneIndex = GetPedBoneIndex(player, 18905)
						AttachEntityToEntity(prop, player, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
						Citizen.Wait(500)
						ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
							Citizen.Wait(100)
							TaskPlayAnim(player, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true) -- For some reason anim doesn't work properly, it was working before, I couldn't figure it out // Animasyonda sıkıntı var, daha önce çalışıyordu, sorunu çözemedim
							Citizen.Wait(3000)
							ClearPedSecondaryTask(player)
							DeleteObject(prop)
						end)
						FreezeEntityPosition(playerPed, true)
						ProductionLocation()
						ESX.ShowNotification(_U("e5_a3"))
						dur = false
					end
				end
				--
				--   EVENT 6 // OLAY 6
				--
				if ilerleme > 55 and ilerleme < 60 then
					dur = true
					if secim == 0 then
						ESX.ShowNotification(_U("event6"))
						ESX.ShowNotification(_U("e6_o1"))
						ESX.ShowNotification(_U("e6_o2"))
						ESX.ShowNotification(_U("e6_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "gas_pump")
						Citizen.Wait(100)
						if itemVarBlow == true then
							ClearPedTasks(playerPed)
							Citizen.Wait(400)
							FreezeEntityPosition(playerPed, true)
							TaskStartScenarioAtPosition(playerPed, "WORLD_HUMAN_GARDENER_LEAF_BLOWER", Uretimlokasyon, Damitmaheading, 0, 0, 1)
							Citizen.Wait(5000)
							ClearAllPedProps(playerPed)
							Citizen.Wait(1000)
							local sans = math.random(1, 100)

							if sans <= 60 then -- Chanse of success (default = %60) // Başarılı olma şansı (varsayılan = %60)
								ClearAreaOfObjects(Uretimlokasyon, 20, 0)
								Citizen.Wait(500)
								ProductionLocation()
								ESX.ShowNotification(_U("e6_a1_2"))
								kalite = kalite + 1
								dur = false
							else
								TriggerEvent('utku_realdopes:karışımSaçılma')
								ClearAreaOfObjects(Uretimlokasyon, 20, 0)
								Citizen.Wait(500)
								ApplyDamageToPed(PlayerPedId(), 25, false)
								ESX.ShowNotification(_U("e6_a1_1"))
								Citizen.Wait(1000)
								ProductionLocation()
								kalite = kalite - 2
								dur = false
							end
						else
							ESX.ShowNotification(_U("e6_a1_3"))
							secim = 0
						end
					end
					if secim == 2 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "spare_parts")
						Citizen.Wait(100)
						if itemVarParca == true then
							RequestAnimDict("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@")
							while not HasAnimDictLoaded("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@") do
								Citizen.Wait(100)
							end
							ClearPedTasks(playerPed)
							Citizen.Wait(200)
							SetEntityCoords(playerPed, 1442.97, 6331.77, 22.98, 0, 0, 0, 1)
							SetEntityHeading(playerPed, Damitmaheading)
							TaskPlayAnim(playerPed, "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_vertical", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
							Citizen.Wait(1500)
							ClearPedTasks(playerPed)
							ProductionLocation()
							ESX.ShowNotification(_U("e6_a2_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "spare_parts", 1)
							dur = false
							kalite = kalite + 4
							itemVarParca = false
						else
							ESX.ShowNotification(_U("e6_a2_2"))
							secim = 0
						end
					end
					if secim == 3 then
						ClearPedTasks(playerPed)
						Citizen.Wait(400)
						FreezeEntityPosition(playerPed, true)
						RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
						while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
							Citizen.Wait(100)
						end
						SetEntityCoords(playerPed, Damitmalokasyon, 0, 0, 0, 1)
						SetEntityHeading(playerPed, Damitmaheading)
						TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
						Citizen.Wait(5000)
						ClearPedTasks(playerPed)
						local sans = math.random(1, 100)

						if sans <= 35 then -- Chanse of success (default = %35) // Başarılı olma şansı (varsayılan = %35)
							ESX.ShowNotification(_U("e6_a3_1"))
							ProductionLocation()
							kalite = kalite - 1
							dur = false
							itemVarPhone = false
						else
							ESX.ShowNotification(_U("e6_a3_2"))
							Citizen.Wait(3000)
							ESX.ShowNotification(_U("e6_a3_3"))
							-- TriggerEvent("utku_realdopes:dumanKüçük", "ent_amb_fbi_smoke_linger_hvy", 1, 0.5, 0.7)
							Citizen.Wait(7000)
							kalite = 0
							basla = false
							ApplyDamageToPed(PlayerPedId(), 110, false) -- Player dmg in case explosion is not enough. // Patlama yetmez diye oyuncuya hasar.
							TriggerServerEvent('utku_realdopes:patla', pos.x, pos.y, pos.z) -- Explosion // Patlama
							StopParticleFxLooped(Smoke, 0)
						end
					end
				end
				--
				--   EVENT 7 (COPY) // OLAY 7 (KOPYA)
				--
				if ilerleme > 62 and ilerleme < 67 then
					dur = true
					if secim == 0 then
						ESX.ShowNotification(_U("event7"))
						ESX.ShowNotification(_U("e1_o1"))
						ESX.ShowNotification(_U("e1_o2"))
						ESX.ShowNotification(_U("e1_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "phone")
						Citizen.Wait(100)
						if itemVarPhone then
							ClearPedTasks(playerPed)
							Citizen.Wait(400)
							FreezeEntityPosition(playerPed, true)
							TaskStartScenarioAtPosition(playerPed, "WORLD_HUMAN_STAND_MOBILE", Uretimlokasyon, Uretimheading, 0, 0, 1)
							Citizen.Wait(6000)
							ClearPedTasks(playerPed)

							RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
							while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
								Citizen.Wait(100)
							end
							SetEntityCoords(playerPed, Damitmalokasyon, 0, 0, 0, 1)
							SetEntityHeading(playerPed, Damitmaheading)
							TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
							Citizen.Wait(5000)
							ClearPedTasks(playerPed)
							local sans = math.random(1, 100)

							if sans <= 85 then
								ESX.ShowNotification(_U("e1_a1_1"))
								ProductionLocation()
								kalite = kalite - 1
								dur = false
								itemVarPhone = false
							else
								ESX.ShowNotification(_U("e1_a1_2"))
								Citizen.Wait(3000)
								kalite = 0
								basla = false
								ApplyDamageToPed(PlayerPedId(), 110, false) -- Player dmg in case explosion is not enough. // Patlama yetmez diye oyuncuya hasar.
								TriggerServerEvent('utku_realdopes:patla', pos.x, pos.y, pos.z) -- Explosion // Patlama
							end
						else
							ESX.ShowNotification(_U("e1_a1_3"))
							secim = 0
						end
					end
					if secim == 2 then
						ESX.ShowNotification(_U("e1_a2"))
						TriggerServerEvent('utku_realdopes:patla', pos.x, pos.y, pos.z)
						kalite = 0
						basla = false
						ApplyDamageToPed(PlayerPedId(), 10, false)
					end
					if secim == 3 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "spare_parts")
						Citizen.Wait(100)
						if itemVarParca == true then
							RequestAnimDict("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@")
							while not HasAnimDictLoaded("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@") do
								Citizen.Wait(100)
							end
							ClearPedTasks(playerPed)
							Citizen.Wait(200)
							SetEntityCoords(playerPed, 1442.97, 6331.77, 22.98, 0, 0, 0, 1)
							SetEntityHeading(playerPed, Damitmaheading)
							TaskPlayAnim(playerPed, "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_vertical", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
							Citizen.Wait(1500)
							ClearPedTasks(playerPed)
							ProductionLocation()
							ESX.ShowNotification(_U("e1_a3_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "spare_parts", 1)
							dur = false
							kalite = kalite + 4
							itemVarParca = false
						else
							ESX.ShowNotification(_U("e1_a3_2"))
							secim = 0
						end
					end
				end
				--
				--   EVENT 8 (COPY) // OLAY 8 (KOPYA)
				--
				if ilerleme > 69 and ilerleme < 75 then
					dur = true
					if secim == 0 then
						ESX.ShowNotification(_U("event8"))
						ESX.ShowNotification(_U("e6_o1"))
						ESX.ShowNotification(_U("e6_o2"))
						ESX.ShowNotification(_U("e6_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "gas_pump")
						Citizen.Wait(100)
						if itemVarBlow == true then
							ClearPedTasks(playerPed)
							Citizen.Wait(400)
							FreezeEntityPosition(playerPed, true)
							TaskStartScenarioAtPosition(playerPed, "WORLD_HUMAN_GARDENER_LEAF_BLOWER", Uretimlokasyon, Damitmaheading, 0, 0, 1)
							Citizen.Wait(5000)
							ClearAllPedProps(playerPed)
							Citizen.Wait(1000)
							local sans = math.random(1, 100)

							if sans <= 60 then
								ClearAreaOfObjects(Uretimlokasyon, 20, 0)
								Citizen.Wait(500)
								ProductionLocation()
								ESX.ShowNotification(_U("e6_a1_2"))
								kalite = kalite + 1
								dur = false
							else
								TriggerEvent('utku_realdopes:karışımSaçılma')
								ClearAreaOfObjects(Uretimlokasyon, 20, 0)
								Citizen.Wait(500)
								ApplyDamageToPed(PlayerPedId(), 25, false)
								ESX.ShowNotification(_U("e6_a1_1"))
								Citizen.Wait(1000)
								ProductionLocation()
								kalite = kalite - 2
								dur = false
							end
						else
							ESX.ShowNotification(_U("e6_a1_3"))
							secim = 0
						end
					end
					if secim == 2 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "spare_parts")
						Citizen.Wait(100)
						if itemVarParca == true then
							RequestAnimDict("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@")
							while not HasAnimDictLoaded("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@") do
								Citizen.Wait(100)
							end
							ClearPedTasks(playerPed)
							Citizen.Wait(200)
							SetEntityCoords(playerPed, 1442.97, 6331.77, 22.98, 0, 0, 0, 1)
							SetEntityHeading(playerPed, Damitmaheading)
							TaskPlayAnim(playerPed, "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_vertical", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
							Citizen.Wait(1500)
							ClearPedTasks(playerPed)
							ProductionLocation()
							ESX.ShowNotification(_U("e6_a2_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "spare_parts", 1)
							dur = false
							kalite = kalite + 4
							itemVarParca = false
						else
							ESX.ShowNotification(_U("e6_a2_2"))
							secim = 0
						end
					end
					if secim == 3 then
						ClearPedTasks(playerPed)
						Citizen.Wait(400)
						FreezeEntityPosition(playerPed, true)
						RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
						while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
							Citizen.Wait(100)
						end
						SetEntityCoords(playerPed, Damitmalokasyon, 0, 0, 0, 1)
						SetEntityHeading(playerPed, Damitmaheading)
						TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
						Citizen.Wait(5000)
						ClearPedTasks(playerPed)
						local sans = math.random(1, 100)

						if sans <= 35 then
							ESX.ShowNotification(_U("e6_a3_1"))
							ProductionLocation()
							kalite = kalite - 1
							dur = false
							itemVarPhone = false
						else
							ESX.ShowNotification(_U("e6_a3_2"))
							Citizen.Wait(3000)
							ESX.ShowNotification(_U("e6_a3_3"))
							-- TriggerEvent("utku_realdopes:dumanKüçük", "ent_amb_fbi_smoke_linger_hvy", 1, 0.5, 0.7)
							Citizen.Wait(7000)
							kalite = 0
							basla = false
							ApplyDamageToPed(PlayerPedId(), 110, false) -- Player dmg in case explosion is not enough. // Patlama yetmez diye oyuncuya hasar.
							TriggerServerEvent('utku_realdopes:patla', pos.x, pos.y, pos.z) -- Explosion // Patlama
							StopParticleFxLooped(Smoke, 0)
						end
					end
				end
				--
				--   EVENT 9 // OLAY 9
				--
				if ilerleme > 77 and ilerleme < 83 then
					dur = true
					if secim == 0 then
						ESX.ShowNotification(_U("event9"))
						ESX.ShowNotification(_U("e4_o1"))
						ESX.ShowNotification(_U("e4_o2"))
						ESX.ShowNotification(_U("e9_o3"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						ESX.ShowNotification(_U("e4_a1"))
						kalite = kalite - 3
						dur = false
					end
					if secim == 2 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "syringe")
						Citizen.Wait(100)
						if itemVarSiringa then
							ESX.ShowNotification(_U("e4_a2_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "syringe", 1)
							dur = false
							kalite = kalite - 1
						else
							ESX.ShowNotification(_U("e4_a2_2"))
							secim = 0
						end
					end
					if secim == 3 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "acetone")
						Citizen.Wait(100)
						if itemVarAseton then
							Citizen.Wait(4000)
							ESX.ShowNotification(_U("e4_a3_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "acetone", 5)
							dur = false
							kalite = kalite + 3
						else
							ESX.ShowNotification(_U("e4_a3_2"))
							secim = 0
						end
					end
				end
				--
				--   EVENT 10 // OLAY 10
				--
				if ilerleme > 85 and ilerleme < 95 then
					dur = true
					if secim == 0 then
						ESX.ShowNotification(_U("event10"))
						ESX.ShowNotification(_U("e10_o1"))
						ESX.ShowNotification(_U("e10_o2"))
						ESX.ShowNotification(_U("use_number"))
					end
					if secim == 1 then
						TriggerServerEvent("utku_realdopes:itemKontrol", "water")
						Citizen.Wait(100)
						if itemVarSu then
							ESX.ShowNotification(_U("e10_a1_1"))
							TriggerServerEvent("utku_realdopes:itemSil", "water", 5)
							kalite = kalite + 1
							dur = false
						else
							ESX.ShowNotification(_U("e10_a1_2"))
							secim = 0
						end
					end
					if secim == 2 then
						ESX.ShowNotification(_U("e10_a2"))
						dur = false
						kalite = kalite + 2
					end
				end

				if dur == false and IsPlayerDead() == false then
						secim = 0
						kalite = kalite + 2
						ilerleme = ilerleme +  6 -- Progress add after each event // Her olay sonrasında ilerleme eklemesi
						ESX.ShowNotification(_U("prod") .. ilerleme .. '%')
				end
			else
				TriggerEvent('utku_realdopes:dur')
				ilerleme = 100
				ESX.ShowNotification(_U("prod") .. ilerleme .. '%')
				ESX.ShowNotification(_U("prod_comp"))
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				Citizen.Wait(10)
				ilerleme = 0
				TriggerServerEvent('utku_realdopes:finish', kalite) -- Quality call // Kalite çağrısı
				kalite = 0
				basla = false
				StopParticleFxLooped(Smoke, 0)
			end

		end
	end
	end)

    Citizen.CreateThread(function() -- Selection check // Seçim kontrolü
        while true do
            Citizen.Wait(10)
            if dur == true then
                if IsControlJustReleased(0, Keys['1']) then
                    secim = 1
                    ESX.ShowNotification(_U("sel1"))
                end
                if IsControlJustReleased(0, Keys['2']) then
                    secim = 2
                    ESX.ShowNotification(_U("sel2"))
                end
                if IsControlJustReleased(0, Keys['3']) then
                    secim = 3
                    ESX.ShowNotification(_U("sel3"))
                end
            end

        end

end)

function ProductionLocation()
	local playerPed = PlayerPedId()
	Citizen.Wait(200)
	TaskStartScenarioAtPosition(playerPed, "PROP_HUMAN_BUM_BIN", Uretimlokasyon, Uretimheading, 0, 0, 1)
	FreezeEntityPosition(playerPed, true)
end
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function Splash1()
	RequestNamedPtfxAsset("core")
	while not HasNamedPtfxAssetLoaded("core") do
		Citizen.Wait(10)
	end
	local count = 0
    repeat
    SetPtfxAssetNextCall("core")
	local effectSplash = StartParticleFxLoopedAtCoord("liquid_splash_blood", 1442.55, 6331.3, 24.50, 0.0, 0.0, 0.0, 6.0, false, false, false, false)
    SetParticleFxLoopedAlpha(effectSplash, 1.0)
    SetParticleFxLoopedColour(effectSplash, 0.0, 191.0, 0.0, 0)
    Citizen.Wait(200)
    StopParticleFxLooped(effectSplash, 0)
	count = count + 1
	until count == 20
end
function Splash2()
	RequestNamedPtfxAsset("core")
	while not HasNamedPtfxAssetLoaded("core") do
		Citizen.Wait(10)
	end
	local count = 0
    repeat
    SetPtfxAssetNextCall("core")
	local effectSplash = StartParticleFxLoopedAtCoord("liquid_splash_pee", 1442.55, 6331.3, 24.50, 0.0, 0.0, 0.0, 6.0, false, false, false, false)
    SetParticleFxLoopedAlpha(effectSplash, 1.0)
    SetParticleFxLoopedColour(effectSplash, 0.0, 191.0, 0.0, 0)
    Citizen.Wait(200)
    StopParticleFxLooped(effectSplash, 0)
	count = count + 1
	until count == 20
end
RegisterNetEvent("utku_realdopes:itemKontrolSonuç")
AddEventHandler("utku_realdopes:itemKontrolSonuç", function(kontrol, item)
	if item == "gas_mask" then
		if kontrol then
			itemVarGas = true
		else
			itemVarGas = false
		end
	end
	if item == "fluor_stick" then
		if kontrol then
			itemVarFlor = true
		else
			itemVarFlor = false
		end
	end
	if item == "phone" then
		if kontrol then
			itemVarPhone = true
		else
			itemVarPhone = false
		end
	end
	if item == "spare_parts" then
		if kontrol then
			itemVarParca = true
		else
			itemVarParca = false
		end
	end
	if item == "gas_pump" then
		if kontrol then
			itemVarBlow = true
		else
			itemVarBlow = false
		end
	end
	if item == "syringe" then
		if kontrol then
			itemVarSiringa = true
		else
			itemVarSiringa = false
		end
	end
	if item == "lithium" then
		if kontrol then
			itemVarLith = true
		else
			itemVarLith = false
		end
	end
	if item == "water" then
		if kontrol then
			itemVarSu = true
		else
			itemVarSu = false
		end
	end
	if item == "acetone" then
		if kontrol then
			itemVarAseton = true
		else
			itemVarAseton = false
		end
	end
end)
RegisterNetEvent('utku_realdopes:dumanKüçük')
AddEventHandler('utku_realdopes:dumanKüçük', function(effect, times, radius, alpha)
	RequestNamedPtfxAsset("core")
	while not HasNamedPtfxAssetLoaded("core") do
		Citizen.Wait(10)
	end
	SetPtfxAssetNextCall("core")
	local count = 0
	repeat
		Smoke = StartParticleFxLoopedAtCoord(effect, 1442.55, 6331.3, 24.50, 0.0, 0.0, 0.0, radius, false, false, false, false)
		SetParticleFxLoopedAlpha(Smoke, alpha)
		SetParticleFxLoopedColour(Smoke, 255.0, 255.0, 255.0, 0)
		Citizen.Wait(3000)
		count = count + 1
	until count == times
	StopParticleFxLooped(Smoke, 0)
end)
RegisterNetEvent('utku_realdopes:dumanZehirli')
AddEventHandler('utku_realdopes:dumanZehirli', function(effect)
	RequestNamedPtfxAsset("core")
	while not HasNamedPtfxAssetLoaded("core") do
		Citizen.Wait(10)
	end
	SetPtfxAssetNextCall("core")
	local countZehir = 0
	repeat
		Smoke2 = StartParticleFxLoopedAtCoord(effect, 1442.55, 6331.3, 24.50, 0.0, 0.0, 0.0, 0.50, false, false, false, false)
		SetParticleFxLoopedAlpha(Smoke2, 0.15)
		SetParticleFxLoopedColour(Smoke2, 255.0, 255.0, 255.0, 0)
		Citizen.Wait(5000)
		countZehir = countZehir + 1
	until countZehir == 3
	StopParticleFxLooped(Smoke2, 0)
end)
RegisterNetEvent('utku_realdopes:uyuştu')
AddEventHandler('utku_realdopes:uyuştu', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(PlayerPedId(), true)
	SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(PlayerPedId(), true)
	Citizen.Wait(300000)
	SetPedMovementClipset(PlayerPedId(), "MOVE_M@CASUAL@D", true)
	ClearTimecycleModifier()
	SetPedMotionBlur(PlayerPedId(), false)
end)
RegisterNetEvent('utku_realdopes:aniDurdur')
AddEventHandler('utku_realdopes:aniDurdur', function()
	basla = false
	FreezeEntityPosition(LastPlayerPed, false)
	DisplayHelpText(_U("left_zone"))
	StopParticleFxLooped(Smoke, 0)
end)
RegisterNetEvent('utku_realdopes:dur')
AddEventHandler('utku_realdopes:dur', function()
	basla = false
	DisplayHelpText(_U("production_stopped"))
	FreezeEntityPosition(LastPlayerPed, false)
	StopParticleFxLooped(Smoke, 0)
end)
RegisterNetEvent('utku_realdopes:üretimBaşla')
AddEventHandler('utku_realdopes:üretimBaşla', function()
	DisplayHelpText(_U("production_start"))
	ProductionLocation()
	basla = true
	ESX.ShowNotification(_U("epi_start"))
end)
RegisterNetEvent('utku_realdopes:patlamaBaşla')
AddEventHandler('utku_realdopes:patlamaBaşla', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	ilerleme = 0
	kalite = 0
	dur = false
	FreezeEntityPosition(PlayerPedId(), false)
	StopParticleFxLooped(Smoke, 0)
	StopParticleFxLooped(Smoke2, 0)
end)
-- RegisterNetEvent('utku_realdopes:karışımSaçılma')
-- AddEventHandler('utku_realdopes:karışımSaçılma', function()
-- 	Splash1()
-- 	Splash2()
-- end)