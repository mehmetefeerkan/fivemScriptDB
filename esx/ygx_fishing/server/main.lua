ESX = nil

local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterUsableItem(Config.FishingItems["rod"]["name"], function(source)
	TriggerClientEvent("balik:antibug", source)
end)

ESX.RegisterServerCallback("james_fishing:receiveFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	player.removeInventoryItem(Config.FishingItems["bait"]["name"], 1)
	player.addInventoryItem(Config.FishingItems["fish"]["name"], 2)
	 baliktutuyor = false
	callback(true)
end)

ESX.RegisterServerCallback("james_fishing:sellFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	local fishItem = Config.FishingItems["fish"]

	local fishCount = player.getInventoryItem(fishItem["name"])["count"]
	local fishPrice = fishItem["price"]

	if fishCount > 0 then
		player.addMoney(fishCount * fishPrice)
		player.removeInventoryItem(fishItem["name"], fishCount)

		callback(fishCount * fishPrice, fishCount)
	else
		callback(false)
	end
	
	if opcja == 3 then
	local result = MySQL.Sync.fetchAll("SELECT * FROM characters WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier
    })

    if result[1].kazancSayaci < 25000 then
        MySQL.Async.execute("UPDATE characters SET kazancSayaci = @kazancSayaci WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier,
            ["kazancSayaci"] = result[1].kazancSayaci + GotowkaSprzedaz
        })
        if ZapakowanyKurczak > 0 then
            xPlayer.removeInventoryItem('fish', 1)
            xPlayer.addMoney(GotowkaSprzedaz)
            TriggerClientEvent('esx:showNotification', _source, '~g~ kazancın ~y~'..GotowkaSprzedaz.. '$ ~g~ 2 Balık için.')
            Wait(1500)
        end
    else
        TriggerClientEvent('esx:showNotification', _source, 'Günlük limite ulaştın.')
	end
end

end)