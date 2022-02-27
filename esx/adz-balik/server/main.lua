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

	player.removeInventoryItem(Config.FishingItems["bait"]["name"], 1)
	
local sans = math.random(0, 117);
if sans > 0 and sans < 50 then
  player.addInventoryItem(Config.FishingItems["fish"]["name"], math.random(1, 3))
elseif sans > 50 and sans < 60 then
    player.addInventoryItem("fish", math.random(1, 3))
elseif sans > 60 and sans < 75 then
    player.addInventoryItem("fish", math.random(1, 1))
elseif sans > 75 and sans < 80 then
    player.addInventoryItem("fish", math.random(1, 1))
elseif sans > 80 and sans < 85 then
    player.addInventoryItem("fish", math.random(1, 5))
elseif sans > 85 and sans < 95 then
    player.addInventoryItem("fish", math.random(1, 3))
elseif sans > 95 and sans < 98 then
    player.addInventoryItem("fish", math.random(1, 1))
elseif sans > 98 and sans < 101 then
    player.addInventoryItem("fish", math.random(1, 6))
elseif sans > 101 and sans < 103 then
    player.addInventoryItem("fish", math.random(1, 1))
elseif sans > 103 and sans < 107 then
    player.addInventoryItem("fish", math.random(1, 1))
elseif sans > 107 and sans < 108 then
    player.addInventoryItem("fish", math.random(1, 1))
elseif sans > 108 and sans < 112 then
    player.addInventoryItem("fish", math.random(1, 1))
elseif sans > 112 and sans < 117 then
    player.addInventoryItem("fish", math.random(1, 1))
end

	
	callback(true)
end)

ESX.RegisterServerCallback("james_fishing:sellFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	local fishItem = Config.FishingItems["fish"]

	local fishCount = player.getQuantity(fishItem["name"])["count"]
	local fishPrice = fishItem["price"]

	if fishCount > 0 then
		player.addMoney(fishCount * fishPrice)
		player.removeInventoryItem(fishItem["name"], fishCount)

		callback(fishCount * fishPrice, fishCount)
	else
		callback(false)
	end
end)