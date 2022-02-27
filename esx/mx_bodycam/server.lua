ESX = nil
-- local bodycam = nil 
local bodycam = {}
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('sove:item', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtty = xPlayer.getInventoryItem(item).count
    cb(qtty)
end)

function getIdentity(source)

    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = source
    })
    if result[1] ~= nil then
        local identity = result[1]

        return {
            identifier = identity['identifier'],
            firstname = identity['firstname'],
            lastname = identity['lastname'],
            dateofbirth = identity['dateofbirth'],
            sex = identity['sex'],
            height = identity['height']

        }
    else
        return nil
    end
end


RegisterServerEvent('mx_bodycam:getPlayerData')
AddEventHandler('mx_bodycam:getPlayerData', function()

	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 255 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.getInventoryItem('bodycam').count >= 1 then
			local name = getIdentity(xPlayer.identifier)
			TriggerClientEvent('mx_bodycam:show', xPlayers[i], 'ADIN: ' .. name.firstname .. ' ' .. name.lastname,
				'' .. 'RUTBEN: ' .. xPlayer.job.grade_label)
		else
			TriggerClientEvent('mx_bodycam:close', xPlayers[i])
		end
	end
end)


AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if item.name == 'bodycam' and item.count <= 0 then
        TriggerClientEvent('mx_bodycam:close', source)
    end
end)

ESX.RegisterUsableItem('bodycam', function(source)
    local xPlayers = ESX.GetPlayers()

    -- local bodycam = nil

    for i = 1, #xPlayers, 255 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local name = getIdentity(xPlayer.identifier)
        TriggerClientEvent('mx_bodycam:bodycam', source, xPlayers[i],
            'ADIN: ' .. name.firstname .. ' ' .. name.lastname, '' .. 'RUTBEN: ' .. xPlayer.job.grade_label)
        TriggerClientEvent('mx_bodycam:close', source)
    end
    -- if bodycam ~= 1 then
    -- 	TriggerClientEvent('mx_bodycam:close', source)
    -- end

end)
