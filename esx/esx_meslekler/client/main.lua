Keys = {
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

ESX								= nil
PlayerData						= nil
local playerDuty 				= false
local loadBlip					= nil
local sellBlip					= nil
local playerLoading 			= false
local playerVehicle 			= nil
local antibug = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

--						 FUNCTIONS, NATIVES, ETC...			--

function FloatingHelpText(text)   
    BeginTextCommandDisplayHelp("STRING") 
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

Citizen.CreateThread(function()	
	for _, v in pairs(Config['Trucker'].Zones) do
		for i=1, #v.AdutyPos, 1 do
			local blip = AddBlipForCoord(v.AdutyPos[i].x, v.AdutyPos[i].y, v.AdutyPos[i].z)
			SetBlipAlpha(blip, 255)
			SetBlipDisplay(blip, 2)
			SetBlipAsFriendly(blip, true)
			SetBlipScale(blip, 0.8)
			SetBlipSprite(blip, 477)
			SetBlipAsShortRange(blip, true)			
			SetBlipColour(blip, 10)
			BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString("Nakliyat")
		    EndTextCommandSetBlipName(blip)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 2000
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
		for _, v in pairs(Config['Trucker'].Zones) do
			for i=1, #v.AdutyPos, 1 do
				if Vdist(x, y, z, v.AdutyPos[i].x, v.AdutyPos[i].y, v.AdutyPos[i].z) < 20.0 then
					DrawMarker(2, v.AdutyPos[i].x, v.AdutyPos[i].y, v.AdutyPos[i].z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 197, 0, 255, true, true, 2, false, nil, nil, false)
					sleep = 5
				end
			end	
			
			if playerDuty then
				if playerLoading then
					for i=1, #v.SellPos, 1 do
						if Vdist(x, y, z, v.SellPos[i].x, v.SellPos[i].y, v.SellPos[i].z) < 20.0 then
							DrawMarker(1, v.SellPos[i].x, v.SellPos[i].y, v.SellPos[i].z - 1, 0, 0, 0, 0, 0, 0, 7.0, 7.0, 0.5, 255, 197, 0, 75, false, false, 2, false, nil, nil, false)
							sleep = 5
						end
					end	
				end				
				for i=1, #v.LoadPos, 1 do
					if Vdist(x, y, z, v.LoadPos[i].x, v.LoadPos[i].y, v.LoadPos[i].z) < 20.0 then
						DrawMarker(1, v.LoadPos[i].x, v.LoadPos[i].y, v.LoadPos[i].z - 1, 0, 0, 0, 0, 0, 0, 20.0, 20.0, 0.5, 255, 197, 0, 75, false, false, 2, false, nil, nil, false)
						sleep = 5
					end
				end		
				for i=1, #v.TruckPos.SpawnLocation, 1 do
					if Vdist(x, y, z, v.TruckPos.SpawnLocation[i].x, v.TruckPos.SpawnLocation[i].y, v.TruckPos.SpawnLocation[i].z) < 20.0 then
						DrawMarker(39, v.TruckPos.SpawnLocation[i].x, v.TruckPos.SpawnLocation[i].y, v.TruckPos.SpawnLocation[i].z + 0.5, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 255, 197, 0, 255, false, true, 2, false, nil, nil, false)
						sleep = 5
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 2000
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
		for _, v in pairs(Config['Trucker'].Zones) do
			for i=1, #v.AdutyPos, 1 do
			if Vdist(x, y, z, v.AdutyPos[i].x, v.AdutyPos[i].y, v.AdutyPos[i].z) < 5.0 then
			sleep = 5
			end
				if Vdist(x, y, z, v.AdutyPos[i].x, v.AdutyPos[i].y, v.AdutyPos[i].z) < 1.2 then
					FloatingHelpText('Mesai menüsünü açmak için ~INPUT_CONTEXT~ tuşuna basın.')
					
					if IsControlPressed(0, Keys['E']) then
						ShowPlayerTruckerDuty()
					end
				end
			end	
			
			if playerDuty then
				for i=1, #v.TruckPos.SpawnLocation, 1 do
				if Vdist(x, y, z, v.TruckPos.SpawnLocation[i].x, v.TruckPos.SpawnLocation[i].y, v.TruckPos.SpawnLocation[i].z) < 5.0 then
				sleep = 5
				end
					if Vdist(x, y, z, v.TruckPos.SpawnLocation[i].x, v.TruckPos.SpawnLocation[i].y, v.TruckPos.SpawnLocation[i].z) < 1.2 then
						FloatingHelpText('Aracı çıkarmak için ~INPUT_CONTEXT~ tuşuna basın.')
						
						if IsControlPressed(0, Keys['E']) then
							CreateTruckForPlayer()
						end
					end
				end
				
				for i=1, #v.LoadPos, 1 do
				if Vdist(x, y, z, v.LoadPos[i].x, v.LoadPos[i].y, v.LoadPos[i].z) < 30.0 then
				sleep = 5
				end
					if Vdist(x, y, z, v.LoadPos[i].x, v.LoadPos[i].y, v.LoadPos[i].z) < 20.0 then
						FloatingHelpText('Yük doldurmak için ~INPUT_CONTEXT~ tuşuna basın.')
						
						if IsControlPressed(0, Keys['E']) then
							InitiliazeTruck()
						end
					end
				end
				
				if playerLoading then
					for i=1, #v.SellPos, 1 do
					if Vdist(x, y, z, v.SellPos[i].x, v.SellPos[i].y, v.SellPos[i].z) < 10.0 then
					sleep = 5
					end
						if Vdist(x, y, z, v.SellPos[i].x, v.SellPos[i].y, v.SellPos[i].z) < 7.0 then
							FloatingHelpText('Yükü boşaltmak için ~INPUT_CONTEXT~ tuşuna basın.')
							
							if IsControlPressed(0, Keys['E']) then
								FinishTruck()
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

function FinishTruck()
	if playerLoading then
		if antibug == true then
			TriggerEvent('notification', 'Kamyonun kasasını doldurmadan satış yapamazsın!', 2)
		else
		if GetVehiclePedIsIn(PlayerPedId(), false) == playerVehicle then
			ClearTruckConfig()
			finishTruckConfig()
			TriggerServerEvent('esx_meslekler:finishTruck', GetPlayerServerId(PlayerId()))
		else
			ESX.ShowNotification('Satışı tamamlamak için kamyonda olmanız gerekiyor!')
		end
	end
	end
end

function finishTruckConfig()
	if playerVehicle ~= nil then
		ESX.Game.DeleteVehicle(playerVehicle)
	end
	
	playerLoading = false
	
	if loadBlip ~= nil then
		RemoveBlip(loadBlip)
		loadBlip = nil
	end
	
	if sellBlip ~= nil then
		RemoveBlip(sellBlip)
		sellBlip = nil
	end
	
	RestartTruckForPlayer()
end

function ClearTruckConfig()
	if playerVehicle ~= nil then
		ESX.Game.DeleteVehicle(playerVehicle)
	end
	
	playerLoading = false
	
	if loadBlip ~= nil then
		RemoveBlip(loadBlip)
		loadBlip = nil
	end
	
	if sellBlip ~= nil then
		RemoveBlip(sellBlip)
		sellBlip = nil
	end
end

function RestartTruckForPlayer()
	playerDuty = true
	local playerPed = PlayerId()
	
	-- Kıyafet değişecek, Alım yerinin(çöl) blipi gözükecek, alım ve satıma e basma eklenecek, tır çıkarılıp o noktaya ışınlancak
	for _, v in pairs(Config['Trucker'].Zones) do
		for i=1, #v.LoadPos, 1 do
			Citizen.CreateThread(function()
				local blip = AddBlipForCoord(v.LoadPos[i].x, v.LoadPos[i].y, v.LoadPos[i].z)
				SetBlipAlpha(blip, 255)
				SetBlipDisplay(blip, 2)
				SetBlipAsFriendly(blip, true)
				SetBlipScale(blip, 0.8)
				SetBlipSprite(blip, 477)
				SetBlipAsShortRange(blip, true)			
				SetBlipColour(blip, 10)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Yük Alım")
				EndTextCommandSetBlipName(blip)
				loadBlip = blip
			end)							
		end
	end
end

function InitiliazeTruck()
	Citizen.Wait(500)
	if not playerLoading then
		if GetVehiclePedIsIn(PlayerPedId(), false) == playerVehicle then
			playerLoading = true
			exports["t0sic_loadingbar"]:StartDelayedFunction('Yük dolduruluyor', 5000, function()
					local veh = GetVehiclePedIsIn(PlayerPedId(), false)
					SetVehicleExtra(veh, 2, false)
					antibug = false
					ClearPedTasks(PlayerPedId())
					for _, v in pairs(Config['Trucker'].Zones) do
						for i=1, #v.SellPos, 1 do
							Citizen.CreateThread(function()
								local blip = AddBlipForCoord(v.SellPos[i].x, v.SellPos[i].y, v.SellPos[i].z)
								SetBlipAlpha(blip, 255)
								SetBlipDisplay(blip, 2)
								SetBlipAsFriendly(blip, true)
								SetBlipScale(blip, 0.8)
								SetBlipSprite(blip, 477)
								SetBlipAsShortRange(blip, true)			
								SetBlipColour(blip, 10)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("Yük Satış")
								EndTextCommandSetBlipName(blip)
								sellBlip = blip
							end)
						end
					end
				end)									
		else
			ESX.ShowNotification('Yük almak için araca ihtiyacın var!')
		end
	else
		ESX.ShowNotification('Zaten yük almışsınız, satış yapma noktasına gidiniz.')
	end
end

function CreateTruckForPlayer()
	-- spawn pos 870.29 -2360.86 30.35 351.59
	local spawnCoords = {['x'] = 870.29, ['y'] = -2360.86, ['z'] = 30.35}
	local vehicles = ESX.Game.GetVehiclesInArea(spawnCoords, 15.0)
	
	if #vehicles > 0 then
		ESX.ShowNotification('Araç çıkarmak için bölgedeki araçların uzaklaşması gerekiyor.')
	else
		ESX.Game.SpawnVehicle('tiptruck2', spawnCoords, 351.59, function(vehicle)
			TaskEnterVehicle(PlayerPedId(), vehicle, 5000, -1, 2.0, 16, 0)
			SetVehicleExtra(vehicle, 2, true)
			playerVehicle = vehicle
			antibug = true
		end)
		Wait(1500)
	end
end

function ShowPlayerTruckerDuty()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu',
		{
			title = 'Mesai',
			align = 'top-left',
			elements = {
				{ label = 'Mesai Başla', value = 'dutyon' },
				{ label = 'Mesai Bitir', value = 'dutyoff' }
			}
		},
		
		function(data, menu)
			if data.current.value == 'dutyon' then
				menu.close()
				
				if not playerDuty then
					playerDuty = true
					local playerPed = PlayerId()
					
					-- Kıyafet değişecek, Alım yerinin(çöl) blipi gözükecek, alım ve satıma e basma eklenecek, tır çıkarılıp o noktaya ışınlancak
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
							if Config.MainUniforms.male ~= nil then
								TriggerEvent('skinchanger:loadClothes', skin, Config.MainUniforms.male)
							else
								ESX.ShowNotification(_U('no_outfit'))
							end
						else
							if Config.MainUniforms.female ~= nil then
								TriggerEvent('skinchanger:loadClothes', skin, Config.MainUniforms.female)
							else
								ESX.ShowNotification(_U('no_outfit'))
							end
						end
					end)
					
					ESX.ShowNotification('Mesaiye başladınız!')
					
					for _, v in pairs(Config['Trucker'].Zones) do
						for i=1, #v.LoadPos, 1 do
							Citizen.CreateThread(function()
								local blip = AddBlipForCoord(v.LoadPos[i].x, v.LoadPos[i].y, v.LoadPos[i].z)
								SetBlipAlpha(blip, 255)
								SetBlipDisplay(blip, 2)
								SetBlipAsFriendly(blip, true)
								SetBlipScale(blip, 0.8)
								SetBlipSprite(blip, 477)
								SetBlipAsShortRange(blip, true)			
								SetBlipColour(blip, 10)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("Yük Alım")
								EndTextCommandSetBlipName(blip)
								loadBlip = blip
							end)							
						end
					end
				else
					ESX.ShowNotification('Zaten mesaidesiniz!')
				end
			
			elseif data.current.value == 'dutyoff' then -- Breakpoint 1
				menu.close()
				playerDuty = false
				ClearTruckConfig()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				ESX.ShowNotification('İşbaşını bıraktınız!')			
			end
		end,
		
		function(data, menu)
			menu.close()
		end
	)
end







