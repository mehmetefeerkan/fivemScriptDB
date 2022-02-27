ESX = nil

local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterUsableItem(Config.FishingItems["rod"]["name"], function(source)
	TriggerClientEvent("james_fishing:tryToFish", source)
end)

ESX.RegisterServerCallback("james_fishing:receiveFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	if player.getQuantity(Config.FishingItems["bait"]["name"]) >= 1 then
		player.removeInventoryItem(Config.FishingItems["bait"]["name"], 1)
		
		local sans = math.random(0, 100);
		if sans > 0 and sans < 50 then
		  player.addInventoryItem(Config.FishingItems["fish"]["name"], math.random(1, 2))
		elseif sans > 50 and sans < 85 then
		    player.addInventoryItem(Config.FishingItems["fish"]["name"], math.random(2, 3))
		elseif sans > 85 and sans < 95 then
		    player.addInventoryItem(Config.FishingItems["fish"]["name"], math.random(4, 5))
		elseif sans > 95 and sans < 100 then
			player.addInventoryItem(Config.FishingItems["turtle"]["name"], math.random(1, 2))
		end

		callback(true)
	else
		callback(false)
	end
end)

ESX.RegisterServerCallback("james_fishing:sellFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	local fishItem = Config.FishingItems["fish"]

	local fishCount = player.getQuantity(fishItem["name"])
	local fishPrice = fishItem["price"]

	if fishCount > 0 then
		player.addMoney(fishCount * fishPrice)
		player.removeInventoryItem(fishItem["name"], fishCount)

		callback(fishCount * fishPrice, fishCount)
	else
		callback(false)
	end
end)