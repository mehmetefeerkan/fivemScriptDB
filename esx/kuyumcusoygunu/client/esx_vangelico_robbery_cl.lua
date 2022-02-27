local vetrineRotte = 1 
local soygunBasladi, elektrikKesildi = false, false

local vetrine = {
	{x = 147.085, y = -1048.612, z = 29.346, heading = 70.326, isOpen = false},--
	{x = -626.735, y = -238.545, z = 38.057, heading = 214.907, isOpen = false},--
	{x = -625.697, y = -237.877, z = 38.057, heading = 217.311, isOpen = false},--
	{x = -626.825, y = -235.347, z = 38.057, heading = 33.745, isOpen = false},--
	{x = -625.77, y = -234.563, z = 38.057, heading = 33.572, isOpen = false},--
	{x = -627.957, y = -233.918, z = 38.057, heading = 215.214, isOpen = false},--
	{x = -626.971, y = -233.134, z = 38.057, heading = 215.532, isOpen = false},--
	{x = -624.433, y = -231.161, z = 38.057, heading = 305.159, isOpen = false},--
	{x = -623.045, y = -232.969, z = 38.057, heading = 303.496, isOpen = false},--
	{x = -620.265, y = -234.502, z = 38.057, heading = 217.504, isOpen = false},--
	{x = -619.225, y = -233.677, z = 38.057, heading = 213.35, isOpen = false},--
	{x = -620.025, y = -233.354, z = 38.057, heading = 34.18, isOpen = false},--
	{x = -617.487, y = -230.605, z = 38.057, heading = 309.177, isOpen = false},--
	{x = -618.304, y = -229.481, z = 38.057, heading = 304.243, isOpen = false},--
	{x = -619.741, y = -230.32, z = 38.057, heading = 124.283, isOpen = false},--
	{x = -619.69, y = -227.61, z = 38.057, heading = 305.245, isOpen = false},--
	{x = -620.481, y = -226.59, z = 38.057, heading = 304.677, isOpen = false},--
	{x = -621.098, y = -228.495, z = 38.057, heading = 127.046, isOpen = false},--
	{x = -623.855, y = -227.051, z = 38.057, heading = 38.605, isOpen = false},--
	{x = -624.977, y = -227.884, z = 38.057, heading = 48.847, isOpen = false},--
	{x = -624.056, y = -228.228, z = 38.057, heading = 216.443, isOpen = false},--
}

local IzinVerilenSilahlar = {
	--Pistoller
    [-619010992] = "WEAPON_MACHINEPISTOL", -- WEAPON_MACHINEPISTOL
    [-1076751822] = "WEAPON_SNSPISTOL", -- SNS PISTOL
    [-771403250] = "WEAPON_HEAVYPISTOL", -- HEAVY PISTOL
    [1593441988] = "WEAPON_COMBATPISTOL", -- COMBAT PISTOL
    [453432689] = "WEAPON_PISTOL", -- PISTOL 
    [-1716589765] = "WEAPON_PISTOL50", -- PISTOL .50
    [137902532] = "WEAPON_VINTAGEPISTOL", -- VINTAGEPISTOL

    --SMG
    [171789620] = "WEAPON_COMBATPDW", -- COMBAT PDW
    [736523883] = "WEAPON_SMG", -- SMG
    [-270015777] = "WEAPON_ASSAULTSMG", -- ASSAULT SMG
    [324215364] = "WEAPON_MICROSMG", -- MICRO SMG
    [-1121678507] = "WEAPON_MINISMG", -- MINISMG

    --Taarruz
    [-1357824103] = "WEAPON_ADVANCEDRIFLE", -- ADVANCED RIFLE
    [-1063057011] = "WEAPON_SPECIALCARBINE", -- SPECAIAL RIFLE
    [-1074790547] = "WEAPON_ASSAULTRIFLE", -- ASSAULT RIFLE
    [-2084633992] = "WEAPON_CARBINERIFLE", -- CARBINE RIFLE
}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 140)
end

Citizen.CreateThread(function()
	local ve = Config.Position

	local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
	SetBlipSprite(blip, 439)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Mücevher Dukkanı")
	EndTextCommandSetBlipName(blip)	
end)

Citizen.CreateThread(function()  
	while true do
		local playerPed = PlayerPedId()
		local playerPos = GetEntityCoords(playerPed, true)
		local soygunKonumKart = vector3(-631.45, -237.54, 38.42)
		local soygunKonumElektrik = vector3(-602.76, -264.01, 52.31)
		local _,wep = GetCurrentPedWeapon(playerPed)

		if #(playerPos - soygunKonumElektrik) < 2.0 then
			DrawText3D(soygunKonumElektrik.x, soygunKonumElektrik.y, soygunKonumElektrik.z, "[E] Elektriği Kes")
			if IsControlJustPressed(0, 38) then
				if not elektrikKesildi then
					ESX.TriggerServerCallback('esx_vangelico_robbery:aktif-polis-sayisi', function(AktifPolis)
						if AktifPolis >= Config.RequiredCopsRob then
							ESX.ShowNotification("Elektriği Kestin! Elektrik 30 Dakika Boyunca Kesik Kalacak")
							elektrikKesildi = true
							TriggerServerEvent("esx_vangelice_robbery:elektrik-kes")	
						else
							ESX.ShowNotification("Şehirde Yeterli Sayıda Polis Yok")
						end
					end)
				else
					ESX.ShowNotification("Elektrik Zaten Kesik Durumda")
				end
			end
		end

		if elektrikKesildi then
			if #(playerPos - soygunKonumKart) < 70 then
				SetArtificialLightsState(true)
			else
				SetArtificialLightsState(false)
			end
		end
		
		if #(playerPos - soygunKonumKart) < 2.0 then
			if not soygunBasladi then	
				DrawText3D(soygunKonumKart.x, soygunKonumKart.y, soygunKonumKart.z, "[E] Kartı Okut [H] İçeri Kontrol Et")
				if IsControlJustPressed(0, 74) then
					TriggerServerEvent("esx_vangelico_robbery:kontrol")
				end

				if IsControlJustPressed(0, 38) and elektrikKesildi then
					ESX.TriggerServerCallback('esx_vangelico_robbery:kart-soygun-kontrol', function(durum)
						if durum then
							soygunBasladi = true
							TriggerServerEvent("esx_vangelice_robbery:kapi-ac")
							TriggerEvent("ab-polisbildirim:BildirimGonder", "Mücevherci Soygunu", false)
						end
					end)
				
				elseif IsControlJustPressed(0, 38) and not elektrikKesildi then
					ESX.ShowNotification("Sistem: Acil Bir Durum Olmadığı İçin Giriş Geçersiz")
				end
			end
		end

		if soygunBasladi then
			for i,v in pairs(vetrine) do 
				if #(playerPos - vector3(v.x, v.y, v.z)) < 0.75 and not v.isOpen then
					DrawText3D(v.x, v.y, v.z, '~w~[~g~E~w~] ' .. _U('press_to_collect'), 0.45)
					if IsControlJustPressed(0, 38) and IzinVerilenSilahlar[wep] then
						SetEntityCoords(playerPed, v.x, v.y, v.z-0.95)
						SetEntityHeading(playerPed, v.heading)
						ESX.Streaming.RequestAnimDict('missheist_jewel', function()
							TaskPlayAnim(playerPed, 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
						end)
						if math.random(1,3) == 1 then
							Citizen.Wait(1500) 
							ClearPedTasks(playerPed)
						else
							v.isOpen = true 
							PlaySoundFromCoord(-1, "Glass_Smash", v.x, v.y, v.z, "", 0, 2.0, 0)
							while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
								RequestNamedPtfxAsset("scr_jewelheist")
								Citizen.Wait(0)
							end
							SetPtfxAssetNextCall("scr_jewelheist")
							StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								
							Citizen.Wait(5000)
							ClearPedTasks(playerPed)
							
							if IzinVerilenSilahlar[wep] == "WEAPON_HEAVYPISTOL" or IzinVerilenSilahlar[wep] == "WEAPON_SNSPISTOL" or IzinVerilenSilahlar[wep] == "WEAPON_PISTOL" or IzinVerilenSilahlar[wep] == "WEAPON_PISTOL50" or IzinVerilenSilahlar[wep] == "WEAPON_COMBATPISTOL" or IzinVerilenSilahlar[wep] == "WEAPON_VINTAGEPISTOL" then
								TriggerServerEvent('esx_vangelico_robbery:gioielli', 3, 4)
							elseif IzinVerilenSilahlar[wep] == "WEAPON_MACHINEPISTOL" or IzinVerilenSilahlar[wep] == "WEAPON_COMBATPDW" or IzinVerilenSilahlar[wep] == "WEAPON_SMG" or IzinVerilenSilahlar[wep] == "WEAPON_ASSAULTSMG" or IzinVerilenSilahlar[wep] == "WEAPON_MICROSMG" or IzinVerilenSilahlar[wep] == "WEAPON_MINISMG" then
								TriggerServerEvent('esx_vangelico_robbery:gioielli', 5, 6)
							elseif IzinVerilenSilahlar[wep] == "WEAPON_ADVANCEDRIFLE" or IzinVerilenSilahlar[wep] == "WEAPON_SPECIALCARBINE" or IzinVerilenSilahlar[wep] == "WEAPON_ASSAULTRIFLE" or IzinVerilenSilahlar[wep] == "WEAPON_CARBINERIFLE" then
								TriggerServerEvent('esx_vangelico_robbery:gioielli', 7, 8)
							else
								TriggerServerEvent('esx_vangelico_robbery:gioielli', 2, 3)
							end
							
							vetrineRotte = vetrineRotte + 1
						end

						if vetrineRotte == #vetrine then 
							for i,v in pairs(vetrine) do 
								v.isOpen = false
								vetrineRotte = 1
							end
							local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 50)
							for i = 1, #players, 1 do
								TriggerServerEvent("esx_vangelico_robbery:soyguntamam", GetPlayerServerId(players[i]))
							end
							soygunBasladi = false
						end
					elseif IsControlJustPressed(0, 38) then 
						ESX.ShowNotification("Camı Kırabilmek İçin Elinde Silah Olması Lazım")
					end	
				end
			end

			if #(playerPos - soygunKonumKart) > 30 then
				ESX.ShowNotification("Soygun İptal Edildi")
				local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 50)
				for i = 1, #players, 1 do
					TriggerServerEvent("esx_vangelico_robbery:soyguntamam", GetPlayerServerId(players[i]))
				end
				for i,v in pairs(vetrine) do 
					v.isOpen = false
					vetrineRotte = 1
				end
				soygunBasladi = false
			end
		end

		Citizen.Wait(1)
	end
end)

RegisterNetEvent('esx_vangelico_robbery:soyguntamamclient')
AddEventHandler('esx_vangelico_robbery:soyguntamamclient', function(idno)
	TriggerEvent("esx_vangelice_robbery:soygun-engel", "mucevher")
end)

RegisterNetEvent('esx_vangelice_robbery:elektrik-kes-client')
AddEventHandler('esx_vangelice_robbery:elektrik-kes-client', function(durum)
	elektrikKesildi = durum
	if not durum then
		TriggerEvent("esx_doorlock:mucevher-kapi", true)
	end
end)

RegisterNetEvent('esx_vangelice_robbery:kapi-ac-client')
AddEventHandler('esx_vangelice_robbery:kapi-ac-client', function(durum)
	TriggerEvent("esx_doorlock:mucevher-kapi", false)
end)

RegisterNetEvent('esx_vangelice_robbery:soygun-engel')
AddEventHandler('esx_vangelice_robbery:soygun-engel', function(hangi)
    if hangi == "banka" or hangi == "mucevher" then
        soygunyapildibankamucevher = true
        Citizen.Wait(2400000)
        soygunyapildibankamucevher = false
    elseif hangi == "market" then
        soygunyapildimarket = true
        Citizen.Wait(1800000)
        soygunyapildimarket = false
    end
end)