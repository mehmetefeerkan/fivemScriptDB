ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

    Citizen.CreateThread(function()
    
        while true do
            local sleep = 1000

            local plyCoords = GetEntityCoords(PlayerPedId())

            for location, val in pairs(Config.Teleporters) do

                local Enter = val['Enter']
                local Exit = val['Exit']
                local JobNeeded = val['Job']

                local dstCheckEnter, dstCheckExit = GetDistanceBetweenCoords(plyCoords, Enter['x'], Enter['y'], Enter['z'], true), GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true)

                if dstCheckEnter <= 2.2 then
                    sleep = 5
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then

                            DrawM(Enter['Information'], 27, Enter['x'], Enter['y'], Enter['z'])
                            DrawMarker(21, Enter['x'], Enter['y'], Enter['z'] + 0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, -0.6, 255, 255, 255, 100, false, true, 2, false, false, false, false)

                            if dstCheckEnter <= 2.2 then
                                if IsControlJustPressed(0, 38) then
                                
                                    Teleport(val, 'enter')
                                end
                            end

                        end
                    else
                        DrawM(Enter['Information'], 27, Enter['x'], Enter['y'], Enter['z'])
                        DrawMarker(21, Enter['x'], Enter['y'], Enter['z'] + 0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, -0.6, 255, 255, 255, 100, false, true, 2, false, false, false, false)

                        if dstCheckEnter <= 2.2 then

                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'enter')
                            end

                        end

                    end
                end

                if dstCheckExit <= 2.2 then
                    sleep = 5
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then

                            DrawM(Exit['Information'], 27, Exit['x'], Exit['y'], Exit['z'])

                            if dstCheckExit <= 1.2 then
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'exit')
                                    DrawMarker(21, Exit['x'], Exit['y'], Exit['z'] + 0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                                end
                            end

                        end
                    else

                        DrawM(Exit['Information'], 27, Exit['x'], Exit['y'], Exit['z'])
                        DrawMarker(21, Exit['x'], Exit['y'], Exit['z'] + 0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                        

                        if dstCheckExit <= 2.2 then

                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'exit')
                            end

                        end
                    end
                end

            end
            Citizen.Wait(sleep)
        end

    end)
--end

function Teleport(table, location)
    if location == 'enter' then
        DoScreenFadeOut(800)
        exports['pogressBar']:drawBar(2700, _U("entering"))
        Citizen.Wait(3000)
        ESX.Game.Teleport(PlayerPedId(), table['Exit'])
        DoScreenFadeIn(1300)
    else
        DoScreenFadeOut(800)
        exports['pogressBar']:drawBar(2700, _U("goout"))
        Citizen.Wait(3000)
        ESX.Game.Teleport(PlayerPedId(), table['Enter'])
        DoScreenFadeIn(1300)
    end
end


function DrawM(hint, type, x, y, z)
    DrawText3Ds(x, y, z + 1.0, hint, 0.2)
end

RegisterNetEvent('rx_items:joint')
AddEventHandler('rx_items:joint', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_snow_flower_02'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
		loadAnimDict("anim@heists@prison_heistig1_p1_guard_checks_bus")
		TaskPlayAnim(GetPlayerPed(-1), "anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		exports['pogressBar']:drawBar(2000, "Balíš...")
				Citizen.Wait(1600)
				IsAnimated = false
				ClearPedTasks(GetPlayerPed(-1))
		end)

	end
end)
--EFFECT
RegisterNetEvent('rx_items:alkohol')
AddEventHandler('rx_items:alkohol', function()
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
    Citizen.Wait(650)
    SetPedMotionBlur(playerPed, true)
    SetTimecycleModifier("spectator3")
    SetPedMovementClipset(playerPed, "move_m@hobo@a", true)
    SetPedIsDrunk(playerPed, true)
    ShakeGameplayCam("DRUNK_SHAKE", 1.0)
    Citizen.Wait(10000)
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
   
end)



function ObchodCelek()

	ESX.UI.Menu.CloseAll()
  
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'ObchodCelek',
	{
	  title    = 'Shop',
	  align    = 'top-left',
	  elements = {
		{label = 'RAW Rolling Papers (50 USD)', value = 'papirek'},
		{label = 'Pouch (50 USD)', value = 'sacek'},
	  }
	},
	  function(data, menu)
  
		if data.current.value == 'papirek' then
			menu.close()
            TriggerServerEvent('drc_pooch')
		end
		if data.current.value == 'sacek' then
			menu.close()
            TriggerServerEvent('drc_pooch')
		end
	end,
	  function(data, menu)
		menu.close()
	  end
	)
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true

		for k,v in pairs(Config.Shops) do
			local distance = #(playerCoords - v)

			if distance < 6 then
				letSleep = false

				local coords = GetEntityCoords(GetPlayerPed(-1))
				if(GetDistanceBetweenCoords(coords, v, true) < 6) then
					if GetDistanceBetweenCoords(coords, v, true) < 6 and GetDistanceBetweenCoords(coords, v, true) > 1.0 then
						DrawText3Ds(v.x, v.y, v.z + 0.2, tostring('Shop'))
					else
						DrawText3Ds(v.x, v.y, v.z + 0.2, tostring('[E] Shop'))
					end
				end

				if distance < 2 then
                    if IsControlJustReleased(0, 38) then
                    ObchodCelek()
                    end
				end
			end
		end
		if letSleep then
			Citizen.Wait(500)
		end
	end
end)