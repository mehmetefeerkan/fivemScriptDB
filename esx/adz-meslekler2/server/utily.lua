ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

-- Item use
ESX.RegisterUsableItem('coke_pooch', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('coke_pooch', 1)

	TriggerClientEvent('rx_items:alkohol', source)
end)

ESX.RegisterUsableItem('meth_pooch', function(source)
        
    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('meth_pooch', 1)

TriggerClientEvent('rx_items:alkohol', source)
end)

ESX.RegisterUsableItem('opium_pooch', function(source)
        
    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('opium_pooch', 1)

TriggerClientEvent('rx_items:alkohol', source)
end)


ESX.RegisterUsableItem('pouch', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    local name = GetRealPlayerName(source)
    local args = "pije vodu"
  
    if xPlayer.getQuantity('weed') > 0 then
  
      xPlayer.removeInventoryItem('weed', 1)
    xPlayer.removeInventoryItem('sacek', 1)
    xPlayer.addInventoryItem('joint', 1)
  
      TriggerClientEvent('rx_items:joint', source)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You put weed in pouch'})
  
    end
  end)


  ESX.RegisterUsableItem('joint', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('joint', 1)   
    TriggerClientEvent('rx_items:alkohol', source)
  end)


  ESX.RegisterUsableItem(Config.rawItem, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getQuantity('weed') > 0 then
      xPlayer.removeInventoryItem('weed', 1)
    xPlayer.removeInventoryItem(Config.rawItem, 1)
    xPlayer.addInventoryItem('joint', 1)
      TriggerClientEvent('rx_items:joint', source)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You rolled joint'})
    --TriggerClientEvent('esx_rpchat:sendMe', -1, source, name, args, { 255, 198, 0 })
    --TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
    end
  end)
  


RegisterServerEvent('drc_papirek')
AddEventHandler('drc_papirek', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if 50 <= xPlayer.getMoney() then
        xPlayer.addInventoryItem(Config.rawItem, 1)
    end
end)


RegisterServerEvent('drc_pooch')
AddEventHandler('drc_pooch', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if 50 <= xPlayer.getMoney() then
        xPlayer.addInventoryItem(Config.poochItem, 1)
    end
end)


