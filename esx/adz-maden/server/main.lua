ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('araf-blacksmith:getItemCount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getQuantity(item)

    if cb ~= nil then
        cb(itemCount)
    end
end)

RegisterServerEvent('araf-blacksmith:giveHeatedItem')
AddEventHandler('araf-blacksmith:giveHeatedItem', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local ironCount = xPlayer.getQuantity(araf.iron)

    if ironCount >= araf.requiredItemCount then
        xPlayer.removeInventoryItem(araf.iron, araf.requiredItemCount)

        if xPlayer.canCarryItem(araf.heatedIron, araf.giveItemCount) then
            xPlayer.addInventoryItem(araf.heatedIron, araf.giveItemCount)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('cant_carry'), style = { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' } })
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('no_item', araf.iron), style = { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' } })
    end
end)

RegisterServerEvent('araf-blacksmith:giveWroughtedItem')
AddEventHandler('araf-blacksmith:giveWroughtedItem', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local ironCount = xPlayer.getQuantity(araf.heatedIron)

    if ironCount >= araf.requiredItemCount then
        xPlayer.removeInventoryItem(araf.heatedIron, araf.requiredItemCount)

        local chance = math.random(1, 100)
        if chance <= 96 then
            local randomPull = math.random(1, #araf.lowChanceItems)
            local item = araf.lowChanceItems[randomPull]

            if xPlayer.canCarryItem(item, araf.giveItemCount) then
                xPlayer.addInventoryItem(item, araf.giveItemCount)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('cant_carry'), style = { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' } })
            end
        elseif 96 < chance and chance <= 100 then
            local randomPull = math.random(1, #araf.highChanceItems)
            local item = araf.highChanceItems[randomPull]

            if xPlayer.canCarryItem(item, araf.giveItemCount) then
                xPlayer.addInventoryItem(item, araf.giveItemCount)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('cant_carry'), style = { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' } })
            end
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('no_item', araf.heatedIron), style = { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' } })
    end
end)

RegisterServerEvent('araf-blacksmith:giveMiningItem')
AddEventHandler('araf-blacksmith:giveMiningItem', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.canCarryItem(araf.iron, araf.giveItemCount) then
        xPlayer.addInventoryItem(araf.iron, araf.giveItemCount)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('cant_carry'), style = { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' } })
    end
end)

RegisterServerEvent('araf-blacksmith:deleteItem')
AddEventHandler('araf-blacksmith:deleteItem', function(item, count)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.removeInventoryItem(item, count)
end)