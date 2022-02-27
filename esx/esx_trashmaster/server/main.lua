local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent("esx-ecobottles:retrieve")
AddEventHandler("esx-ecobottles:retrieve", function()
    local player = ESX.GetPlayerFromId(source)

    math.randomseed(os.time())
    local luck = math.random(1, 75)
	local random = math.random(1,1)
	local rastgele = math.random(1, 3)

    
	if luck >= 1 and luck <= 5 then
		player.addInventoryItem("weed", random)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..random..' işlenmemiş esrar buldun')
	elseif luck >= 6 and luck <= 10 then
		player.addInventoryItem("bandage", random)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..random..' bandaj buldun')
	elseif luck >= 11 and luck <= 17 then
		player.addInventoryItem("acetone", random)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..random..' aseton buldun')
	elseif luck >= 18 and luck <= 24 then
		player.addInventoryItem("lithium", random)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..random..' lityum batarya buldun')
	elseif luck >= 25 and luck <= 32 then
        player.addInventoryItem("advancedlockpick", random)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..random..' kaliteli maymuncuk buldun')
	elseif luck >= 33 and luck <= 40 then
		player.addInventoryItem("opium", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' haşhaş buldun')
	elseif luck >= 41 and luck <= 48 then
		player.addInventoryItem("syringe", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' şırınga buldun')
	elseif luck >= 49 and luck <= 56 then
		player.addInventoryItem("sodium", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' sodyum buldun')
	elseif luck >= 57 and luck <= 62 then
		player.addInventoryItem("mt-aluminum", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' aluminyum parçaları buldun')
	elseif luck >= 63 and luck <= 68 then
		player.addInventoryItem("mt-churro", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' tahta parçaları buldun')
	elseif luck >= 69 and luck <= 74 then
		player.addInventoryItem("mt-copper", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' bakır parçaları buldun')
	elseif luck >= 75 and luck <= 80 then
		player.addInventoryItem("mt-glass", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' cam parçaları buldun')
	elseif luck >= 81 and luck <= 86 then
		player.addInventoryItem("mt-plastic", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' plastik parçaları buldun')
	elseif luck >= 87 and luck <= 92 then
		player.addInventoryItem("mt-steel", rastgele)
		TriggerClientEvent('esx:showNotification', source, 'Çöpten '..rastgele..' çelik parçaları buldun')	
	elseif luck >= 93 and luck <= 110 then
	TriggerClientEvent('esx:showNotification', source, 'Bu çöp boş, bir şey bulamadın!')	
	end
end)
