--[[ DUMPED USING COMPOSER DEVIL ]]--
ESX = nil

local timing, isPlayerWhitelisted = math.ceil(Config.Timer * 60000), false
local streetName, playerGender

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

local gps = 0


colors = {
	--[0] = "Metalik Siyah",
	
	[1] = "Metalik Grafit Siyah",
	
	[2] = "Metalik Siyah Çelik",
	
	[3] = "Metalik Kara Gümüş",
	
	[4] = "Metalik Gümüş",
	
	[5] = "Metalik Safir",
	
	[6] = "Metalik Gri Çelik",
	
	[7] = "Metalik Kapalı Gümüş",
	
	[8] = "Metalik Gümüş Mavisi",
	
	[9] = "Metalik Geceyarısı Gümüş",
	
	[10] = "Metalik Koyu Gri",
	
	[11] = "Metalik Antrasit Grisi",
	
	[12] = "Mat Siyah",
	
	[13] = "Mat Gri",
	
	[14] = "Mat Açık Gri",
	
	[15] = "Util Siyah",
	
	[16] = "Util Siyah Poli",
	
	[17] = "Util Kara Gümüş",
	
	[18] = "Util Gümüş",
	
	[19] = "Util Koyu Gri",
	
	[20] = "Util Kapalı Gümüş",
	
	[21] = "Yıpranmış Siyah",
	
	[22] = "Yıpranmış Grafit",
	
	[23] = "Yıpranmış Gümüş Grisi",
	
	[24] = "Yıpranmış Gümüş",
	
	[25] = "Yıpranmış Gümüş Mavisi",
	
	[26] = "Yıpranmış Koyu Gri",
	
	[27] = "Metalik Kırmızı",
	
	[28] = "Metalik Turin Kırmızısı",
	
	[29] = "Metalik Ferrari Kırmızısı",
	
	[30] = "Metalik Alev Kırmızısı",
	
	[31] = "Metalik Zarif Kırmızı",
	
	[32] = "Metalik Lal Kırmızısı",
	
	[33] = "Metalik Çöl Kırmızısı",
	
	[34] = "Metalik Şarap Kırmızısı",
	
	[35] = "Metalik Şeker Kırmızısı",
	
	[36] = "Metalik Turuncu",
	
	[37] = "Metalik Klasik Altın",
	
	[38] = "Metalik Turuncu",
	
	[39] = "Mat Kırmızı",
	
	[40] = "Mat Koyu Kırmızı",
	
	[41] = "Mat Turuncu",
	
	[42] = "Mat Sarı",
	
	[43] = "Util Kırmızı",
	
	[44] = "Util Parlak Kırmızı",
	
	[45] = "Util Lal Kırmızısı",
	
	[46] = "Yıpranmış Kırmızı",
	
	[47] = "Yıpranmış Altın Kırmızısı",
	
	[48] = "Yıpranmış Koyu Kırmızı",
	
	[49] = "Yıpranmış Koyu Yeşil",
	
	[50] = "Metalik Yarış Yeşili",
	
	[51] = "Metalik Deniz Mavisi",
	
	[52] = "Metalik Zeytin Yeşili",
	
	[53] = "Metalik Yeşil",
	
	[54] = "Metalik Camgöbeği",
	
	[55] = "Mat Lime Yeşili",
	
	[56] = "Util Koyu Yeşil",
	
	[57] = "Util Yeşil",
	
	[58] = "Yıpranmış Koyu Yeşil",
	
	[59] = "Yıpranmış Yeşil",
	
	[60] = "Yıpranmış Dalga Yeşili",
	
	[61] = "Metalik Geceyarısı Mavisi",
	
	[62] = "Metalik Koyu Mavi",
	
	[63] = "Metalik Koyu Bebek Mavisi",
	
	[64] = "Metalik Mavi",
	
	[65] = "Metalik Denizci Mavisi",
	
	[66] = "Metalik Liman Mavisi",
	
	[67] = "Metalik Elmas Mavisi",
	
	[68] = "Metalik Sörf Mavisi",
	
	[69] = "Metalik Nautik Mavi",
	
	[70] = "Metalik Parlak Mavi",
	
	[71] = "Metalik Patlıcan Mavisi",
	
	[72] = "Metalik Gemi Mavisi",
	
	[73] = "Metalik Ultra Mavi",
	
	[74] = "Metalik Parlak Mavi",
	
	[75] = "Util Koyu Mavi",
	
	[76] = "Util Geceyarısı Mavisi",
	
	[77] = "Util Mavi",
	
	[78] = "Util Deniz Köpüğü Mavisi",
	
	[79] = "Util Yıldırım Mavisi",
	
	[80] = "Util Bebek Mavisi",
	
	[81] = "Util Parlak Mavi",
	
	[82] = "Mat Koyu Mavi",
	
	[83] = "Mat Mavi",
	
	[84] = "Mat Geceyarısı Mavisi",
	
	[85] = "Yıpranmış Koyu Mavi",
	
	[86] = "Yıpranmış Mavi",
	
	[87] = "Yıpranmış Hafif Mavi",
	
	[88] = "Metalik Taksi Sarısı",
	
	[89] = "Metalik Yarış Sarısı",
	
	[90] = "Metalik Bronz",
	
	[91] = "Metalik Tweety Sarısı",
	
	[92] = "Metalik Lime",
	
	[93] = "Metalik Şampanya",
	
	[94] = "Metalik Pueblo Beige",
	
	[95] = "Metalik Koyu Fildişi",
	
	[96] = "Metalik Ayıcık Kahverengi",
	
	[97] = "Metalik Altın Kahverengi",
	
	[98] = "Metalik Hafif Kahverengi",
	
	[99] = "Metalik Straw Beige",
	
	[100] = "Metalik Yosun Kahverengi",
	
	[101] = "Metalik Biston Kahverengi",
	
	[102] = "Metalik Kayın",
	
	[103] = "Metalik Koyu Kayın",
	
	[104] = "Metalik Ayıcık Turuncusu",
	
	[105] = "Metalik Kumsal Sarısı",
	
	[106] = "Metalik Güneşte Ağartılmış Kumsal Sarısı",
	
	[107] = "Metalik Krema",
	
	[108] = "Util Kahverengi",
	
	[109] = "Util Orta Kahve",
	
	[110] = "Util Hafif Kahverengi",
	
	[111] = "Metalik Beyaz",
	
	[112] = "Metalik Kar Beyazı",
	
	[113] = "Yıpranmış Portakal Kabuğu",
	
	[114] = "Yıpranmış Kahverengi",
	
	[115] = "Yıpranmış Koyu Kahve",
	
	[116] = "Yıpranmış Saman Beji",
	
	[117] = "Pürüzsüz Çelik",
	
	[118] = "Pürüzsüz Kara Çelik",
	
	[119] = "Pürüzsüz Aluminyum",
	
	[120] = "Krom",
	
	[121] = "Az Yıpranmış Beyaz",
	
	[122] = "Az Util Beyaz",
	
	[123] = "Yıpranmış Turuncu",
	
	[124] = "Yıpranmış Parlak Turuncu",
	
	[125] = "Metallic Parlak Yeşil",
	
	[126] = "Yıpranmış Taksi Sarısı",
	
	[127] = "Polis Arabası Mavisi",
	
	[128] = "Mat Yeşil",
	
	[129] = "Mat Kahve",
	
	[130] = "Yıpranmış Turuncu",
	
	[131] = "Mat Beyaz",
	
	[132] = "Yıpranmış Beyaz",
	
	[133] = "Yıpranmış Ordu Yeşili",
	
	[134] = "Saf Beyaz",
	
	[135] = "Sıcak Pembe",
	
	[136] = "Somon Pembesi",
	
	[137] = "Metalik Parlak Pembe",
	
	[138] = "Turuncu",
	
	[139] = "Yeşil",
	
	[140] = "Mavi",
	
	[141] = "Mettalik Kara Mavi",
	
	[142] = "Metalik Kara Mor",
	
	[143] = "Metalik Kara Kırmızı",
	
	[144] = "Avcı Yeşili",
	
	[145] = "Metalik Mor",
	
	[146] = "Metaillik Kara Mavi",
	
	[147] = "Siyah",
	
	[148] = "Mat Mor",
	
	[149] = "Mat Koyu Mor",
	
	[150] = "Metalik Lav Kırmızısı",
	
	[151] = "Mat Orman Yeşili",
	
	[152] = "Mat Monoton Yeşili",
	
	[153] = "Mat Çöl Kahvesi",
	
	[154] = "Mat Çöl Bronzu",
	
	[155] = "Mat Çim Yeşili",
	
	[156] = "Tanımsız",--"DEFAULT ALLOY COLOR",
	
	[157] = "Buz Mavisi",
	
	[158] = "Bilinmiyor"
	
}

RegisterNetEvent("gps:kod3")
AddEventHandler("gps:kod3", function()
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		SetNewWaypoint(kod3lc.x, kod3lc.y)
		-- exports["mythic_notify"]:SendAlert("inform", "Olay yeri haritada işaretlendi.")
		TriggerEvent('notification', 'Olay yeri haritada işaretlendi', 1)
	else
		-- exports["mythic_notify"]:SendAlert("error", "Polis veya sherrif değilsin.")
		TriggerEvent('notification', 'Polis veya sherrif değilsin.', 2)
	end
end)

RegisterNetEvent("gps:gunshot")
AddEventHandler("gps:gunshot", function()
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		SetNewWaypoint(gunshotlc.x, gunshotlc.y)
		-- exports["mythic_notify"]:SendAlert("inform", "Olay yeri haritada işaretlendi.")
		TriggerEvent('notification', 'Olay yeri haritada işaretlendi', 1)
	else
		-- exports["mythic_notify"]:SendAlert("error", "Polis veya sherrif değilsin.")
		TriggerEvent('notification', 'Polis veya sherrif değilsin.', 2)
	end
end)

RegisterNetEvent("gps:houserobberies")
AddEventHandler("gps:houserobberies", function()
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		SetNewWaypoint(houserobberylc.x, houserobberylc.y)
		-- exports["mythic_notify"]:SendAlert("inform", "Olay yeri haritada işaretlendi.")
		TriggerEvent('notification', 'Olay yeri haritada işaretlendi', 1)
	else
		-- exports["mythic_notify"]:SendAlert("error", "Polis veya sherrif değilsin.")
		TriggerEvent('notification', 'Polis veya sherrif değilsin.', 2)
	end
end)

RegisterNetEvent("gps:codea")
AddEventHandler("gps:codea", function()
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		SetNewWaypoint(codealc.x, codealc.y)
		-- exports["mythic_notify"]:SendAlert("inform", "Olay yeri haritada işaretlendi.")
		TriggerEvent('notification', 'Olay yeri haritada işaretlendi', 1)
	else
		-- exports["mythic_notify"]:SendAlert("error", "Polis veya sherrif değilsin.")
		TriggerEvent('notification', 'Polis veya sherrif değilsin.', 2)
	end
end)

RegisterNetEvent("gps:ems")
AddEventHandler("gps:ems", function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		SetNewWaypoint(emsalertslc.x, emsalertslc.y)
		-- exports["mythic_notify"]:SendAlert("inform", "Olay yeri haritada işaretlendi.")
		TriggerEvent('notification', 'Olay yeri haritada işaretlendi', 1)
	else
		-- exports["mythic_notify"]:SendAlert("error", "Doktor kodunu doktor olmadan kullanamazsın..")
		TriggerEvent('notification', 'Doktor değilsin.', 2)
	end
end)

RegisterNetEvent("gps:recklessdriver")
AddEventHandler("gps:recklessdriver", function()
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		SetNewWaypoint(recklessdriverlc.x, recklessdriverlc.y)
		-- exports["mythic_notify"]:SendAlert("inform", "Olay yeri haritada işaretlendi.")
		TriggerEvent('notification', 'Olay yeri haritada işaretlendi', 1)
	else
		-- exports["mythic_notify"]:SendAlert("error", "Polis veya sherrif değilsin.")
		TriggerEvent('notification', 'Polis veya sherrif değilsin.', 2)
	end
end)

RegisterNetEvent("gps:carcrash")
AddEventHandler("gps:carcrash", function()
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		SetNewWaypoint(carcrashlc.x, carcrashlc.y)
		-- exports["mythic_notify"]:SendAlert("inform", "Olay yeri haritada işaretlendi.")
		TriggerEvent('notification', 'Olay yeri haritada işaretlendi', 1)
	else
		-- exports["mythic_notify"]:SendAlert("error", "Polis veya sherrif değilsin.")
		TriggerEvent('notification', 'Polis veya sherrif değilsin.', 2)
	end
end)

RegisterNetEvent("gps:hotwireAlert")
AddEventHandler("gps:hotwireAlert", function()
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		SetNewWaypoint(hotwireAlertlc.x, hotwireAlertlc.y)
		-- exports["mythic_notify"]:SendAlert("inform", "Olay yeri haritada işaretlendi.")
		TriggerEvent('notification', 'Olay yeri haritada işaretlendi', 1)
	else
		-- exports["mythic_notify"]:SendAlert("error", "Polis veya sherrif değilsin.")
		TriggerEvent('notification', 'Polis veya sherrif değilsin.', 2)
	end
end)



isDead = false

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function()
	isDead = false
end)

RegisterCommand('911', function(source, args)
    -- print(ESX.PlayerData.job)
--    print(isDead)
    if  ESX.PlayerData.job and (ESX.PlayerData.job.name == 'ambulance') and isDead then  -- police
		-- SendDistressSignalPolice()
		TriggerEvent('esx_outlawalert:emsNeeded')
    else
		-- exports['mythic_notify']:SendAlert('error', "Bu komutu kullanmak için polis/sheriff ve yaralı olmalısın")
		TriggerEvent('notification', 'Bu komutu kullanmak için polis/sheriff ve yaralı olmalısın', 2)
    end
end)

function SendDistressSignalPolice()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2
        DecorSetInt(playerPed, 'isOutlaw', 2)
        TriggerServerEvent('esx_outlawalert:policecodea', {
            x = ESX.Math.Round(playerCoords.x, 1),
            y = ESX.Math.Round(playerCoords.y, 1),
            z = ESX.Math.Round(playerCoords.z, 1)
        }, adres, playerGender)

	-- exports['mythic_notify']:SendAlert('inform', "Yardım çağrın EMS, Sheriff ve LSPD ekiplerine gönderildi, dayan!")
	TriggerEvent('notification', 'Yardım çağrın EMS, Sheriff ve LSPD ekiplerine gönderildi, dayan!', 1)
    TriggerServerEvent('esx_phone:send', 'ambulance', 'Yaralı polis memuru/sheriff, acil ambulans gerekiyor' , false, {
        x = coords.x,
        y = coords.y,
        z = coords.z
    })
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if NetworkIsSessionStarted() then
			DecorRegister('isOutlaw', 3)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)

			return
		end
	end
end)

-- Gets the player's current street.
-- Aaalso get the current player gender
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)

		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

AddEventHandler('skinchanger:loadSkin', function(character)
	playerGender = character.sex
end)

function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	for k,v in ipairs(Config.WhitelistedCops) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end


RegisterNetEvent('esx_outlawalert:outlawNotify')
AddEventHandler('esx_outlawalert:outlawNotify', function(type, data, length)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff') then
		SendNUIMessage({action = 'display', style = type, info = data, length = length})
    --	PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)

RegisterNetEvent('esx_outlawalert:outlawNotifyEMS')
AddEventHandler('esx_outlawalert:outlawNotifyEMS', function(type, data, length)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		SendNUIMessage({action = 'display', style = type, info = data, length = length})
   -- 	PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)


RegisterNetEvent('esx_outlawalert:outlawNotifyDetailed')
AddEventHandler('esx_outlawalert:outlawNotifyDetailed', function(type, data, length)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff') then
		SendNUIMessage({action = 'detailed', style = type, info = data, length = length})
    --	PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)

RegisterNetEvent('esx_outlawalert:outlawNotifyDetailedrecklessdriver')
AddEventHandler('esx_outlawalert:outlawNotifyDetailedrecklessdriver', function(type, data, length)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff') then
		SendNUIMessage({action = 'Detailedrecklessdriver', style = type, info = data, length = length})
    --	PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)

local exlusionZones = {
    {1713.1795654297,2586.6862792969,59.880760192871,250}, -- prison
    {-106.63687896729,6467.7294921875,31.626684188843,45}, -- paleto bank
    {251.21984863281,217.45391845703,106.28686523438,20}, -- city bank
    {-622.25042724609,-230.93577575684,38.057060241699,10}, -- jewlery store
    {699.91052246094,132.29960632324,80.743064880371,55}, -- power 1
    {2739.5505371094,1532.9992675781,57.56616973877,235}, -- power 2
    {12.53, -1097.99, 29.8, 10} -- Adam's Apple / Pillbox Weapon shop
}

--GEÇİCİ PASİF
--[[
--10-94
Citizen.CreateThread( function()
    local origin = false
    while true do
        Wait(1)
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                local playerPed = PlayerPedId()
                local currentVehicle = GetVehiclePedIsIn(playerPed, false)
                local speed = GetEntitySpeed(currentVehicle) * 3.6
                local driverPed = GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1)
                if driverPed == PlayerPedId() then
                    if speed > 160 and not IsPedInAnyHeli(PlayerPedId()) then
						if math.random(1000) < 100 then
							-- if ((isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted) then
								TriggerEvent("rpv:recklessdriver")
								Wait(10000)
							-- end
                        end
                    end
                else
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(1000)
            end
        --end
    end
end)
--]]


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		if DecorGetInt(PlayerPedId(), 'isOutlaw') == 2 then
			Citizen.Wait(timing)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local vehicleGet = GetVehiclePedIsIn(playerPed, false)
		local distance = GetDistanceBetweenCoords(playerCoords, vector3(916.13, -1815.41, 24.97), true)
		local dist = GetDistanceBetweenCoords(playerCoords, vector3(433.76, -1011.11, 28.65), true)

		if IsPedShooting(playerPed) and not IsPedCurrentWeaponSilenced(playerPed) and Config.GunshotAlert and (distance >= 30.0 or dist <= 300.0) then
			local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("weapon_snowball") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_PUMPSHOTGUN") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_STUNGUN") then 
				Citizen.Wait(1000)
			else
				Citizen.Wait(3000)
				if (isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted then
					local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					local plyPos = GetEntityCoords(PlayerPedId())
					local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
					local street1 = GetStreetNameFromHashKey(s1)
					zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
					local playerStreetsLocation = zoneNames[tostring(zone)]
					local street1 = street1 .. ", " .. playerStreetsLocation
					local street2 = GetStreetNameFromHashKey(s2)
					local dir = getCardinalDirectionFromHeading()
					local adres = street1.. " " .. street2
					if isInVehicle then
						color1, color2 = GetVehicleColours(vehicleGet)
						if color1 == 0 then color1 = 1 end
						if color2 == 0 then color2 = 2 end
						if color1 == -1 then color1 = 158 end
						if color2 == -1 then color2 = 158 end 
						
						plate = GetVehicleNumberPlateText(vehicleGet)
						model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleGet))
						local colorinfo = colors[color1] .. " üzerine " .. colors[color2]
						DecorSetInt(playerPed, 'isOutlaw', 2)
						TriggerServerEvent('esx_outlawalert:gunshotInVehicleProgress', {
							x = ESX.Math.Round(playerCoords.x, 1),
							y = ESX.Math.Round(playerCoords.y, 1),
							z = ESX.Math.Round(playerCoords.z, 1)
						}, adres, playerGender, colorinfo, plate, model, dir)
					else
						DecorSetInt(playerPed, 'isOutlaw', 2)
						TriggerServerEvent('esx_outlawalert:gunshotInProgress', {
							x = ESX.Math.Round(playerCoords.x, 1),
							y = ESX.Math.Round(playerCoords.y, 1),
							z = ESX.Math.Round(playerCoords.z, 1)
						}, adres, playerGender)
					end
				end
			end
		end
	end
end)

RegisterCommand('kod3', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
		local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local plyPos = GetEntityCoords(PlayerPedId())
		local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
		local street1 = GetStreetNameFromHashKey(s1)
		zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
		local playerStreetsLocation = zoneNames[tostring(zone)]
		local street1 = street1 .. ", " .. playerStreetsLocation
		local street2 = GetStreetNameFromHashKey(s2)
		local adres = street1.. " " .. street2
		
		if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
			DecorSetInt(playerPed, 'isOutlaw', 2)
			--local gps
			--gps = math.random(100, 999)
			TriggerServerEvent('esx_outlawalert:policecode', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
		else
			-- exports['mythic_notify']:SendAlert('error', "Bu komutu kullanmak için polis/sheriff olmalısın")
			TriggerEvent('notification', 'Bu komutu kullanmak için polis/sheriff olmalısın', 2)
		end
end)

RegisterNetEvent('esx_outlawalert:policecode')
AddEventHandler('esx_outlawalert:policecode', function(targetCoords)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		local alpha = 250
		local policecodeBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.PoliceCodeRadius)

		kod3lc = targetCoords
		SetBlipHighDetail(policecodeBlip, true)
		SetBlipColour(policecodeBlip, 3)
		SetBlipAlpha(policecodeBlip, alpha)
		SetBlipAsShortRange(policecodeBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceCodeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(policecodeBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(policecodeBlip)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_outlawalert:policecodea')
AddEventHandler('esx_outlawalert:policecodea', function(targetCoords)
	-- if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		local alpha = 250
		local policecodeaBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.PoliceCodeRadius)

		codealc = targetCoords
		SetBlipHighDetail(policecodeaBlip, true)
		SetBlipColour(policecodeaBlip, 1)
		SetBlipAlpha(policecodeaBlip, alpha)
		SetBlipAsShortRange(policecodeaBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceCodeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(policecodeaBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(policecodeaBlip)
				return
			end
		end
	-- end
end)

RegisterNetEvent('esx_outlawalert:hotwireAlert')
AddEventHandler('esx_outlawalert:hotwireAlert', function(targetCoords)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		local alpha = 250
		local policecodeaBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 15.0)

		hotwireAlertlc = targetCoords
		SetBlipHighDetail(policecodeaBlip, true)
		SetBlipColour(policecodeaBlip, 1)
		SetBlipAlpha(policecodeaBlip, alpha)
		SetBlipAsShortRange(policecodeaBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceCodeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(policecodeaBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(policecodeaBlip)
				return
			end
		end
	end
end)

--[[
AddEventHandler('rpv:hotwireAlert', function()

	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local vehicleGet = GetVehiclePedIsIn(playerPed, false)
	plate = GetVehicleNumberPlateText(vehicleGet)
	model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleGet))

	color1, color2 = GetVehicleColours(vehicleGet)
    if color1 == 0 then color1 = 1 end
    if color2 == 0 then color2 = 2 end
    if color1 == -1 then color1 = 158 end
	if color2 == -1 then color2 = 158 end 
  
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerCoords.x, playerCoords.y, playerCoords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
  
	zone = tostring(GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local dir = getCardinalDirectionFromHeading()
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)

	local adres = street1.. " " .. street2

    coordstest1 = targetCoords
	gps = math.random(100, 999)
	

	local colorinfo = colors[color1] .. " üzerine " .. colors[color2]

	TriggerServerEvent('esx_outlawalert:hotwireAlertS', {
		   x = ESX.Math.Round(playerCoords.x, 1),
		   y = ESX.Math.Round(playerCoords.y, 1),
		   z = ESX.Math.Round(playerCoords.z, 1)
	   }, adres, playerGender, colorinfo)
	   coordstest = playerCoords
end)

Citizen.CreateThread(function()
	TriggerEvent("chat:addSuggestion","/gps","Olayın yerini navigasyonda işaretler.",
		{{name = "GPS kodu gir.", help = ""}}
	)
end)
--]]
--[[
RegisterNetEvent('esx_outlawalert:recklessdriverS')
AddEventHandler('esx_outlawalert:recklessdriverS', function(targetCoords)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		local alpha = 250
		local policecodeaBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 15.0)
		
				

		recklessdriverlc = targetCoords
		SetBlipHighDetail(policecodeaBlip, true)
		SetBlipColour(policecodeaBlip, 1)
		SetBlipAlpha(policecodeaBlip, alpha)
		SetBlipAsShortRange(policecodeaBlip, true)


		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceCodeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(policecodeaBlip, alpha)
				
			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end
		
			if alpha == 0 then
				RemoveBlip(policecodeaBlip)
				return
			end
		end
	end
end)
--]]
--[[
RegisterNetEvent('esx_outlawalert:carcrashS')
AddEventHandler('esx_outlawalert:carcrashS', function(targetCoords)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		local alpha = 250
		local policecodeaBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 15.0)

		carcrashlc = targetCoords
		SetBlipHighDetail(policecodeaBlip, true)
		SetBlipColour(policecodeaBlip, 1)
		SetBlipAlpha(policecodeaBlip, alpha)
		SetBlipAsShortRange(policecodeaBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceCodeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(policecodeaBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(policecodeaBlip)
				return
			end
		end
	end
end)
--]]

zoneNames = {
	AIRP = "Los Santos Uluslararası Havalimanı",
	ALAMO = "Alamo Denizi",
	ALTA = "Alta",
	ARMYB = "Zancuda Askeri Üs",
	BANHAMC = "Banham Kanyonu",
	BANNING = "Banning",
	BAYTRE = "Baytree Kanyonu", 
	BEACH = "Vespucci Kumsalı",
	BHAMCA = "Banham Kanyonu",
	BRADP = "Braddock Geçişi",
	BRADT = "Braddock Tüneli",
	BURTON = "Burton",
	CALAFB = "Calafia Köprüsü",
	CANNY = "Raton Kanyonu",
	CCREAK = "Cassidy Deresi",
	CHAMH = "Chamberlain Tepesi",
	CHIL = "Vinewood Tepesi",
	CHU = "Chumash",
	CMSW = "Chiliad Dağı Eyalet Bölgesi",
	CYPRE = "Cypress Evleri",
	DAVIS = "Davis",
	DELBE = "Del Perro Sahili",
	DELPE = "Del Perro",
	DELSOL = "La Puerta",
	DESRT = "Büyük Senora Çölü",
	DOWNT = "Downtown",
	DTVINE = "Downtown Vinewood",
	EAST_V = "Doğu Vinewood",
	EBURO = "El Burro Tepeleri",
	ELGORL = "El Gordo Deniz Feneri",
	ELYSIAN = "Cennet Adası",
	GALFISH = "Galilee Takas Kampı",
	GALLI = "Galileo Parkı",
	golf = "GWC ve Golf	Topluluğu",
	GRAPES = "Grapeseed",
	GREATC = "Büyük Chaparral",
	HARMO = "Harmony",
	HAWICK = "Hawick",
	HORS = "Vinewood Yarış Pisti",
	HUMLAB = "Humane Lab. ve Araştırma Ens.",
	JAIL = "Federal Hapishane",
	KOREAT = "Little Seoul",
	LACT = "Land Act Baraj Gölü",
	LAGO = "Zancudo Gölü",
	LDAM = "Land Act Barajı",
	LEGSQU = "Legion Meydanı",
	LMESA = "La Mesa",
	LOSPUER = "La Puerta",
	MIRR = "Mirror Park",
	MORN = "Morningwood",
	MOVIE = "Görkemli Richards",
	MTCHIL = "Chiliad Dağı",
	MTGORDO = "Gordo Dağı",
	MTJOSE = "Josiah Dağı",
	MURRI = "Murrieta Tepeleri",
	NCHU = "Kuzey Chumash",
	NOOSE = "N.O.O.S.E",
	OCEANA = "Pasifik Okyanusu",
	PALCOV = "Paleto Koy",
	PALETO = "Paleto Körefezi",
	PALFOR = "Paleto Ormanı",
	PALHIGH = "Palomino Dağlıkları",
	PALMPOW = "Palmer-Taylor Güç İstasyonu",
	PBLUFF = "Pacific Kayalıkları",
	PBOX = "Pillbox Tepeleri",
	PROCOB = "Procopio Sahili",
	RANCHO = "Rancho",
	RGLEN = "Richman Glen",
	RICHM = "Richman",
	ROCKF = "Rockford Tepeleri",
	RTRAK = "Redwood Motocross Pisti",
	SanAnd = "San Andreas",
	SANCHIA = "San Chianski Range Dağları",
	SANDY = "Sandy Shores",
	SKID = "Mission Row",
	SLAB = "Stab City",
	STAD = "Maze Bank Bölgesi",
	STRAW = "Strawberry",
	TATAMO = "Tataviam Dağları",
	TERMINA = "Terminal",
	TEXTI = "Textile City",
	TONGVAH = "Tongva Hills",
	TONGVAV = "Tongva Valley",
	VCANA = "Vespucci Kanalları",
	VESP = "Vespucci",
	VINE = "Vinewood",
	WINDF = "Ron Alternates Rüzgar Çiftliği",
	WVINE = "Güney Vinewood",
	ZANCUDO = "Zancudo Nehri",
	ZP_ORT = "Güney Los Santos Limanı",
	ZQ_UAR = "Davis Quartz Madencilik Sahası"
}
	
	
function getCardinalDirectionFromHeading()
    local heading = GetEntityHeading(PlayerPedId())
    if heading >= 315 or heading < 45 then
        return "Kuzey"
    elseif heading >= 45 and heading < 135 then
        return "Batı"
    elseif heading >=135 and heading < 225 then
        return "Güney"
    elseif heading >= 225 and heading < 315 then
        return "Doğu"
    end
end
--rpv_outlawalert:carcrash

function getRandomNpc(basedistance)
    local basedistance = basedistance
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom

    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, false)
        if ped ~= PlayerPedId() and distance < basedistance and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)

    return rped
end

-- Citizen.CreateThread(function()


--       RequestModel(GetHashKey("g_m_y_ballasout_01"))
--       while not HasModelLoaded(GetHashKey("g_m_y_ballasout_01")) do
--         Wait(1)
--       end
  
--       RequestAnimDict("mini@strip_club@idles@bouncer@base")
--       while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
--         Wait(1)
-- 	  end
-- 	  local playerCoords = GetEntityCoords(PlayerPedId())
--       ped =  CreatePed(4, GetHashKey("g_m_y_ballasout_01"), -1527.9700927734, -2712.4665527344, 12.944934844971, 3374176, false, true)
--       SetEntityHeading(ped, 250)
--       FreezeEntityPosition(ped, true)
--       --SetEntityInvincible(ped, true)
--       --SetBlockingOfNonTemporaryEvents(ped, true)
--       --TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    
-- end)

npcAnim = function(nearNpc)
	print("bas")
	print(nearNpc)
	if nearNpc == nil then
		return
	else

		RequestAnimDict("cellphone@")
		while not HasAnimDictLoaded("cellphone@") do
			Citizen.Wait(0)
		end

		RequestAnimDict("amb@code_human_wander_texting@male@base")
		while not HasAnimDictLoaded("amb@code_human_wander_texting@male@base") do
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
		if GetEntityHealth(nearNpc) < GetEntityMaxHealth(nearNpc) then
			print("1")
			return
		end
		if not DoesEntityExist(nearNpc) then
			print("2")

			return
		end
		if IsPedFatallyInjured(nearNpc) then
			print("2")

			return
		end
		if IsPedInMeleeCombat(nearNpc) then
			print("3")

			return
		end
		ClearPedTasks(nearNpc)
		print("son")
		TaskPlayAnim(nearNpc, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
	end
end

-- Citizen.CreateThread( function()
-- 	local origin3 = false
-- 	local weapon = 1
--     while true do
--         Wait(1)
-- 		if GetVehiclePedIsUsing(PlayerPedId()) == 0 then
-- 			local nearNpc = getRandomNpc(10.0)
-- 			if IsPedInMeleeCombat(PlayerPedId()) and not origin3 and nearNpc then 
-- 					Wait(2000)
-- 					origin3 = true
-- 					local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
-- 					local plyPos = GetEntityCoords(PlayerPedId())
-- 					local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
-- 					local street1 = GetStreetNameFromHashKey(s1)
-- 					zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
-- 					local playerStreetsLocation = zoneNames[tostring(zone)]
-- 					local street1 = street1 .. ", " .. playerStreetsLocation
-- 					local street2 = GetStreetNameFromHashKey(s2)
-- 					local adres = street1.. " " .. street2
-- 					local playerCoords = GetEntityCoords(PlayerPedId())

-- 					DecorSetInt(PlayerPedId(), 'isOutlaw', 2)
-- 					if ((isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted) then
					
-- 						if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_BAT") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_KNUCKLEDUSTER") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_NIGHTSTICK") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_GOLFCLUB") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_FLASHLIGHT") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_POOLCLUE") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_WRENCH") then
-- 							weapon = 1
-- 							TriggerServerEvent('esx_outlawalert:combatInProgress', {
-- 								x = ESX.Math.Round(playerCoords.x, 1),
-- 								y = ESX.Math.Round(playerCoords.y, 1),
-- 								z = ESX.Math.Round(playerCoords.z, 1)
-- 							}, adres, playerGender, weapon)			
-- 						elseif GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_KNIFE") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_SWITCHBLADE") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_CROWBAR") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_BOTTLE") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_DAGGER") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_HATCHET") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_MACHETE") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_BATTLEAXE") then
-- 							weapon = 2
-- 							TriggerServerEvent('esx_outlawalert:combatInProgress', {
-- 								x = ESX.Math.Round(playerCoords.x, 1),
-- 								y = ESX.Math.Round(playerCoords.y, 1),
-- 								z = ESX.Math.Round(playerCoords.z, 1)
-- 							}, adres, playerGender, weapon)		
-- 						else
-- 							weapon = 3
-- 							TriggerServerEvent('esx_outlawalert:combatInProgress', {
-- 								x = ESX.Math.Round(playerCoords.x, 1),
-- 								y = ESX.Math.Round(playerCoords.y, 1),
-- 								z = ESX.Math.Round(playerCoords.z, 1)
-- 							}, adres, playerGender, weapon)		
-- 						end
-- 					end
			
-- 				npcAnim(nearNpc)
--                 --TriggerEvent("civilian:alertPolice",15.0,"fight",0)
--                 --TriggerEvent("Evidence:StateSet",1,300)
--                 Wait(20000)
--                 origin3 = false
--             end
--         else
--             Citizen.Wait(1500)
--         end
--     end
-- end)

AddEventHandler('rpv_outlawalert:carcrashS', function()

	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local vehicleGet = GetVehiclePedIsIn(playerPed, false)

    coordstest1 = targetCoords
	gps = math.random(100, 999)
	
    color1, color2 = GetVehicleColours(vehicleGet)
    if color1 == 0 then color1 = 1 end
    if color2 == 0 then color2 = 2 end
    if color1 == -1 then color1 = 158 end
	if color2 == -1 then color2 = 158 end 
	
	plate = GetVehicleNumberPlateText(vehicleGet)
	model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleGet))
  
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerCoords.x, playerCoords.y, playerCoords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
  
	zone = tostring(GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local dir = getCardinalDirectionFromHeading()
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)

	local adres = street1.. " " .. street2

	local colorinfo = colors[color1] .. " üzerine " .. colors[color2]
	TriggerServerEvent('esx_outlawalert:carcrashS', {
		   x = ESX.Math.Round(playerCoords.x, 1),
		   y = ESX.Math.Round(playerCoords.y, 1),
		   z = ESX.Math.Round(playerCoords.z, 1)
	   }, adres, playerGender, colorinfo, plate, model, dir)
	   coordstest = playerCoords
end)

--GEÇİCİ PASİF
--[[
AddEventHandler('rpv:recklessdriver', function()

	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local vehicleGet = GetVehiclePedIsIn(playerPed, false)

    streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    streetName = GetStreetNameFromHashKey(streetName)
    coordstest1 = targetCoords
	gps = math.random(100, 999)
	
    color1, color2 = GetVehicleColours(vehicleGet)
    if color1 == 0 then color1 = 1 end
    if color2 == 0 then color2 = 2 end
    if color1 == -1 then color1 = 158 end
	if color2 == -1 then color2 = 158 end 
	
	plate = GetVehicleNumberPlateText(vehicleGet)
	model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleGet))
  
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerCoords.x, playerCoords.y, playerCoords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
  
	zone = tostring(GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local dir = getCardinalDirectionFromHeading()
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)

	local adres = street1.. " " .. street2

	local colorinfo = colors[color1] .. " üzerine " .. colors[color2]
	TriggerServerEvent('esx_outlawalert:recklessdriverS', {
		   x = ESX.Math.Round(playerCoords.x, 1),
		   y = ESX.Math.Round(playerCoords.y, 1),
		   z = ESX.Math.Round(playerCoords.z, 1)
	   }, adres, playerGender, colorinfo, plate, model, dir)
	   coordstest = playerCoords
end)
--]]

RegisterNetEvent('esx_outlawalert:emsalerts')
AddEventHandler('esx_outlawalert:emsalerts', function(targetCoords)

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		local alpha = 250
		local emsBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.EvSoymaRadius)

		emsalertslc = targetCoords
		SetBlipHighDetail(emsBlip, true)
		SetBlipColour(emsBlip, 5)
		SetBlipAlpha(emsBlip, alpha)
		SetBlipAsShortRange(emsBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceCodeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(emsBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(emsBlip)
				return
			end
		end
	end
end)

--[[
AddEventHandler('rpv:emsalerts', function()

 	local playerPed = PlayerPedId()
 	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2
	
	coordstest1 = targetCoords
	gps = math.random(100, 999)
 	TriggerServerEvent('esx_outlawalert:emsNeeded', {
			x = ESX.Math.Round(playerCoords.x, 1),
			y = ESX.Math.Round(playerCoords.y, 1),
			z = ESX.Math.Round(playerCoords.z, 1)
		}, adres, playerGender)
		coordstest = playerCoords
end)
--]]

RegisterNetEvent('esx_outlawalert:houseRobbery')
AddEventHandler('esx_outlawalert:houseRobbery', function(targetCoords)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' ) then
		local alpha = 250
		local evsoygunuBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.EvSoymaRadius)

		houserobberylc = targetCoords
		SetBlipHighDetail(evsoygunuBlip, true)
		SetBlipColour(evsoygunuBlip, 5)
		SetBlipAlpha(evsoygunuBlip, alpha)
		SetBlipAsShortRange(evsoygunuBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.PoliceCodeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(evsoygunuBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(evsoygunuBlip)
				return
			end
		end
	end
end)

AddEventHandler('police:houseRobbery', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2

	coordstest1 = targetCoords
	gps = math.random(100, 999)
	TriggerServerEvent('esx_outlawalert:houseRobberyinProgress', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
			coordstest = playerCoords
end)

AddEventHandler('police:veznerobbery', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2

	coordstest1 = targetCoords
	gps = math.random(100, 999)
	TriggerServerEvent('esx_outlawalert:vezneRobberyinProgress', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
			coordstest = playerCoords
end)

RegisterNetEvent('esx_outlawalert:blaineRobberyinProgress')
AddEventHandler('esx_outlawalert:blaineRobberyinProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

AddEventHandler('police:blainerobbery', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2

	coordstest1 = targetCoords
	gps = math.random(100, 999)
	TriggerServerEvent('esx_outlawalert:blaineRobberyinProgress', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
			coordstest = playerCoords
end)

RegisterNetEvent('esx_outlawalert:vangelicorobberyinProgress')
AddEventHandler('esx_outlawalert:vangelicorobberyinProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

AddEventHandler('police:vangelicorobbery', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2

	coordstest1 = targetCoords
	gps = math.random(100, 999)
	TriggerServerEvent('esx_outlawalert:vangelicorobberyinProgress', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
			coordstest = playerCoords
end)

RegisterNetEvent('esx_outlawalert:banktruckrobberyinProgress')
AddEventHandler('esx_outlawalert:banktruckrobberyinProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

AddEventHandler('police:banktruckrobbery', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2

	coordstest1 = targetCoords
	gps = math.random(100, 999)
	TriggerServerEvent('esx_outlawalert:banktruckrobberyinProgress', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
			coordstest = playerCoords
end)

RegisterNetEvent('esx_outlawalert:houserobberyinProgress')
AddEventHandler('esx_outlawalert:houserobberyinProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

AddEventHandler('police:houseRobbery', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2

	coordstest1 = targetCoords
	gps = math.random(100, 999)
	TriggerServerEvent('esx_outlawalert:houserobberyinProgress', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
			coordstest = playerCoords
end)

RegisterNetEvent('esx_outlawalert:shoprobberyinProgress')
AddEventHandler('esx_outlawalert:shoprobberyinProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

AddEventHandler('police:shopRobbery', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2

	coordstest1 = targetCoords
	gps = math.random(100, 999)
	TriggerServerEvent('esx_outlawalert:shoprobberyinProgress', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
			coordstest = playerCoords
end)

RegisterNetEvent('esx_outlawalert:atmrobberyinProgress')
AddEventHandler('esx_outlawalert:atmrobberyinProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

AddEventHandler('police:atmRobbery', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plyPos = GetEntityCoords(PlayerPedId())
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
	local playerStreetsLocation = zoneNames[tostring(zone)]
	local street1 = street1 .. ", " .. playerStreetsLocation
	local street2 = GetStreetNameFromHashKey(s2)
	local adres = street1.. " " .. street2

	coordstest1 = targetCoords
	gps = math.random(100, 999)
	TriggerServerEvent('esx_outlawalert:atmrobberyinProgress', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
			}, adres, playerGender)
			coordstest = playerCoords
end)

-- RegisterNetEvent('esx_outlawalert:carJackInProgress')
-- AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords)
-- 	if isPlayerWhitelisted then
-- 		if Config.CarJackingAlert then
-- 			local alpha = 250
-- 			local thiefBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipJackingRadius)

-- 			SetBlipHighDetail(thiefBlip, true)
-- 			SetBlipColour(thiefBlip, 1)
-- 			SetBlipAlpha(thiefBlip, alpha)
-- 			SetBlipAsShortRange(thiefBlip, true)

-- 			while alpha ~= 0 do
-- 				Citizen.Wait(Config.BlipJackingTime * 4)
-- 				alpha = alpha - 1
-- 				SetBlipAlpha(thiefBlip, alpha)

-- 				if alpha == 0 then
-- 					RemoveBlip(thiefBlip)
-- 					return
-- 				end
-- 			end

-- 		end
-- 	end
-- end)

RegisterNetEvent('esx_outlawalert:gunshotInVehicleProgress')
AddEventHandler('esx_outlawalert:gunshotInVehicleProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		--SetBlipScale(gunshotBlip, 1.2)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		combatlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		--SetBlipScale(gunshotBlip, 1.2)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)


RegisterNetEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		--SetBlipScale(gunshotBlip, 1.2)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_outlawalert:vezneRobberyinProgress')
AddEventHandler('esx_outlawalert:vezneRobberyinProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		--gps = math.random(100, 999)
		gunshotlc = targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)


RegisterNetEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.MeleeAlert then
		local alpha = 250
		local meleeBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipMeleeRadius)

		coordstest1 = targetCoords
		SetBlipHighDetail(meleeBlip, true)
		SetBlipColour(meleeBlip, 17)
		SetBlipAlpha(meleeBlip, alpha)
		SetBlipAsShortRange(meleeBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipMeleeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(meleeBlip, alpha)

			if IsControlPressed(0, 46) then
			SetNewWaypoint(targetCoords.x, targetCoords.y)
			end

			if alpha == 0 then
				RemoveBlip(meleeBlip)
				return
			end
		end
	end
end)
--[[ DUMPED USING COMPOSER DEVIL ]]--