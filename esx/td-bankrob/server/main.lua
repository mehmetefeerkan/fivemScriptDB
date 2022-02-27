

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('td-bankrob:copCount', function(source, cb)
	local xPlayers = ESX.GetPlayers()

	copConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			copConnected = copConnected + 1
		end
	end

	cb(copConnected)
end)

ESX.RegisterServerCallback("td-bankrob:itemcount", function(source, cb, itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getQuantity(itemname)

    if item >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('td-bankrob:policenotif')
AddEventHandler('td-bankrob:policenotif', function()
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('td-bankrob:setblip',xPlayer.source)
		end
	end
end)



ESX.RegisterUsableItem('bankakarti', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('td-bankrob:togglevaultdoor', source)
end)

RegisterNetEvent('td-bankrob:givecash')
AddEventHandler('td-bankrob:givecash', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local cash = math.random(1500,2500)
	local amount = math.random(5,15)
	if math.random(1, 20) == 1 then 
		xPlayer.addInventoryItem(Config.Item,amount)
	   end
	xPlayer.addMoney(cash)
end)


RegisterServerEvent('td-bankrob:removethermite')
AddEventHandler('td-bankrob:removethermite', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('thermite',1)
end)


