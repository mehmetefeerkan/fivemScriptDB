ESX, gps, blips = nil, false, {}
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

RegisterNetEvent('m3:gps:client:Used')
AddEventHandler('m3:gps:client:Used', function()
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
			if not gps then
                ESX.UI.Menu.CloseAll()
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'GPS\'te görünmesini istediğiniz kodunuzu giriniz!', length = 5000})
                local code = keyboardInput('GPS Kodu:', '', 5)
                    
                if code == '' or code == nil then
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'GPS kodunuz boş olamaz!', length = 5000})
                else
                    gps = true
                    TriggerServerEvent('m3:gps:server:openGPS', code)
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'GPS\'iniz açıldı!', length = 5000})
                end
            else
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'GPS\'iniz zaten açık!', length = 5000})
            end
        elseif data.current.value == 'gpsoff' then
            if gps then
                gps = false
                TriggerServerEvent('m3:gps:server:closeGPS')
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'GPS\'iniz kapatıldı!', length = 5000})
            else
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'GPS\'iniz zaten kapalı!', length = 5000})
            end
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('m3:gps:client:closed')
AddEventHandler('m3:gps:client:closed', function()
    gps = false
end)

function keyboardInput(arg1, arg2, arg3) 
    AddTextEntry('FMMC_KEY_TIP1', arg1) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", arg2, "", "", "", arg3) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        TriggerEvent('m3:inventoryhud:client:invUseable', false)
        Citizen.Wait(0) 
    end 
    if UpdateOnscreenKeyboard() ~= 2 then 
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        TriggerEvent('m3:inventoryhud:client:invUseable', true)
        return result 
    else 
        Citizen.Wait(500)
        TriggerEvent('m3:inventoryhud:client:invUseable', true)
        return nil 
    end 
end

RegisterNetEvent('m3:gps:client:getPlayerInfo')
AddEventHandler('m3:gps:client:getPlayerInfo', function(table)
    --if GetPlayerServerId(PlayerId()) ~= table.src then
        if DoesBlipExist(blips[table.src]) then
            RemoveBlip(blips[table.src])
        end
        --blips[table.src] = AddBlipForCoord(table.coord.x, table.coord.y, table.coord.z)
        --SetBlipSprite(blips[table.src], 1)
        if table.job == 'police' then
            createBlipLSPD(table)
        elseif table.job == 'ambulance' then
            createBlipLSMS(table)
        elseif table.job == 'sheriff' then
            createBlipLSSD(table)
        end
        --SetBlipScale(blips[table.src], 0.85)
        --SetBlipAsShortRange(blips[table.src], true)
        --BeginTextCommandSetBlipName('STRING')
        --AddTextComponentString(table.text)
        --EndTextCommandSetBlipName(blips[table.src])
   -- end
end)

function createBlipLSPD(table)
	blips[table.src] = AddBlipForCoord(table.coord.x, table.coord.y, table.coord.z)
    SetBlipSprite(blips[table.src], 1)
	SetBlipColour(blips[table.src], 57)
	SetBlipScale(blips[table.src], 0.85)
	SetBlipDisplay(blips[table.src], 4)
    SetBlipAsShortRange(blips[table.src], true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('[~R~LSPD~s~]' .. table.text)
    EndTextCommandSetBlipName(blips[table.src])
end

function createBlipLSMS(table)
	blips[table.src] = AddBlipForCoord(table.coord.x, table.coord.y, table.coord.z)
    SetBlipSprite(blips[table.src], 1)
	SetBlipColour(blips[table.src], 49)
	SetBlipScale(blips[table.src], 0.85)
	SetBlipDisplay(blips[table.src], 4)
    SetBlipAsShortRange(blips[table.src], true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('[~R~LSMS~s~]' .. table.text)
    EndTextCommandSetBlipName(blips[table.src])
end

function createBlipLSSD(table)
	blips[table.src] = AddBlipForCoord(table.coord.x, table.coord.y, table.coord.z)
    SetBlipSprite(blips[table.src], 1)
	SetBlipColour(blips[table.src], 60)
	SetBlipScale(blips[table.src], 0.85)
	SetBlipDisplay(blips[table.src], 4)
    SetBlipAsShortRange(blips[table.src], true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('[~R~LSSD~s~]' .. table.text)
    EndTextCommandSetBlipName(blips[table.src])
end

RegisterNetEvent('m3:gps:client:removeBlip')
AddEventHandler('m3:gps:client:removeBlip', function(src)
    local blip = blips[src]
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
        blips[src] = nil
    end
end)