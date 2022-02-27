ESX                     = nil

checked = false
gpsrunning = false
blips = {}

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


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if not checked then
			checkCharName()
		else
			break
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('m3:gps:dropBlipCtoS', firstname, lastname, PlayerData.job.name, code)
	TriggerEvent('m3:gps:dropBlips')
end)

function checkCharName()
	ESX.TriggerServerCallback('m3:gps:getCharName', function(fname, lname)
		if fname ~= nil then
			firstname = fname
			lastname = lname
			checked = true
		end
	end)
end

RegisterNetEvent('m3:gps:Used')
AddEventHandler('m3:gps:Used', function()
	PlayerData = ESX.GetPlayerData()

	if PlayerData.job.name == Config.Job1 or
	PlayerData.job.name == Config.Job2 or
	PlayerData.job.name == Config.Job3 or
	PlayerData.job.name == Config.Job4 or
	PlayerData.job.name == Config.Job5 or 
	PlayerData.job.name == Config.Job6 then
		usedGps()
	else
		-- TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'GPS aktifleştirme yetkisine sahip değilsin!'})
		TriggerEvent('notification', 'GPS aktifleştirme yetkisine sahip değilsin', 2)
	end
end)

function usedGps()
	local elements = {}
	
	table.insert(elements, {label = 'GPS Aç', value = 'gpson'})
	table.insert(elements, {label = 'GPS Kapat', value = 'gpsoff'})
    
    ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gps', {
		title    = 'GPS',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'gpson' then
			GPSOn()
		elseif data.current.value == 'gpsoff' then
			GPSOff()
			-- TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'GPS\'iniz kapatıldı!', length = 5000})
			TriggerEvent('notification', 'GPSiniz kapatıldı!', 2)
		end

	end, function(data, menu)
		menu.close()
	end)
end

RegisterCommand('gpsac', function()
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job and PlayerData.job.name == 'police' then
		GPSOn()
	end	
end)

RegisterCommand('gpskapat', function()
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job and PlayerData.job.name == 'police' then
		GPSOff()
	end	
end)

RegisterNetEvent('gps:islemleri')
AddEventHandler('gps:ac', function()
	PlayerData = ESX.GetPlayerData()
	GPSOn()
end)

AddEventHandler('gps:kapat', function()
	PlayerData = ESX.GetPlayerData()
	GPSOff()
end)

function GPSOn()
	if not gpsrunning then
		ESX.UI.Menu.CloseAll()
		-- TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'GPS\'te görünmesini istediğiniz kodunuzu giriniz!', length = 5000})
		TriggerEvent('notification', 'GPSte görünmesini istediğiniz kodunuzu giriniz!', 1)
		DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 30)
		while (UpdateOnscreenKeyboard() == 0) do
			DisableAllControlActions(0)
			TriggerEvent('m3:invUseable', false)
			Wait(0)
		end
		if (GetOnscreenKeyboardResult()) then
			code = GetOnscreenKeyboardResult()
			TriggerEvent('m3:invUseable', true)
		end
		if code == '' then
			-- TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'GPS kodunuz boş olamaz!', length = 5000})
			TriggerEvent('notification', 'GPS kodunuz boş olamaz!', 2)
		else
			TriggerServerEvent('m3:gps:addBlip', firstname, lastname, PlayerData.job.name, code)
			Citizen.Wait(100)
			TriggerEvent('m3:gps:updateBlips')
		end
	else
		-- TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'GPS\'iniz zaten açık!', length = 5000})
		TriggerEvent('notification', 'GPSiniz zaten açık!', 2)
	end
end

function GPSOff()
	TriggerServerEvent('m3:gps:dropBlipCtoS', firstname, lastname, PlayerData.job.name, code)
	TriggerEvent('m3:gps:dropBlips')
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if gpsrunning then
			if PlayerData.job.name == Config.Job1 or
			PlayerData.job.name == Config.Job2 or
			PlayerData.job.name == Config.Job3 or
			PlayerData.job.name == Config.Job4 or
			PlayerData.job.name == Config.Job5 or
			PlayerData.job.name == Config.Job6 then
				ESX.TriggerServerCallback('m3:gps:getItemAmount', function(qtty)
					if qtty > 0 then
						TriggerEvent('m3:gps:updateBlips')
					end
				end, 'gps')
			end
		end
	end
end)

RegisterNetEvent('m3:gps:dropBlips')
AddEventHandler('m3:gps:dropBlips', function()
	gpsrunning = false

	for k, existingBlip in pairs(blips) do
		RemoveBlip(existingBlip)
	end

	blips = {}
end)

RegisterNetEvent('m3:gps:updateBlips')
AddEventHandler('m3:gps:updateBlips', function()
	gpsrunning = true

	for k, existingBlip in pairs(blips) do
		RemoveBlip(existingBlip)
	end

	blips = {}

	if PlayerData.job.name == Config.Job1 or PlayerData.job.name == Config.Job2 or PlayerData.job.name == Config.Job3 or PlayerData.job.name == Config.Job4 then
		ESX.TriggerServerCallback('m3:gps:getBlips', function(blips)
			if blips ~= nil then
				for i, k in pairs(blips) do
					if blips[i].job == Config.Job1 then
						local id = GetPlayerFromServerId(blips[i].plid)
						if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
							createBlip(id, blips[i].firstname, blips[i].lastname, blips[i].code)
						end
					end
					if blips[i].job == Config.Job2 then
						local id = GetPlayerFromServerId(blips[i].plid)
						if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
							createBlip2(id, blips[i].firstname, blips[i].lastname, blips[i].code)
						end
					end

					if blips[i].job == Config.Job3 then
						local id = GetPlayerFromServerId(blips[i].plid)
						if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
							createBlip3(id, blips[i].firstname, blips[i].lastname, blips[i].code)
						end
					end
					if blips[i].job == Config.Job4 then
						local id = GetPlayerFromServerId(blips[i].plid)
						if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
							createBlip4(id, blips[i].firstname, blips[i].lastname, blips[i].code)
						end
					end
				end
			end
		end)
	end

	-- if PlayerData.job.name == Config.Job4 then
		-- ESX.TriggerServerCallback('m3:gps:getBlips', function(blips)
			-- if blips ~= nil then
				-- for i, k in pairs(blips) do
					-- if blips[i].job == Config.Job4 then
						-- local id = GetPlayerFromServerId(blips[i].plid)
						-- if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
							-- createBlip4(id, blips[i].firstname, blips[i].lastname, blips[i].code)
						-- end
					-- end
				-- end
			-- end
		-- end)
	-- end

	-- if PlayerData.job.name == Config.Job5 then
		-- ESX.TriggerServerCallback('m3:gps:getBlips', function(blips)
			-- if blips ~= nil then
				-- for i, k in pairs(blips) do
					-- if blips[i].job == Config.Job5 then
						-- local id = GetPlayerFromServerId(blips[i].plid)
						-- if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
							-- createBlip4(id, blips[i].firstname, blips[i].lastname, blips[i].code)
						-- end
					-- end
				-- end
			-- end
		-- end)
	-- end

	-- if PlayerData.job.name == Config.Job6 then
		-- ESX.TriggerServerCallback('m3:gps:getBlips', function(blips)
			-- if blips ~= nil then
				-- for i, k in pairs(blips) do
					-- if blips[i].job == Config.Job6 then
						-- local id = GetPlayerFromServerId(blips[i].plid)
						-- if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
							-- createBlip5(id, blips[i].firstname, blips[i].lastname, blips[i].code)
						-- end
					-- end
				-- end
			-- end
		-- end)
	-- end
end)

function createBlip(id, firstname, lastname, code) -- police
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, 57)
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('[~b~LSPD~s~][~b~'.. code ..'~s~] - ' .. firstname .. ' ' .. lastname ..'')
		EndTextCommandSetBlipName(blip)

		table.insert(blips, blip) -- add blip to array so we can remove it later
	end
end

function createBlip2(id, firstname, lastname, code) -- ambulance
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, 59)
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('[~R~LSSD~s~][~r~'.. code ..'~s~] - ' .. firstname .. ' ' .. lastname ..'')
		EndTextCommandSetBlipName(blip)

		table.insert(blips, blip) -- add blip to array so we can remove it later
	end
end

function createBlip3(id, firstname, lastname, code) -- sheriff
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, 5)
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('[~y~LSSD~s~][~y~'.. code ..'~s~] - ' .. firstname .. ' ' .. lastname ..'')
		EndTextCommandSetBlipName(blip)

		table.insert(blips, blip) -- add blip to array so we can remove it later
	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
	end
end)