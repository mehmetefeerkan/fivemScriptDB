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
local PlayerData              = {}
local training = false
local resting = false
local membership = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
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

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local blips = {
	{title="Gym", colour=7, id=311, x = -1201.2257, y = -1568.8670, z = 4.6101}
}
	
Citizen.CreateThread(function()

	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.7)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

RegisterNetEvent('esx_gym:useBandage')
AddEventHandler('esx_gym:useBandage', function()
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)
	local health = GetEntityHealth(playerPed)
	local newHealth = math.min(maxHealth , math.floor(health + maxHealth/3))

	SetEntityHealth(playerPed, newHealth)
	--SetEntityHealth(playerPed, maxHealth) -- Give them full health by one bandage
	
	ESX.ShowNotification("Bandaj ~g~Kullandın.")
end)

RegisterNetEvent('esx_gym:trueMembership')
AddEventHandler('esx_gym:trueMembership', function()
	membership = true
end)

RegisterNetEvent('esx_gym:falseMembership')
AddEventHandler('esx_gym:falseMembership', function()
	membership = false
end)

-- LOCATION (START)

local arms = {
    {x = 484.66,y = -984.09,z = 25.73}
}

local pushup = {
    {x = 480.09,y = -990.23,z = 25.73}
}

local yoga = {
    {x = 484.99,y = -986.73,z = 25.74}
}

local situps = {
    {x = 484.17,y = -988.39,z = 25.73}
}

local gym = {
    {x = -1195.6551,y = -1577.7689,z = 4.6115}
}

local chins = {
    {x = 481.79,y = -988.17,z = 25.73}
}




Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local sleep = 2000       
		for k in pairs(arms) do
			if GetDistanceBetweenCoords(GetEntityCoords(ped), arms[k].x, arms[k].y, arms[k].z, true) < 5 then
				sleep = 5
			end
			if GetDistanceBetweenCoords(GetEntityCoords(ped), arms[k].x, arms[k].y, arms[k].z, true) < 2 then
            DrawMarker(21, arms[k].x, arms[k].y, arms[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
		    end
		end
		Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
        local sleep = 2000
		for k in pairs(pushup) do
			if GetDistanceBetweenCoords(GetEntityCoords(ped), pushup[k].x, pushup[k].y, pushup[k].z, true) < 5 then
				sleep = 5
			end
			if GetDistanceBetweenCoords(GetEntityCoords(ped), pushup[k].x, pushup[k].y, pushup[k].z, true) < 2 then
			DrawMarker(21, pushup[k].x, pushup[k].y, pushup[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
			end
		end
		Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
        local sleep = 2000
		for k in pairs(yoga) do
			if GetDistanceBetweenCoords(GetEntityCoords(ped), yoga[k].x, yoga[k].y, yoga[k].z, true) < 5 then
				sleep = 5
			end
			if GetDistanceBetweenCoords(GetEntityCoords(ped), yoga[k].x, yoga[k].y, yoga[k].z, true) < 2 then
			DrawMarker(21, yoga[k].x, yoga[k].y, yoga[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
			end
		end
		Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
        local sleep = 2000
		for k in pairs(situps) do
			if GetDistanceBetweenCoords(GetEntityCoords(ped), situps[k].x, situps[k].y, situps[k].z, true) < 5 then
				sleep = 5
			end
			if GetDistanceBetweenCoords(GetEntityCoords(ped), situps[k].x, situps[k].y, situps[k].z, true) < 2 then
			DrawMarker(21, situps[k].x, situps[k].y, situps[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
		    end
		end
		Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
        local sleep = 2000
		for k in pairs(chins) do
			if GetDistanceBetweenCoords(GetEntityCoords(ped), chins[k].x, chins[k].y, chins[k].z, true) < 2 then
				sleep = 5
			end
			if GetDistanceBetweenCoords(GetEntityCoords(ped), chins[k].x, chins[k].y, chins[k].z, true) < 2 then
			DrawMarker(21, chins[k].x, chins[k].y, chins[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
			end
		end
		Citizen.Wait(sleep)
    end
end)


Citizen.CreateThread(function()
	while true do
		local sleep = 2000

        for k in pairs(gym) do
		
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)
			if dist <= 3.0 then
				sleep = 5
			end

            if dist <= 0.5 then
				DrawText3D(-1195.07, -1577.53, 5.6035, " ~g~[E] ~w~ Cenk Hoca")
				if IsControlJustPressed(0, Keys['E']) then
					OpenGymMenu()
				end			
            end
		end
		Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000

        for k in pairs(arms) do

            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, arms[k].x, arms[k].y, arms[k].z)
			if dist <= 3.0 then
				sleep = 5
			end
            if dist <= 0.5 then
				hintToDisplay('Kol Egzersizi yapmak için ~INPUT_CONTEXT~ tuşuna  ~g~basınız')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz Hazırlanıyor...', 3000)
						TriggerEvent('notification', 'Egzersiz Hazırlanıyor...', 1)
						Citizen.Wait(1000)					
					
						if membership == true then
							local playerPed = PlayerPedId()
							local freeze = PlayerPedId()
							FreezeEntityPosition(freeze, true)
							training = true
							-- exports["gamz-skillsystem"]:UpdateSkill("Güç", 0.1)
							TaskStartScenarioInPlace(playerPed, "world_human_muscle_free_weights", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							-- exports['mythic_notify']:SendAlert('inform', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 3000)
							TriggerEvent('notification', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 2)
							FreezeEntityPosition(freeze, false)
							
							training = true
						elseif membership == false then
							-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 3000)
							TriggerEvent('notification', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 2)
						end
					elseif training == true then
						-- exports['mythic_notify']:SendAlert('inform', 'Dinlenmen Gerek...', 3000)
						TriggerEvent('notification', 'Dinlenmen Gerek...', 2)
						
						resting = true
						
						CheckTraining()
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

        for k in pairs(chins) do

            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chins[k].x, chins[k].y, chins[k].z)
			if dist <= 3.0 then
				sleep = 5
			end
            if dist <= 0.5 then
				hintToDisplay('Barfiks çekmek için ~INPUT_CONTEXT~ tuşuna basınız.')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz Hazırlanıyor...', 3000)
						TriggerEvent('notification', 'Egzersiz Hazırlanıyor...', 1)
						Citizen.Wait(1000)					
					
						if membership == true then
							local playerPed = PlayerPedId()
							-- exports["gamz-skillsystem"]:UpdateSkill("Güç", 0.1)
							local freeze = PlayerPedId()
							FreezeEntityPosition(freeze, true)
							training = true
							TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							-- exports['mythic_notify']:SendAlert('error', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 3000)
							TriggerEvent('notification', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 2)
							FreezeEntityPosition(freeze, false)
							
							
							training = true
						elseif membership == false then
							-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 3000)
							TriggerEvent('notification', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 2)
						end
					elseif training == true then
						-- exports['mythic_notify']:SendAlert('inform', 'Dinlenmen Gerek...', 3000)
						TriggerEvent('notification', 'Dinlenmen Gerek...', 2)
						
						resting = true
						
						CheckTraining()
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

        for k in pairs(pushup) do

            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pushup[k].x, pushup[k].y, pushup[k].z)
			if dist <= 3.0 then
				sleep = 5
			end
            if dist <= 0.5 then
				hintToDisplay('Şınav Çekmek için ~INPUT_CONTEXT~ tuşuna basınız.')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz Hazırlanıyor...', 3000)
						TriggerEvent('notification', 'Egzersiz Hazırlanıyor...', 1)
						Citizen.Wait(1000)					
					
						if membership == true then				
							local playerPed = PlayerPedId()
							-- exports["gamz-skillsystem"]:UpdateSkill("Güç", 0.1)
							local freeze = PlayerPedId()
							FreezeEntityPosition(freeze, true)
							training = true
							TaskStartScenarioInPlace(playerPed, "world_human_push_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							-- exports['mythic_notify']:SendAlert('error', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 3000)
							TriggerEvent('notification', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 2)
							FreezeEntityPosition(freeze, false)
							--TriggerServerEvent('esx_gym:trainPushups') ## COMING SOON...
							
							training = true
						elseif membership == false then
							-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 3000)
							TriggerEvent('notification', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 2)
						end							
					elseif training == true then
						-- exports['mythic_notify']:SendAlert('inform', 'Dinlenmen Gerek...', 3000)
						TriggerEvent('notification', 'Dinlenmen Gerek...', 2)
						
						resting = true
						
						CheckTraining()
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

        for k in pairs(yoga) do

            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, yoga[k].x, yoga[k].y, yoga[k].z)
			if dist <= 3.0 then
				sleep = 5
			end
            if dist <= 0.5 then
				hintToDisplay('Yoga yapmak için ~INPUT_CONTEXT~ tuşuna basınız')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz Hazırlanıyor...', 3000)
						TriggerEvent('notification', 'Egzersiz Hazırlanıyor...', 1)
						Citizen.Wait(1000)					
					
						if membership == true then	
							local playerPed = PlayerPedId()
							-- exports["gamz-skillsystem"]:UpdateSkill("Kondisyon", 0.1)
							local freeze = PlayerPedId()
							FreezeEntityPosition(freeze, true)
							training = true
							TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							-- exports['mythic_notify']:SendAlert('error', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 3000)
							TriggerEvent('notification', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 2)
							FreezeEntityPosition(freeze, false)
							--TriggerServerEvent('esx_gym:trainYoga') ## COMING SOON...
							
							training = true
						elseif membership == false then
							-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 3000)
							TriggerEvent('notification', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 2)
						end
					elseif training == true then
						-- exports['mythic_notify']:SendAlert('inform', 'Dinlenmen Gerek...', 3000)
						TriggerEvent('notification', 'Dinlenmen Gerek...', 2)
						
						resting = true
						
						CheckTraining()
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

        for k in pairs(situps) do

            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, situps[k].x, situps[k].y, situps[k].z)
			if dist <= 3.0 then
				sleep = 5
			end
            if dist <= 0.5 then
				hintToDisplay('Şınav çekmek için ~INPUT_CONTEXT~ basınız')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then

						TriggerServerEvent('esx_gym:checkChip')
						-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz Hazırlanıyor...', 3000)
						TriggerEvent('notification', 'Egzersiz Hazırlanıyor...', 1)
						Citizen.Wait(1000)			
					
						if membership == true then	
							local playerPed = PlayerPedId()
							-- exports["gamz-skillsystem"]:UpdateSkill("Güç", 0.1)
							local freeze = PlayerPedId()
							FreezeEntityPosition(freeze, true)
							training = true
							TaskStartScenarioInPlace(playerPed, "world_human_sit_ups", 0, true)
							
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							-- exports['mythic_notify']:SendAlert('error', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 3000)
							TriggerEvent('notification', 'Başka egzersiz yapmak için 1 dakika beklemelisin', 2)
							FreezeEntityPosition(freeze, false)
						elseif membership == false then
							-- exports['mythic_notify']:SendAlert('inform', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 3000)
							TriggerEvent('notification', 'Egzersiz yapmak icin üyelige ihtiyacınız var', 2)
						end
					elseif training == true then
						-- exports['mythic_notify']:SendAlert('inform', 'Dinlenmen Gerek...', 3000)
						TriggerEvent('notification', 'Dinlenmen Gerek...', 2)
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
		end
		Citizen.Wait(sleep)
    end
end)

function CheckTraining()
	if resting == true then
		-- exports['mythic_notify']:SendAlert('error', 'Dinleniyorsun...', 5000)
		TriggerEvent('notification', 'Dinleniyorsun...', 2)
		
		resting = false
		Citizen.Wait(30000)
		training = false
	end
	
	if resting == false then
		-- exports['mythic_notify']:SendAlert('inform', 'Suan egzersiz yapabilirsin...', 5000)
		TriggerEvent('notification', 'Şuanda egzersiz yapabilirsin', 1)
	end
end

function OpenGymMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_menu',
        {
            title    = 'Spor Konusunda Asla Yalan Söylemem',
            elements = {
				{label = 'Market', value = 'shop'},
				--{label = 'Acilis Saatleri', value = 'hours'},
				{label = 'Üyelik', value = 'ship'},
				-- {label = 'Bilgileriniz', value = 'skils'},
            }
        },
        function(data, menu)
            if data.current.value == 'shop' then
				OpenGymShopMenu()
            elseif data.current.value == 'ship' then
				OpenGymShipMenu()
			-- elseif data.current.value == 'skils' then
			-- 	exports["gamz-skillsystem"]:SkillMenu()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymShopMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
            title    = 'Gym - Market',
            elements = {
				-- {label = 'Protein Karısmı ($6)', value = 'protein_shake'},
				{label = 'Su ($1)', value = 'water'},
				-- {label = 'Powerade ($4)', value = 'powerade'}
            }
        },
        function(data, menu)
            if data.current.value == 'protein_shake' then
				TriggerServerEvent('esx_gym:buyProteinshake')
            elseif data.current.value == 'water' then
				TriggerServerEvent('esx_gym:buyWater')
            elseif data.current.value == 'sportlunch' then
				TriggerServerEvent('esx_gym:buySportlunch')
            elseif data.current.value == 'powerade' then
				TriggerServerEvent('esx_gym:buyPowerade')
            elseif data.current.value == 'bandage' then
				TriggerServerEvent('esx_gym:buyBandage')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymShipMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_ship_menu',
        {
            title    = 'Gym - Üyelik',
            elements = {
				{label = 'Üyelik ($100)', value = 'membership'},
            }
        },
        function(data, menu)
            if data.current.value == 'membership' then
				TriggerServerEvent('esx_gym:buyMembership')
				
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

local firstspawn = false

Citizen.CreateThread(function()
    local hash = GetHashKey("u_m_y_babyd")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if firstspawn == false then
        local npc = CreatePed(6, hash, -1195.07, -1577.53, 3.6035, 129.0, false, false)
        SetEntityInvincible(npc, true)
		FreezeEntityPosition(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityDynamic(npc, true)
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
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 0, 0, 0, 100)
end