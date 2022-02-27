ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

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

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0

			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
local able = false
Citizen.CreateThread(function()
	local timer = 10000
	while true do
		Wait(1000)
		timer = timer -1000
		if timer == 0 then
			able = true
			timer = 10000
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleepthread = 5000
		if fishing then
			sleepthread = 5

			-- if IsControlJustReleased(0, 174) then
			-- 	input = 6
			-- end
			-- if IsControlJustReleased(0, 175) then
			-- 	input = 7
			-- end
			-- if IsControlJustReleased(0, 172) then
			-- 	input = 8
			-- end
			-- if IsControlJustReleased(0, 173) then
			-- 	input = 9
			-- end
			
			
			if IsControlJustReleased(0, 73) then
				fishing = false
				ClearPedTasks(GetPlayerPed(-1))
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Balık tutma işlemi durduruldu."})
			end
			
			playerPed = GetPlayerPed(-1)
			local pos = GetEntityCoords(GetPlayerPed(-1))
			if (pos.y <= 4244 and pos.y >= 4214) and (pos.x <= 1343 and pos.x >= 1295) or IsPedInAnyVehicle(GetPlayerPed(-1)) then
				DisableControlAction(0, 37) --tab
			else
				fishing = false
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Balık tutma işlemi durduruldu."})
			end
			if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Balık tutma işlemi durduruldu."})
			end
			
			-- if pausetimer > 6 then
			-- 	input = 99
			-- end
			
			-- if pause then
			-- 	pause = false
				-- if input == correct then
			if able then
				able = false
				TriggerEvent('fishing:minigame')
			end
                -- if stat == 100 then
				-- 	TriggerServerEvent('fishing:catch') --bait
				-- else
				-- 	-- ESX.ShowNotification("Balık kaçtı!")
				-- 	TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Balık kaçtı!"})
				-- end
			-- end
		end

		Citizen.Wait(sleepthread)
	end
end)

Citizen.CreateThread(function()
	while true do
		sleepthread = 500
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 3 then
			sleepthread = 5
			TriggerServerEvent('fishing:startSelling', "fish")
			Citizen.Wait(1500)
		end
		Citizen.Wait(sleepthread)
	end
end)


RegisterNetEvent('fishing:minigame')
AddEventHandler('fishing:minigame', function()
	local sex = true
	able = false
	if sex then
		sex = not sex
		ESX.TriggerServerCallback('fishing:checkbait',function(state)
			if state then
				local stat = exports['reload-skillbar']:taskBar(math.random(1500,4500),math.random(3,7))
				if stat == 100 then
					TriggerServerEvent('fishing:catch')
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = "Balığı yakaladın."})
				else
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Senin balık kaçtı!"})
				end
			else
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Yemin yok!"})
				TriggerEvent('fishing:break')
				fishing = false
			end
		end)
	end
end)
				
Citizen.CreateThread(function()
	while true do
		local sleepthread = 3000
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 10 then
			sleepthread = 5
			DrawMarker(29, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z-0.4 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 127, 255, 0, 30, false, true, 2, false, false, false, false)
		end
		Citizen.Wait(sleepthread)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
-- 		Citizen.Wait(wait)
-- 		if fishing then
-- 			-- pause = true
-- 			stat = exports['taskbarskill']:taskBar(math.random(1500,4500),math.random(3,7))
-- 		end
-- 	end
-- end)

RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	local playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	-- local data = exports['m3_base']:getOsTime()
	-- if data.hour < data.min or (data.hour > data.max and data.hour < data.min) then
		if IsPedInAnyVehicle(playerPed) then
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Aracın içinde balık tutamazsın!"})
		else
			if (pos.y <= 4244 and pos.y >= 4214) and (pos.x <= 1343 and pos.x >= 1295) then
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = "Balık tutmaya başladın."})
				TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
				fishing = true
			else
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Burada hiç balık gözükmüyor!"})
			end
		end
	-- else
	-- 	exports['mythic_notify']:SendAlert('error', 'Şu anda bunu yapamazsın!', 5000)
	-- end
end)

--4214-4264 4239 25
--1299-1342 1320,5 21.5