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

ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	ScriptLoaded()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function ScriptLoaded()
	Citizen.Wait(1000)
	LoadMarkers()
end

local AnimalPositions = {
	{ x = -545.97, y = 5548.404, z = 59.72 },
	{ x = -419.72, y = 5869.600, z = 43.41 },
	{ x = -532.77, y = 6017.024, z = 31.04 },
	{ x = -831.21, y = 5975.78, z = 20.53 },
	{ x = -922.90, y = 5495.73, z = 7.91 },
	{ x = -512.2154, y = 5735.314, z = 46.41 },
	{ x = -696.29, y = 5611.42, z = 29.33 },
}

local AnimalsInSession = {}

local Positions = {
	['StartHunting'] = { ['hint'] = '[E] Start Hunting', ['x'] = -672.94, ['y'] = 5836.08, ['z'] = 17.31 },
	['Sell'] = { ['hint'] = '[E] Hayvan Eti Satış', ['x'] = -678.60, ['y'] = 5837.76, ['z'] = 17.31 },
	['SpawnATV'] = { ['x'] = -1491.83, ['y'] = 4975.66, ['z'] = 63.28 }
}

local OnGoingHuntSession = false
local HuntCar = nil

function LoadMarkers()

	Citizen.CreateThread(function()
		for index, v in ipairs(Positions) do
			if index ~= 'SpawnATV' then
				local StartBlip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(StartBlip, 442)
				SetBlipColour(StartBlip, 75)
				SetBlipScale(StartBlip, 0.7)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Hunting Spot')
				EndTextCommandSetBlipName(StartBlip)
			end
		end
	end)

	LoadModel('blazer')
	LoadModel('a_c_deer')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')

	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			
			local plyCoords = GetEntityCoords(PlayerPedId())

			for index, value in pairs(Positions) do
				if value.hint ~= nil then

					if OnGoingHuntSession and index == 'StartHunting' then
						value.hint = '[E] Basarak Avlamayı Durdurabilirsiniz'
					elseif not OnGoingHuntSession and index == 'StartHunting' then
						value.hint = '[E] Kendi Silahın ile Avlamaya Başlayabilirsin'
					end

					local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)

					if distance < 5.0 then
						sleep = 5
						DrawM(value.hint, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
						if distance < 1.0 then
							if IsControlJustReleased(0, Keys['E']) then
								if index == 'StartHunting' then
									StartHuntingSession()
								else
									SellItems()
								end
							end
						end
					end

				end
				
			end
			Citizen.Wait(sleep)
		end
	end)
end

function StartHuntingSession()

	if OnGoingHuntSession then

		OnGoingHuntSession = false

		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYSNIPER"), true, true)
		--RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), true, true)

		DeleteEntity(HuntCar)

		for index, value in pairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end

	else
		OnGoingHuntSession = true

		--Car

		--HuntCar = CreateVehicle(GetHashKey('blazer'), Positions['SpawnATV'].x, Positions['SpawnATV'].y, Positions['SpawnATV'].z, 169.79, true, false)

		--GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYSNIPER"),0, true, false)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"),0, true, false)

		--Animals

		Citizen.CreateThread(function()

				
			for index, value in pairs(AnimalPositions) do
				local Animal = CreatePed(5, GetHashKey('a_c_deer'), value.x, value.y, value.z, 0.0, true, false)
				TaskWanderStandard(Animal, true, true)
				SetEntityAsMissionEntity(Animal, true, true)
				--Blips

				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipSprite(AnimalBlip, 153)
				SetBlipColour(AnimalBlip, 1)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Avlanabilir Avlar')
				EndTextCommandSetBlipName(AnimalBlip)


				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
			end

			while OnGoingHuntSession do
				local sleep = 500
				for index, value in ipairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local AnimalHealth = GetEntityHealth(value.id)
						
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

						if AnimalHealth <= 0 then
							SetBlipColour(value.Blipid, 3)
							if PlyToAnimal < 2.0 then
								sleep = 5

								ESX.Game.Utils.DrawText3D({x = AnimalCoords.x, y = AnimalCoords.y, z = AnimalCoords.z + 1}, '[E] Hayvanın İçini Açmak İçin', 0.4)

								if IsControlJustReleased(0, Keys['E']) then
									if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE')  then
										if DoesEntityExist(value.id) then
											table.remove(AnimalsInSession, index)
											SlaughterAnimal(value.id)
										end
									else
										ESX.ShowNotification('Knife Üstünüzde Yok')
									end
								end

							end
						end
					end
				end

				Citizen.Wait(sleep)

			end
				
		end)
	end
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())

	local AnimalWeight = math.random(10, 160) / 10

	ESX.ShowNotification('Hayvanı kestin ve bir et aldın ' ..AnimalWeight.. 'kg')

	TriggerServerEvent('esx-qalle-hunting:reward', AnimalWeight)

	DeleteEntity(AnimalId)
end

function SellItems()
	TriggerServerEvent('esx-qalle-hunting:sell')
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function DrawM(hint, type, x, y, z)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
	--DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end