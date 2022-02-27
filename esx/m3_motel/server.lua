local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- local pinkcage = {
--     [1] = {locked = true},
--     [2] = {locked = true},
--     [3] = {locked = true},
--     [4] = {locked = true},
--     [5] = {locked = true},
--     [6] = {locked = true},
--     [7] = {locked = true},
--     [8] = {locked = true},
--     [9] = {locked = true},
--     [10]= {locked = true},
--     [11]= {locked = true},
--     [12]= {locked = true},
--     [13]= {locked = true},
--     [14]= {locked = true},
-- }

-- RegisterNetEvent('m3:motel:server:getLockStates')
-- AddEventHandler('m3:motel:server:getLockStates', function()
--     local src = source
--     TriggerClientEvent('m3:motel:client:sendDoorlockState', src, pinkcage)
-- end)

-- RegisterNetEvent('m3:motel:server:toggleDoorlock')
-- AddEventHandler('m3:motel:server:toggleDoorlock', function(doorid, lockstate)
--     local src = source
--     local xPlayer = ESX.GetPlayerFromId(src)
    
--     pinkcage[doorid].locked = lockstate
--     TriggerClientEvent('m3:motel:client:sendDoorlockState2', -1, doorid, lockstate)
-- end)

ESX.RegisterServerCallback('m3:motel:server:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('m3:motel:server:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('m3:motel:server:removeOutfit')
AddEventHandler('m3:motel:server:removeOutfit', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        local dressing = store.get('dressing')
        if dressing == nil then
            dressing = {}
        end
        label = label
        table.remove(dressing, label)
        store.set('dressing', dressing)
    end)
end)