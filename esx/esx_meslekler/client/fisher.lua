-- Keys = {
	-- ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	-- ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	-- ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	-- ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	-- ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	-- ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	-- ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	-- ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	-- ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
-- }

-- ESX					= nil
-- PlayerData 			= nil
-- local fishingCount 	= false
-- local object 		= nil
-- local vehiclePlayer = nil

-- Citizen.CreateThread(function()
	-- while ESX == nil do
		-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- end
	
	-- PlayerData = ESX.GetPlayerData()
-- end)

-- RegisterNetEvent('esx:playerloaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
	-- PlayerData = xPlayer
-- end)

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(5)
		-- local pedCoords = GetEntityCoords(PlayerPedId())
		-- local x, y, z = table.unpack(pedCoords)
		
		-- for _, v in pairs(Config.Fisher) do
			-- if vehiclePlayer ~= nil then
				-- for i=1, #v.BoatSpawnPos, 1 do
					-- DrawMarker(1, v.BoatSpawnPos[i].x, v.BoatSpawnPos[i].y, 
					-- v.BoatSpawnPos[i].z - 1.0, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 1.0, 255, 0, 0, 50, 
					-- false, true, 2, false, nil, nil, false)
					
					-- if Vdist(x, y, z, v.BoatSpawnPos[i].x, v.BoatSpawnPos[i].y, v.BoatSpawnPos[i].z) < 8.0 then
						-- FloatingHelpText(_U('fisher_remove_vehicle'))
						
						-- if IsControlPressed(0, Keys['E']) then
							-- DeleteBoatForPlayer(v.BoatSpawnPos[i].x, v.BoatSpawnPos[i].y, v.BoatSpawnPos[i].z)
						-- end
					-- end
				-- end
			-- end
			
			-- for i=1, #v.BoatPos, 1 do
				-- DrawMarker(35, v.BoatPos[i].x, v.BoatPos[i].y, 
				-- v.BoatPos[i].z + 0.2, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 255, 255, 255, 200, 
				-- false, true, 2, false, nil, nil, false)
			
				-- if Vdist(x, y, z, v.BoatPos[i].x, v.BoatPos[i].y, v.BoatPos[i].z) < 1.2 then
					-- FloatingHelpText(_U('fisher_helptext'))
					
					-- if IsControlPressed(0, Keys['E']) then
						-- CreateBoatForPlayer()
					-- end
				-- end
			-- end
			
			-- for i=1, #v.SellPos, 1 do
				-- DrawMarker(42, v.SellPos[i].x, v.SellPos[i].y, 
				-- v.SellPos[i].z, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 255, 255, 255, 200, 
				-- false, true, 2, false, nil, nil, false)

				-- if Vdist(x, y, z, v.SellPos[i].x, v.SellPos[i].y, v.SellPos[i].z) < 1.2 then
					-- FloatingHelpText(_U('fisher_display_sell'))
					
					-- if IsControlPressed(0, Keys['E']) then
						-- SellFish()
					-- end
				-- end
			-- end
		-- end
	-- end
-- end)

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(10)
		-- if fishingCount == true then
			-- FloatingHelpText(_U('fisher_command_end'))
			
			-- if IsControlPressed(0, Keys['X']) then
				-- fishingCount = false
				-- if DoesEntityExist(object) and IsEntityAnObject(object) then
					-- DeleteObject(object)
					-- SetEntityAsNoLongerNeeded(object)
					-- object = nil
				-- end
			-- end
		-- end
	-- end
-- end)

-- Citizen.CreateThread(function()	
	-- for _, v in pairs(Config.Fisher) do
		-- for i=1, #v.SellPos, 1 do
			-- local blip = AddBlipForCoord(v.SellPos[i].x, v.SellPos[i].y, v.SellPos[i].z)
			-- SetBlipAlpha(blip, 255)
			-- SetBlipDisplay(blip, 2)
			-- SetBlipAsFriendly(blip, true)
			-- SetBlipScale(blip, 1.2)
			-- SetBlipSprite(blip, 356)
			-- SetBlipAsShortRange(blip, true)			
			-- SetBlipColour(blip, 3)
			-- BeginTextCommandSetBlipName("STRING")
		    -- AddTextComponentString("Marina")
		    -- EndTextCommandSetBlipName(blip)
		-- end
	-- end
-- end)


-- RegisterNetEvent('esx_fisher:controlOn')
-- AddEventHandler('esx_fisher:controlOn', function()
	-- FreezeEntityPosition(PlayerPedId(),false)
-- end)


-- function SellFish()
	-- FreezeEntityPosition(PlayerPedId(),true)
	-- TriggerServerEvent('esx_fisher:sellFish', GetPlayerServerId(PlayerId()))
-- end

-- function CreateBoatForPlayer()
	-- Citizen.Wait(100)
	-- ESX.TriggerServerCallback('esx_fisher:shipRetailPay', function(cb)
		-- if cb then
			-- for _, v in pairs(Config.Fisher) do
				-- for i=1, #v.BoatSpawnPos, 1 do
					-- local coords = {}
					-- coords['x'], coords['y'], coords['z'] = v.BoatSpawnPos[i].x, v.BoatSpawnPos[i].y, v.BoatSpawnPos[i].z
					
					-- local vehicles = ESX.Game.GetVehiclesInArea(coords, 10.0)
					-- if #vehicles < 1 then
						-- ESX.Game.SpawnVehicle(GetHashKey(v.ShipHash), coords, 149.79, function(vehicle)	
							-- vehiclePlayer = vehicle
						-- end)
					-- else
						-- ESX.ShowNotification(_U('fisher_error_createship'))
					-- end
				-- end
			-- end
		-- else
			-- ESX.ShowNotification(_U('fisher_error_retailpay'))
		-- end
	-- end)
-- end

-- function DeleteBoatForPlayer(x1, y1, z1)
	-- Citizen.Wait(100)
	-- local coords = {
			-- x = x1,
			-- y = y1,
			-- z = z1
	-- }
	-- local veh = ESX.Game.GetClosestVehicle(coords)
	-- if DoesEntityExist(veh) and IsEntityAVehicle(veh) and veh == vehiclePlayer then
		-- ESX.Game.DeleteVehicle(veh)
		-- vehiclePlayer = nil
	-- end
-- end
	
-- function FloatingHelpText(text)   
    -- BeginTextCommandDisplayHelp("STRING") 
    -- AddTextComponentSubstringPlayerName(text)
    -- EndTextCommandDisplayHelp(0, 0, 1, -1)
-- end

-- function startAnim(lib, anim)
 	
	-- Citizen.CreateThread(function()

	  -- RequestAnimDict(lib)
	  
	  -- while not HasAnimDictLoaded( lib) do
	    -- Citizen.Wait(5)
	  -- end

	  -- TaskPlayAnim(PlayerPedId(), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false )

	-- end)

-- end

-- RegisterCommand('baliktut', function(source, args, raw)
	-- if fishingCount then
		-- ESX.ShowNotification(_U('fisher_command_error_try'))
	-- else
		-- local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
		-- local retval, height = GetWaterHeight(x, y, z)
		-- if retval then
			-- local coords = {
				-- x = GetEntityCoords(PlayerPedId()).x,
				-- y = GetEntityCoords(PlayerPedId()).y,
				-- z = GetEntityCoords(PlayerPedId()).z
			-- }
			-- local veh = ESX.Game.GetClosestVehicle(coords)
			-- if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
				-- fishingCount = true
				-- object = CreateObject(GetHashKey('prop_fishing_rod_01'), coords.x, coords.y, coords.z, 1)
				-- AttachEntityToEntity(object, PlayerPedId(), 48, 0.0, -0.0300000012, 0.0, -9.99999714, 0.0, 9.99999905, 1, 1, 0, 1, 0, 1)
				-- SetEntityAsMissionEntity(object, true, true)
				-- SetEntityInvincible(object, true)
				-- SetEntityCollision(object, false, true)
				-- Citizen.CreateThread(function()
					-- while fishingCount == true do
						-- if fishingCount == false then
							-- break
						-- end
						-- startAnim('amb@world_human_stand_fishing@idle_a', 'idle_a')
						-- Citizen.Wait(5000)
						-- if fishingCount == false then
							-- break
						-- end
						-- startAnim('amb@world_human_stand_fishing@idle_a', 'idle_b')
						-- Citizen.Wait(2000)
						-- if fishingCount == false then
							-- break
						-- end
						-- startAnim('amb@world_human_stand_fishing@idle_a', 'idle_c')
						-- Citizen.Wait(6000)
						-- if fishingCount == false then
							-- break
						-- end
						-- TriggerServerEvent('esx_fisher:randomFish')
					-- end
				-- end)
			-- else
				-- ESX.ShowNotification(_U('fisher_error_command'))
			-- end
		-- else
			-- ESX.ShowNotification(_U('fisher_error_command'))
		-- end
	-- end
-- end)