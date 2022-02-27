---======================---
---Written by Tościk#9715---
---======================---
local MiejsceMisji =  {x = -116.6, y = 6479.87, z = 31.46} --<< miejsce gdzie jest marker z misją
local dealerCoords =  {x = 960.78, y = -216.25, z = 16.25}  							--<< miejsce gdzie stoi dealer NPC
local pojazdCoords1 = {x = -118.5, y = 6455.31, z = 31.39}  		--<< ponizej koordynaty do randomowego respienia się pojazdu
local pojazdCoords2 = {x = -2957.75, y = 466.24, z = 15.18}
local pojazdCoords3 = {x = -1188.46, y = -323.9, z = 37.6}
local pojazdCoords4 = {x = 1208.09, y = 2699.29, z = 37.96}
local pojazdCoords5 = {x = 2588.92, y = -389.83, z = 92.37}
local BronKierowca = "WEAPON_APPISTOL" 		--<< BANKA ARACI ŞOFÖR SİLAHI
local BronPasazer = "WEAPON_APPISTOL"  			--<< BANKA ARACI KORUMA SİLAHI
local CzasDetonacji = 60 * 1000 			--<< PATLAMA ZAMANI
local czasPakowania = 60 * 1000 			--<< PARALARI ÇANTAYA DOLDURMA SÜRESİ
----------------------tego nizej nie ruszaj------------------------------
local prop
local wyjebalo = 0
local wysadzony = 0
local oznaczenie
local transport
local zrespione = 0
local ZrespTuPojazd = nil
local dealer
local ostrzezenie = 0
--------------------------------------------------------
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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 80)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords = GetEntityCoords(PlayerPedId(), false) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, MiejsceMisji.x, MiejsceMisji.y, MiejsceMisji.z)

			if dist <= 25.0  then
				if not DoesEntityExist(dealer) then
				RequestModel("s_m_y_dealer_01")
				while not HasModelLoaded("s_m_y_dealer_01") do
				Wait(10)
				end
				dealer = CreatePed(26, "s_m_y_dealer_01", dealerCoords.x, dealerCoords.y, dealerCoords.z, 268.9422, false, false)
				SetEntityHeading(dealer, 1.8)
				SetBlockingOfNonTemporaryEvents(dealer, true)
				TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false)
				end
				
			--DrawMarker(25, MiejsceMisji.x, MiejsceMisji.y, MiejsceMisji.z-0.90, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 1.3001, 0, 205, 250, 200, 0, 0, 0, 0)
			else
			Citizen.Wait(1500)
			end

            if dist <= 1.0 then
				DrawText3D(MiejsceMisji.x, MiejsceMisji.y, MiejsceMisji.z, "[~g~E~s~] Banka aracının yerini ögren")
				if IsControlJustPressed(0, Keys['E']) then
				TriggerServerEvent("napadtransport:akceptujto")
				Citizen.Wait(500)
				end
            end

end
end)
---

function PowiadomPsy()
	x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('napadtransport:zawiadompsy', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

RegisterNetEvent('napadtransport:infodlalspd')
AddEventHandler('napadtransport:infodlalspd', function(x, y, z)	
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
        TriggerEvent('police:bankakamyon')
        PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
		
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 67)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Banka Kamyonuna Saldırı')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(30000)
        RemoveBlip(blip)
	end
end)

function NotyfikacjaMisja()
PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
local czas = 0.550
SetNotificationTextEntry("STRING")
AddTextComponentString("Hedefiniz haritada işaretlendi, görevin başarılı olması için kendinizi hazırlayın.")
Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_DETONATEBOMB", "CHAR_DETONATEBOMB", true, 1, "Banka Aracı", "Soygun Görevi", czas)
DrawNotification_4(false, true)
end
---
--
RegisterNetEvent('napadtransport:Pozwolwykonac')
AddEventHandler('napadtransport:Pozwolwykonac', function()
NotyfikacjaMisja()
ClearPedTasks(dealer)
TaskWanderStandard(dealer, 100,100)
local losujCoordy = math.random(1,5)
if losujCoordy == 1 then
ZrespTuPojazd = pojazdCoords1
elseif losujCoordy == 2 then
ZrespTuPojazd = pojazdCoords2
elseif losujCoordy == 3 then
ZrespTuPojazd = pojazdCoords3
elseif losujCoordy == 4 then
ZrespTuPojazd = pojazdCoords4
elseif losujCoordy == 5 then
ZrespTuPojazd = pojazdCoords5
end

RequestModel(GetHashKey('stockade'))
while not HasModelLoaded(GetHashKey('stockade')) do
Citizen.Wait(0)
end

SetNewWaypoint(ZrespTuPojazd.x, ZrespTuPojazd.y)
ClearAreaOfVehicles(ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, 15.0, false, false, false, false, false) 
				
transport = CreateVehicle(GetHashKey('stockade'), ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, -2.436,  996.786, 25.1887, true, true)
SetEntityAsMissionEntity(transport)
SetEntityHeading(transport, 52.00)
oznaczenie = AddBlipForEntity(transport)
SetBlipSprite(oznaczenie, 57)
SetBlipColour(oznaczenie, 1)
SetBlipFlashes(oznaczenie, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString('Banka Kamyonu')
EndTextCommandSetBlipName(oznaczenie)
--
RequestModel("s_m_m_security_01")
while not HasModelLoaded("s_m_m_security_01") do
Wait(10)
end
local pilot = CreatePedInsideVehicle(transport, 1, "s_m_m_security_01", -1, true, true)
local nawigator = CreatePedInsideVehicle(transport, 1, "s_m_m_security_01", 0, true, true)
SetPedFleeAttributes(pilot, 0, 0)
SetPedCombatAttributes(pilot, 46, 1)
SetPedCombatAbility(pilot, 100)
SetPedCombatMovement(pilot, 2)
SetPedCombatRange(pilot, 2)
SetPedKeepTask(pilot, true)
GiveWeaponToPed(pilot, GetHashKey(BronKierowca),250,false,true)
SetPedAsCop(pilot, true)
--
SetPedFleeAttributes(nawigator, 0, 0)
SetPedCombatAttributes(nawigator, 46, 1)
SetPedCombatAbility(nawigator, 100)
SetPedCombatMovement(nawigator, 2)
SetPedCombatRange(nawigator, 2)
SetPedKeepTask(nawigator, true)
TaskEnterVehicle(nawigator,transport,-1,0,1.0,1)
GiveWeaponToPed(nawigator, GetHashKey(BronPasazer),250,false,true)
SetPedAsCop(nawigator, true)

TaskVehicleDriveWander(pilot, transport, 80.0, 443)
zrespione = 1
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		
		if zrespione == 1 then
			local plyCoords = GetEntityCoords(PlayerPedId(), false)
			local transCoords = GetEntityCoords(transport) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, transCoords.x, transCoords.y, transCoords.z)

			if dist <= 55.0  then
			DrawMarker(0, transCoords.x, transCoords.y, transCoords.z+4.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 135, 31, 35, 100, 1, 0, 0, 0)
				if ostrzezenie == 0 then
				ostrzezenie = 1
				ESX.ShowNotification('Bir yük yerleştirmeden önce korumadan kurtulun.')
				end
			else
			Citizen.Wait(500)
			end
			--local ped = PlayerPedId()
			--local veh = GetClosestVehicle(ped)
			--local transCoordsa = GetWorldPositionOfEntityBone(transCoords, GetEntityBoneIndexByName(transCoords, "exhaust"))
			if dist <= 4.5 and wysadzony == 0 then
				DrawText3D(transCoords.x, transCoords.y, transCoords.z, "[~g~G~s~] Arka kapıyı patlat!")
				--hintToDisplay('arka kapıyı havaya uçurup parayı almak ~INPUT_DETONATE~ Basın')
				if IsControlJustPressed(0, Keys['G']) then
				ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
					if quantity > 0 then				
					SprawdzInformacjePojazdowe()
					Citizen.Wait(500)
					else
					-- exports['mythic_notify']:SendAlert('error', "Üzerinde C4 yok!")
					TriggerEvent('notification', 'Üzerinde C4 yok!', 2)	
					end
					end, 'c4_bank')
				end
			end
			
			
		else
		Citizen.Wait(1500)
		end
end
end)

function SprawdzInformacjePojazdowe()
if IsVehicleStopped(transport) then
	if IsVehicleSeatFree(transport, -1) and IsVehicleSeatFree(transport, 0) and IsVehicleSeatFree(transport, 1) then
	wysadzony = 1
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
	while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
	Citizen.Wait(50)
	end
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"),true)
	FreezeEntityPosition(PlayerPedId(), true)
	TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(5500)
	ClearPedTasks(PlayerPedId())
	DetachEntity(prop)
	AttachEntityToEntity(prop, transport, GetEntityBoneIndexByName(transport, 'door_pside_r'), -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	--ESX.ShowNotification('~y~Yük patlatılacak ~g~'..CzasDetonacji / 1000 ..' saniye.')
	ESX.TriggerServerCallback("bankakamyonn:c4sil",function()
	end)
	exports["t0sic_loadingbar"]:StartDelayedFunction("Arka kapılar patlayacak", 60000, function()
		TriggerEvent('esx_status:add', source, 'stress', 100000)
		-- exports['mythic_notify']:SendAlert('error', 'Stresin arttı')
		TriggerEvent('notification', 'Stresin arttı', 2)
	end)
	FreezeEntityPosition(PlayerPedId(), false)
	Citizen.Wait(CzasDetonacji)
	local transCoords = GetEntityCoords(transport)
	SetVehicleDoorBroken(transport, 2, false)
	SetVehicleDoorBroken(transport, 3, false)
	AddExplosion(transCoords.x,transCoords.y,transCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
	ApplyForceToEntity(transport, 0, transCoords.x,transCoords.y,transCoords.z, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
	wyjebalo = 1
	ESX.ShowNotification('Paraları toplamaya başlayabilirsin.')
	RemoveBlip(oznaczenie)
	PowiadomPsy()
	else
	ESX.ShowNotification('Yükü yerleştirmek için araç boş olmalıdır')
	end
else
ESX.ShowNotification('Hareket eden bir aracı soymayacaksınız.')
end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		
		if wyjebalo == 1 then
			local plyCoords = GetEntityCoords(PlayerPedId(), false)
			local transCoords = GetEntityCoords(transport) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, transCoords.x, transCoords.y, transCoords.z)

			if dist > 45.0 then
			Citizen.Wait(500)
			end
			
			if dist <= 4.5 then
				DrawText3D(transCoords.x, transCoords.y, transCoords.z, "[~g~E~s~] Paraları topla!")
				if IsControlJustPressed(0, Keys['E']) then 
				wyjebalo = 0
				ZabieranieSiana()
				Citizen.Wait(500)
				end
			end
		else
		Citizen.Wait(1500)
		end
end
end)

function ZabieranieSiana()
RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
Citizen.Wait(50)
end
local PedCoords = GetEntityCoords(PlayerPedId())
torba = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
AttachEntityToEntity(torba, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
FreezeEntityPosition(PlayerPedId(), true)
ESX.ShowNotification('~y~Nakit parayı bir çantaya koyuyorsun.')
exports["t0sic_loadingbar"]:StartDelayedFunction("Paraları çantaya yerleştiriyorsun", 60000, function()
end)
Citizen.Wait(czasPakowania)
DeleteEntity(torba)
ClearPedTasks(PlayerPedId())
FreezeEntityPosition(PlayerPedId(), false)
SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 2)
TriggerServerEvent("napadtransport:graczZrobilnapad")
wyjebalo = 0
wysadzony = 0
zrespione = 0
Citizen.Wait(2500)
end

