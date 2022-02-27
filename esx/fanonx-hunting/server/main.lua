ESX = nil
local baitUsable = true
local baitTime = Config.TimeBetween
local isEntityInWater = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.EnableBait then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            if not baitUsable then
                if baitTime == 0 then
                    baitUsable = true
                    baitTime = Config.TimeBetween
                else
                    baitTime = baitTime - 1
                end
            end
        end
    end)

    ESX.RegisterUsableItem(Config.BaitItemName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('fanonx:client:canPlaceBait', source)
        Citizen.Wait(300)
        if not isEntityInWater then
            if baitUsable then
                xPlayer.removeInventoryItem(Config.BaitItemName, 1)
                TriggerClientEvent('fanonx:client:bait', source)
                baitUsable = false
            else
                TriggerClientEvent('okokNotify:Alert', source, "", Config.Text['between_bait'], 3000, 'error')
            end
        else
            TriggerClientEvent('okokNotify:Alert', source, "", Config.Text['cant_place_bait'], 3000, 'error')
        end
        
    end)
end

RegisterServerEvent('fanonx-hunting:server:canPlaceBaitS')
AddEventHandler('fanonx-hunting:server:canPlaceBaitS', function(water)
    isEntityInWater = water
end)


RegisterServerEvent('fanonx-hunting:server:giveReward')
AddEventHandler('fanonx-hunting:server:giveReward', function(itemName, count)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local rdm = math.random(0,math.random(0,1))
	if xPlayer.getInventoryItem('vacutainer').count >= 1 and rdm == 1 then
        xPlayer.addInventoryItem(itemName, count)
    else
        TriggerClientEvent('okokNotify:Alert', _source, "", "It seems you don't have a vacutainer, You wasted deer blood", 3000, 'error')
    end
end)

RegisterServerEvent('fanonx-hunting:server:sell')
AddEventHandler('fanonx-hunting:server:sell', function(itemName, price, count, blackMoney)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local itemN = nil
	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == itemName then
			itemN = item.count
		end
	end
    if itemN >= count then
        xPlayer.removeInventoryItem(itemName, count)
        if blackMoney then
            xPlayer.addAccountMoney('black_money', price*count)
        else
            xPlayer.addMoney(price*count)
        end
        TriggerClientEvent('okokNotify:Alert', source, "", "Succesfully sold", 3000, 'info')
    else
        TriggerClientEvent('okokNotify:Alert', source, "", Config.Text['no_material'], 3000, 'info')
    end
end)

RegisterServerEvent('fanonx-hunting:server:giveMoney')
AddEventHandler('fanonx-hunting:server:giveMoney', function(count, blackMoney)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('okokNotify:Alert', source, "", Config.Text['sold'], 3000, 'info')
end)

ESX.RegisterServerCallback('fanonx-hunting:server:cook',function(source, cb, meatName, count)
    local xPlayer = ESX.GetPlayerFromId(source)
	local itemN = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == meatName then
			itemN = item.count
		end
	end

    if itemN >= count then
        xPlayer.removeInventoryItem(meatName, count)
        cb(true)
    else
        TriggerClientEvent('okokNotify:Alert', source, "", Config.Text['no_material'], 3000, 'info')
        cb(false)
    end
end)

ESX.RegisterServerCallback('fanonx-hunting:server:campfire',function(source, cb, coalName, woodName, coalCount, woodCount)
    local xPlayer = ESX.GetPlayerFromId(source)
	local coalN = 0
    local woodN = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == coalName then
			coalN = item.count
        elseif item.name == woodName then
            woodN = item.count
        end
	end
    
    if coalN >= coalCount and woodN >= woodCount then
        xPlayer.removeInventoryItem(coalName, coalCount)
        xPlayer.removeInventoryItem(woodName, woodCount)
        cb(true)
    else 
        TriggerClientEvent('okokNotify:Alert', source, "", Config.Text['no_material'], 3000, 'info')
        cb(false)
    end
end)

ESX.RegisterServerCallback('fanonx-hunting:server:giveLicense', function(source, id)
	--local xPlayer = ESX.GetPlayerFromId(source)

    local xPlayer = ESX.GetPlayerFromId(id)

	if xPlayer then
		TriggerEvent('esx_license:addLicense', source, 'hunt', function()
            TriggerClientEvent('okokNotify:Alert', source, "", "Success", 3000, 'success')
        end)
	else
        TriggerClientEvent('okokNotify:Alert', source, "", "No player nearby", 3000, 'error')
	end
end)

RegisterServerEvent('fanonx-hunting:server:leatherInInventory')
AddEventHandler('fanonx-hunting:server:leatherInInventory', function(illegalMarket)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]
        for i, animal in pairs(Config.Animals) do
            if not animal.isIllegal and item.count > 0 and not illegalMarket then
                if item.name == animal.bad then
                    TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = animal.badCost}, false)
                elseif item.name == animal.good then
                    TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = animal.goodCost}, false)
                elseif item.name == animal.perfect then
                    TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = animal.perfectCost}, false)
                elseif item.name == animal.specialItem then
                    TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = animal.specialItemCost}, false)
                end
            elseif animal.isIllegal and item.count > 0 and illegalMarket then
                if item.name == animal.bad then
                    TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = animal.illegalBadCost}, true)
                elseif item.name == animal.good then
                    TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = animal.illegalGoodCost}, true)
                elseif item.name == animal.perfect then
                    TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = animal.illegalPerfectCost}, true)
                elseif item.name == animal.specialItem then
                    TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = animal.specialItemCost}, true)
                end
            end 
        end
        if item.name == Config.MeatName and item.count > 0 then
            TriggerClientEvent('fanonx:client:addElement', source, {label = item.label, item = item.name, type = 'slider', min = 1, max = item.count, value = 1, price = Config.MeatCost}, false)
        end
	end
end)
