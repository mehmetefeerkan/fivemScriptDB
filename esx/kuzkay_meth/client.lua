local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
ESX = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('esx_methcar:stop')
AddEventHandler('esx_methcar:stop', function()
	started = falses
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Üretim durdu.', length = 5000})
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('esx_methcar:stopfreeze')
AddEventHandler('esx_methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('esx_methcar:notify')
AddEventHandler('esx_methcar:notify', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('esx_methcar:startprod')
AddEventHandler('esx_methcar:startprod', function()
	-- DisplayHelpText("~g~Üretim başlıyor.")
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Üretim başlıyor.', length = 5000})
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	-- print('Started Meth production')
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Meth üretimi başladı.'})
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
	-- TriggerEvent('m3:invUseable', false)
end)

RegisterNetEvent('esx_methcar:blowup')
AddEventHandler('esx_methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.1 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(10000)
	StopParticleFxLooped(fire, 0)
end)

-- RegisterCommand('bum', function()
-- 	local pos = GetEntityCoords(GetPlayerPed(-1))
-- 	AddExplosion(pos.x, pos.y, pos.z + 2,23, 20.0, true, false, 1.0, true)
-- 	if not HasNamedPtfxAssetLoaded("core") then
-- 		RequestNamedPtfxAsset("core")
-- 		while not HasNamedPtfxAssetLoaded("core") do
-- 			Citizen.Wait(1)
-- 		end
-- 	end
-- 	SetPtfxAssetNextCall("core")
-- 	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", pos.x, pos.y, pos.z-0.1 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
-- 	Citizen.Wait(10000)
-- 	StopParticleFxLooped(fire, 0)
-- end)


RegisterNetEvent('esx_methcar:smoke')
AddEventHandler('esx_methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.5, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)

-- RegisterNetEvent('esx_methcar:drugged')
-- AddEventHandler('esx_methcar:drugged', function()
-- 	SetTimecycleModifier("drug_drive_blend01")
-- 	SetPedMotionBlur(GetPlayerPed(-1), true)
-- 	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
-- 	SetPedIsDrunk(GetPlayerPed(-1), true)

-- 	Citizen.Wait(300000)
-- 	ClearTimecycleModifier()
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
				if GetPedInVehicleSeat(car, -1) == playerPed then
					if started == false then
						if displayed == false then
							DisplayHelpText("Meth pişirmek için ~INPUT_INTERACTION_MENU~ tuşuna basınız.")
							displayed = true
						end
					end
					if IsControlJustReleased(0, 244) then
						if pos.y >= 3500 then
							if IsVehicleSeatFree(CurrentVehicle, 3) then
								-- local data = exports['m3_base']:getOsTime()
								-- if data.hour > data.min or data.hour < data.max then
									TriggerServerEvent('esx_methcar:start')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
								-- else
								-- 	exports['mythic_notify']:SendAlert('error', 'Şu anda bunu yapamazsın!', 5000)
								-- end
							else
								DisplayHelpText('~r~Araçta zaten üretim yapılıyor.')
							end
						else
							TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Şehire çok yakınsın, üretime başlayabilmek için kuzeye doğru ilerleyin.'})
						end
					end
				end
			end
		else
			if started then
				started = false
				displayed = false
				-- TriggerEvent('m3:invUseable', true)
				TriggerEvent('esx_methcar:stop')
				-- print('Stopped making drugs')
				FreezeEntityPosition(LastCar,false)
			end
		end
		
		if started == true then
			
			if progress < 96 then
				Citizen.Wait(6000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Meth üretimi: ' .. progress .. '%'})
					Citizen.Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Propan borusu sızdırıyor, ne yapacaksın?')	
						ESX.ShowNotification('~o~[Yukarı Ok] Bant kullanarak tamir et.')
						ESX.ShowNotification('~o~[Sol Ok] Olduğu gibi bırak.')
						ESX.ShowNotification('~o~[Sağ Ok] Boruyu yedeğiyle değiştir.')
						ESX.ShowNotification('~c~Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						-- print("Selected 1")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Bant sızıntıyı durdurdu.'})
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						-- print("Selected 2")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Propan tankı patladı, batırdın!'})
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, -1.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 85, false)
						-- print('Stopped making drugs')
					end
					if selection == 3 then
						-- print("Selected 3")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Mantıklı karar, boru hiç iyi durumda değildi.'})
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Bir şişe aseton yere döküldü, ne yapacaksın?')	
						ESX.ShowNotification('[Yukarı Ok] Kokudan kurtulmak için pencereleri aç.')
						ESX.ShowNotification('[Sol Ok] Olduğu gibi bırak.')
						ESX.ShowNotification('[Sağ Ok] Gaz maskesi tak.')
						ESX.ShowNotification('Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Kokudan kurtulmak için pencereleri açtın.'})
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Çok fazla asetona maruz kaldın!'})
						pause = false
					end
					if selection == 3 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Sorunu çözmenin en iyi yolu buydu, galiba.'})
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Meth çok hızlı katılaşmaya başladı, ne yapacaksın? ')	
						ESX.ShowNotification('[Yukarı Ok] Basıncı arttır.')
						ESX.ShowNotification('[Sol Ok] Sıcaklığı arttır.')
						ESX.ShowNotification('[Sağ Ok] Basıncı düşür.')
						ESX.ShowNotification('Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Basıncı yükselttiniz, propan kaçmaya başladı, basıncı tekrar düşürdün, şimdilik iyi durumda.'})
						pause = false
					end
					if selection == 2 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Sıcaklığı arttırmak işe yaradı.'})
						quality = quality + 3
						pause = false
					end
					if selection == 3 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Basıncı düşürmek daha da kötü hale getirdi.'})
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Kazara çok fazla aseton koydun, ne yapacaksın?')	
						ESX.ShowNotification('[Yukarı Ok] Olduğu gibi bırak.')
						ESX.ShowNotification('[Sol Ok] Şırınga ile fazlalığı al.')
						ESX.ShowNotification('[Sağ Ok] Dengelemek için lityum ekle.')
						ESX.ShowNotification('Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'En azından meth çok aseton gibi kokmuyor.'})
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Faydası dokundu ancak hala daha çok fazla aseton var.'})
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Başarıyla kimyasalları dengeledin, şuanlık iyi durumda.'})
						pause = false
						quality = quality + 2
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Biraz pulbiber buldun, ne yapacaksın?')	
						ESX.ShowNotification('[Yukarı Ok] İçine ekle.')
						ESX.ShowNotification('[Sol Ok] Olduğu gibi bırak.')
						ESX.ShowNotification('[Sağ Ok] Ye.')
						ESX.ShowNotification('Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'En azından farklı şeyler deniyorsun.'})
						quality = quality + 2
						pause = false
					end
					if selection == 2 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Evet, pulbiber methin saflığını bozabilirdi.'})
						pause = false
					end
					if selection == 3 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Sen garip bir insansın.'})
						pause = false
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Filtre tıkandı, ne yapacaksın?')	
						ESX.ShowNotification('[Yukarı Ok] Basınçlı hava kullanarak temizle.')
						ESX.ShowNotification('[Sol Ok] Yedeğiyle değiştir.')
						ESX.ShowNotification('[Sağ Ok] Diş fırçası ile temizle.')
						ESX.ShowNotification('Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						-- print("Selected 1")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Basınçlı hava sıvıyı her tarafa püskürttü!'})
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						-- print("Selected 2")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Değiştirmek galiba en iyi çözümdü.'})
						pause = false
						quality = quality + 2
					end
					if selection == 3 then
						-- print("Selected 3")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Temizlemek işe yaradı ancak filtenin içine pislik kaçmış olabilir.'})
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Hidroklorik asit şişesi yere düştü, ne yapacaksın?')	
						ESX.ShowNotification('[Yukarı Ok] Bir bez alıp temizle.')
						ESX.ShowNotification('[Sol Ok] Olduğu gibi bırak.')
						ESX.ShowNotification('[Sağ Ok] Karavanın içine göz at.')
						ESX.ShowNotification('Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Ellerin tahriş oldu!'})
						ApplyDamageToPed(GetPlayerPed(-1), 70, false)
						pause = false
					end
					if selection == 2 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Karavanın zemini hasar gördü, bu sana pahalıya patlayabilir!'})
						pause = false
					end
					if selection == 3 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Koruyucu eldiven bulup bezle temizledin, bir sıkıntı yok gibi gözüküyor!'})
						pause = false
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Hidroklorik asit şişesinin sızdırdığını farkettin, ne yapacaksın?')	
						ESX.ShowNotification('~o~[Yukarı Ok] Olduğu gibi bırak.')
						ESX.ShowNotification('~o~[Sol Ok] Altına aliminyum kase yerleştir.')
						ESX.ShowNotification('~o~[Sağ Ok] Altına plastik kap yerleştir.')
						ESX.ShowNotification('~c~Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Gereğinden fazla hidroklorik asit karıştı, kalite düştü!'})
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Aliminyum kase ile hidroklorik asit tepkimeye girdi, batırdın!'})
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, -1.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 70, false)
					end
					if selection == 3 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Plastik ile tepkimeye girmeyeceğini biliyorsun, sen iyi bir kimyagersin!'})
						pause = false
						quality = quality + 3
					end
				end
				if progress > 76 and progress < 78 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Methi parçalamak için yanında alet getirmeyi unutmuşsun, ne yapacaksın?')	
						ESX.ShowNotification('~o~[Yukarı Ok] Karavanda bulduğun çekici kullan.')
						ESX.ShowNotification('~o~[Sol Ok] Elinle parçala.')
						ESX.ShowNotification('~o~[Sağ Ok] Karavanda bulduğun kaşığı kullan.')
						ESX.ShowNotification('~c~Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Çekiç ile parçaladın ancak miktar çok azaldı!'})
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Parçalamayı başardın ancak hijyensiz oldu.'})
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Parçalaman uzun sürdü ama işe yaradı!'})
						pause = false
						quality = quality + 2
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tuvaletin geldi, ne yapacaksın?')	
						ESX.ShowNotification('~o~[Yukarı Ok] Biraz daha dayan.')
						ESX.ShowNotification('~o~[Sol Ok] Dışarı çıkıp işini hallet.')
						ESX.ShowNotification('~o~[Sağ Ok] İşini içeride hallet.')
						ESX.ShowNotification('~c~Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						-- print("Selected 1")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Önce işini bitirmen daha önemli, mantıklı karar!'})
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						-- print("Selected 2")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Dışarı çıkarken kolun şişelere çarptı, her yeri dağıttın!'})
						pause = false
						quality = quality - 2
					end
					if selection == 3 then
						-- print("Selected 3")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Ortalık berbat koktu, methinin kokusu hiç iyi olmayacak.'})
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Methine cam parçaları eklemek ister misin? Böylece daha fazla görünmesini sağlayabilirsin.')	
						ESX.ShowNotification('~o~[Yukarı Ok] Evet!')
						ESX.ShowNotification('~o~[Sol Ok] Hayır.')
						ESX.ShowNotification('~o~[Sağ Ok] Cam parçalarının arasına meth ekle.')
						ESX.ShowNotification('~c~Uygulamak istediğiniz cevabın tuşuna basınız.')
					end
					if selection == 1 then
						-- print("Selected 1")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Her ne kadar kalitesiz olsa da ürünün miktarı arttı.'})
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						-- print("Selected 2")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Sen iyi bir aşçısın, ürünlerin çok kaliteli!'})
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						-- print("Selected 3")
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Bu biraz fazla oldu ancak sıkıntı değil.'})
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('esx_methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						-- quality = quality + 1
						progress = progress +  math.random(1, 2)
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Meth üretimi: ' .. progress .. '%'})
					end
				else
					TriggerEvent('esx_methcar:stop')
				end

			else
				TriggerEvent('esx_methcar:stop')
				progress = 100
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Meth üretimi tamamlandı!'})
				local quality = math.ceil(quality/3)
				if quality > 7 then
					quality = 7
				end
				if quality < 3 then
					quality = 3
				end
				TriggerServerEvent('esx_methcar:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
Citizen.CreateThread(function()
	while true do
		local sleep = 2000
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					FreezeEntityPosition(LastCar,false)
				end		
			end
		Citizen.Wait(sleep)
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, 27) then
				selection = 1
				ESX.ShowNotification('1. seçeneği seçtiniz.')
			end
			if IsControlJustReleased(0, 174) then
				selection = 2
				ESX.ShowNotification('2. seçeneği seçtiniz.')
			end
			if IsControlJustReleased(0, 175) then
				selection = 3
				ESX.ShowNotification('3. seçeneği seçtiniz.')
			end
		end

	end
end)




