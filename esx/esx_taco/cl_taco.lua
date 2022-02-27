-- Client Events Register
RegisterNetEvent('esx:playerLoaded')
RegisterNetEvent('esx:setJob')
RegisterNetEvent('Ori_tacoruns:searchforjob')

ESX = nil
local PlayerData = {}
local inMission = false
local MissionCoords = false
local Mblip = false
local have = false
local jobVeh = false
local ped = PlayerPedId()
local elleryikandi = false

-- Setup ESX Core
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

-- Take Player Data After Player Loadout
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer 
end)

-- Takes Player Job After /setjob
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	Citizen.Wait(10)
end)


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
	sleep = 2000
		for k,v in pairs(Config.Elyika) do
			local coords = GetEntityCoords(playerPed)
			local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
			if dist < 2.0  then
				sleep = 5
			end
			if dist < 1.0  then
				if not inMission then
					DrawText3D(v.x, v.y, v.z, ('[E] Ellerini Yıka'))	
					if IsControlJustReleased(0, 46) and (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.5) and not onwork then
						onwork = true
						TriggerServerEvent("raider-tacoruns:server")
						ClearPedSecondaryTask(PlayerPedId())
						loadAnimDict( "mp_prison_break" ) 
						TaskPlayAnim( PlayerPedId(), "mp_prison_break", "hack_loop", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
						exports["t0sic_loadingbar"]:StartDelayedFunction("Ellerini yıkıyorsun", 6000, function()
						-- exports['mythic_notify']:SendAlert('inform', 'Ellerin tertemiz oldu', 1500)
						TriggerEvent('notification', 'Ellerin tertemiz oldu', 1)
						elleryikandi = true
						onwork = false
						ClearPedTasks(PlayerPedId())
						end)
					end
				end
		end
	end
	Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
	sleep = 2000
		for k,v in pairs(Config.TacoIsit) do
			local coords = GetEntityCoords(playerPed)
			local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
			if dist < 2.0  then
				sleep = 5
			end
			if dist < 1.0  then
				if not inMission then
					DrawText3D(v.x, v.y, v.z, ('[E] Et Pisir'))	
					if IsControlJustReleased(0, 46) and (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.3) and not onwork then
							if elleryikandi then
								onwork = true
								TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
								exports["t0sic_loadingbar"]:StartDelayedFunction("Et pişiriyorsun", 10000, function()
								ClearPedTasksImmediately(PlayerPedId())
								TriggerServerEvent('raider-tacoruns:add', 'item', 1, Config.Et)
								onwork = false
								end)
							else 
								ESX.ShowNotification('Temizlik önemli, önce ellerini yıkamalısın.')
							end	
					end
				end
		end
	end
	Citizen.Wait(sleep)
end
end)
Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
	sleep = 2000
		for k,v in pairs(Config.Tacomake) do
			local coords = GetEntityCoords(playerPed)
			local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
			if dist < 2.0  then
				sleep = 5
			end
			if dist < 1.0  then
				if not inMission then
					DrawText3D(v.x, v.y, v.z, ('[E] Taco Hazırla'))	
					if IsControlJustReleased(0, 46) and (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.3) and not onwork then
						if elleryikandi then
							ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
							if quantity > 0 then
								onwork = true
							ClearPedSecondaryTask(PlayerPedId())
							loadAnimDict( "mini@repair" ) 
							TaskPlayAnim( PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
							exports["t0sic_loadingbar"]:StartDelayedFunction("Taco hazırlanıyor", 9700, function()
							ClearPedTasks(PlayerPedId())
							TriggerServerEvent('raider-tacoruns:remove', 'item', 1, Config.Et)
							TriggerServerEvent('raider-tacoruns:add', 'item', 1, Config.Item)
							onwork = false
							end)
							else
							-- exports['mythic_notify']:SendAlert('error', "Taco yapmak için ete ihtiyacın var")
							TriggerEvent('notification', 'Taco yapmak için ete ihtiyacın var', 2)
							end
							end, Config.Et)
						else 
							-- ESX.ShowNotification('Temizlik önemli, önce ellerini yıkamalısın.')
							TriggerEvent('notification', 'Temizlik önemli, önce ellerini yıkamalısın', 2)
						end
					end
				end
		end
	end
	Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
	sleep = 2000
		for k,v in pairs(Config.By) do
			local coords = GetEntityCoords(playerPed)
			local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
			if dist < 2.0  then
				sleep = 5
			end
			if dist < 1.0  then
				if not inMission then
					DrawText3D(v.x, v.y, v.z, ('[E] Burrito Hazırla'))	
					if IsControlJustReleased(0, 46) and (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.3) and not onwork then
						if elleryikandi then
							ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
							if quantity > 0 then
								onwork = true
							ClearPedSecondaryTask(PlayerPedId())
							loadAnimDict( "mini@repair" ) 
							TaskPlayAnim( PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
							exports["t0sic_loadingbar"]:StartDelayedFunction("Burrito hazırlanıyor", 9700, function()
							ClearPedTasks(PlayerPedId())
							TriggerServerEvent('raider-tacoruns:remove', 'item', 1, Config.Et)
							TriggerServerEvent('raider-tacoruns:add', 'item', 1, Config.Burritoy)
							onwork = false
							end)
							else
							-- exports['mythic_notify']:SendAlert('error', "Burrito yapmak için ete ihtiyacın var")
							TriggerEvent('notification', 'Burrito yapmak için ete ihtiyacın var', 2)
							end
							end, Config.Et)
						else 
							-- ESX.ShowNotification('Temizlik önemli, önce ellerini yıkamalısın.')
							TriggerEvent('notification', 'Temizlik önemli, önce ellerini yıkamalısın', 2)
						end
					end
				end
		end
	end
	Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
	sleep = 2000
		for k,v in pairs(Config.Ty) do
			local coords = GetEntityCoords(playerPed)
			local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
			if dist < 2.0  then
				sleep = 5
			end
			if dist < 1.0  then
				if not inMission then
					DrawText3D(v.x, v.y, v.z, ('[E] Temales Hazırla'))	
					if IsControlJustReleased(0, 46) and (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.3) and not onwork then
						if elleryikandi then
							ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
							if quantity > 0 then
								onwork = true
							ClearPedSecondaryTask(PlayerPedId())
							loadAnimDict( "mini@repair" ) 
							TaskPlayAnim( PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
							exports["t0sic_loadingbar"]:StartDelayedFunction("Temales hazırlanıyor", 9700, function()
							ClearPedTasks(PlayerPedId())
							TriggerServerEvent('raider-tacoruns:remove', 'item', 1, Config.Et)
							TriggerServerEvent('raider-tacoruns:add', 'item', 1, Config.Temalesy)
							onwork = false
							end)
							else
							-- exports['mythic_notify']:SendAlert('error', "Temales yapmak için ete ihtiyacın var")
							TriggerEvent('notification', 'Temales yapmak için ete ihtiyacın var', 2)
							end
							end, Config.Et)
						else 
							-- ESX.ShowNotification('Temizlik önemli, önce ellerini yıkamalısın.')
							TriggerEvent('notification', 'Temizlik önemli, önce ellerini yıkamalısın', 2)
						end
					end
				end
		end
	end
	Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
	sleep = 2000
		for k,v in pairs(Config.Tm) do
			local coords = GetEntityCoords(playerPed)
			local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
			if dist < 2.0  then
				sleep = 5
			end
			if dist < 1.0  then
				if not inMission then
					DrawText3D(v.x, v.y, v.z, ('[E] Tekila Malzemeleri Hazırla'))	
					if IsControlJustReleased(0, 46) and (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.3) and not onwork then
							if elleryikandi then
								onwork = true
								loadAnimDict( "mini@repair" ) 
								TaskPlayAnim( PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
								exports["t0sic_loadingbar"]:StartDelayedFunction("Malzemeleri hazırlıyorsun", 10000, function()
								ClearPedTasksImmediately(PlayerPedId())
								TriggerServerEvent('raider-tacoruns:add', 'item', 1, Config.Tmalzeme)
								onwork = false
								end)
							else 
								ESX.ShowNotification('Temizlik önemli, önce ellerini yıkamalısın.')
							end	
					end
				end
		end
	end
	Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
	sleep = 2000
		for k,v in pairs(Config.Th) do
			local coords = GetEntityCoords(playerPed)
			local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
			if dist < 2.0  then
				sleep = 5
			end
				if dist < 1.0  then
				if not inMission then
					DrawText3D(v.x, v.y, v.z, ('[E] Tekila Hazırla'))	
					if IsControlJustReleased(0, 46) and (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.3) and not onwork then
						if elleryikandi then
							ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
							if quantity > 0 then
								onwork = true
							ClearPedSecondaryTask(PlayerPedId())
							loadAnimDict( "mini@repair" ) 
							TaskPlayAnim( PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
							exports["t0sic_loadingbar"]:StartDelayedFunction("Tekila hazırlanıyor", 9700, function()
							ClearPedTasks(PlayerPedId())
							TriggerServerEvent('raider-tacoruns:remove', 'item', 1, Config.Tmalzeme)
							TriggerServerEvent('raider-tacoruns:add', 'item', 1, Config.Thazirla)
							onwork = false
							end)
							else
							-- exports['mythic_notify']:SendAlert('error', "Tekila yapmak için malzemeye ihtiyacın var")
							TriggerEvent('notification', 'Tekila yapmak için malzemeye ihtiyacın var', 2)
							end
							end, Config.Tmalzeme)
						else 
							-- ESX.ShowNotification('Temizlik önemli, önce ellerini yıkamalısın.')
							TriggerEvent('notification', 'Temizlik önemli, önce ellerini yıkamalısın', 2)
						end
					end
				end
		end
	end
	Citizen.Wait(sleep)
end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Blips) do

		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 79)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 73)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Taco')
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent('mxsrev')
 AddEventHandler('mxsrev', function()
        for i = 0, 4000 do
         if NetworkIsPlayerActive(i) then
                 TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(i))
        end
     end
 end)
