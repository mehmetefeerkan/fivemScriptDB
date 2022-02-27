ESX 				= nil
local Users         = {}

---- MENU

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('cuffServer')
AddEventHandler('cuffServer', function(closestID)
	TriggerClientEvent('cuffClient', closestID)
end)

RegisterServerEvent('unCuffServer')
AddEventHandler('unCuffServer', function(closestID)
	TriggerClientEvent('unCuffClient', closestID)
end)

RegisterServerEvent('dragServer')
AddEventHandler('dragServer', function(target)
  local _source = source
  TriggerClientEvent('cuffscript:drag', target, _source)
end)

-- ESX.RegisterUsableItem('kajdanki', function(source)

-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	TriggerClientEvent('cuffs:OpenMenu', source)
-- end)

---- END MENU


ESX.RegisterServerCallback('esx_thief:getValue', function(source, cb, targetSID)
    if Users[targetSID] then
        cb(Users[targetSID])
    else
        cb({value = false, time = 0})
    end
end)

ESX.RegisterServerCallback('esx_thief:getOtherPlayerData', function(source, cb, target)

    local xPlayer = ESX.GetPlayerFromId(target)

    local data = {
      name        = GetPlayerName(target),
      inventory   = xPlayer.inventory,
      accounts    = xPlayer.accounts,
      money       = xPlayer.get('money'),
      weapons     = xPlayer.loadout

    }

      cb(data)

end)


RegisterServerEvent('esx_thief:stealPlayerItem')
AddEventHandler('esx_thief:stealPlayerItem', function(target, itemType, itemName, amount)

    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        print("item_standard")

        local label = sourceXPlayer.getInventoryItem(itemName).label
        local itemLimit = sourceXPlayer.getInventoryItem(itemName).limit
        local sourceItemCount = sourceXPlayer.getInventoryItem(itemName).count
        local targetItemCount = targetXPlayer.getInventoryItem(itemName).count

        if amount > 0 and targetItemCount >= amount then
    
            if itemLimit ~= -1 and (sourceItemCount + amount) > itemLimit then
                TriggerClientEvent('esx:showNotification', targetXPlayer.source, 'Karşı tarafın envanterinde yer yok')
                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Senin envanterinde yer yok')
				-- TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'inform', text = 'Karşı tarafın envanterinde yer yok'})
				-- TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'inform', text = 'Senin envanterinde yer yok'})
			
			else

                targetXPlayer.removeInventoryItem(itemName, amount)
                sourceXPlayer.addInventoryItem(itemName, amount)

                --TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_stole') .. ' ~g~x' .. amount .. ' ' .. label .. ' ~w~' .. _U('from_your_target') )
                --TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('someone_stole') .. ' ~r~x'  .. amount .. ' ' .. label )
				-- TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'inform', text = _U(amount .. 'tane' .. label .. 'çaldın')})
				-- TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'inform', text = _U('Birisi senden' .. amount .. 'tane' .. label .. 'çaldı')})


            end

        else
             --TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
			 TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('invalid_quantity')})
        end

    end

  if itemType == 'item_money' then

    if amount > 0 and targetXPlayer.get('money') >= amount then

      targetXPlayer.removeMoney(amount)
      sourceXPlayer.addMoney(amount)

      --TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_stole') .. ' ~g~$' .. amount .. ' ~w~' .. _U('from_your_target') )
      --TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('someone_stole') .. ' ~r~$'  .. amount )
      TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'inform', text = _U(amount .. '$ çaldın')})
	  TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'inform', text = _U('Birisi senden' .. amount .. '$ çaldı')})
	  
	else
      --TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
      TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('imp_invalid_amount')})
	end

  end

  if itemType == 'item_account' then

    if amount > 0 and targetXPlayer.getAccount(itemName).money >= amount then

        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney(itemName, amount)

        --TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_stole') .. ' ~g~$' .. amount .. ' ~w~' .. _U('of_black_money') .. ' ' .. _U('from_your_target') )
        --TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('someone_stole') .. ' ~r~$'  .. amount .. ' ~w~' .. _U('of_black_money') )
		TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'inform', text = _U(amount .. '$ çaldın')})
	    TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'inform', text = _U('Birisi senden' .. amount .. '$ çaldı')})
		

    else
        --TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('imp_invalid_amount')})
	end

  end

  if itemType == 'item_weapon' then
    print("Item_weapon")
    if amount == nil then amount = 0 end

        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon(itemName, amount)

        --TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_stole') .. ' ~g~x' .. amount .. ' ' .. label .. ' ~w~' .. _U('from_your_target') )
        --TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('someone_stole') .. ' ~r~x'  .. amount .. ' ' .. label )
		TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'inform', text = _U(amount .. 'tane' .. label .. 'çaldın')})
		TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'inform', text = _U('Birisi senden' .. amount .. 'tane' .. label .. 'çaldı')})
  
  end
end)

RegisterServerEvent("esx_thief:removecuffs")
AddEventHandler("esx_thief:removecuffs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('handcuffs', 1)
end)

RegisterServerEvent("esx_thief:addcuffs")
AddEventHandler("esx_thief:addcuffs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('handcuffs', 1)
end)

RegisterServerEvent("esx_thief:removeziptie")
AddEventHandler("esx_thief:removeziptie", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('ziptie', 1)
end)

RegisterServerEvent("esx_thief:addziptie")
AddEventHandler("esx_thief:addziptie", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('ziptie', 1)
end)

RegisterServerEvent("esx_thief:update")
AddEventHandler("esx_thief:update", function(bool)
	local source = source
	Users[source] = {value = bool, time = os.time()}
end)

RegisterServerEvent("esx_thief:getValue")
AddEventHandler("esx_thief:getValue", function(targetSID)
    local source = source
	if Users[targetSID] then
		TriggerClientEvent("esx_thief:returnValue", source, Users[targetSID])
	else
		TriggerClientEvent("esx_thief:returnValue", source, Users[targetSID])
	end
end)


---- HANDCUFFS + ROPE ----

ESX.RegisterServerCallback('esx_thief:getItemQ', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getInventoryItem(item).count
    cb(quantity)
end)


---- REHİN ALMA ----


RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	print("got to srv cmg3_animations:sync")
	print("got that fucking attach flag as: " .. tostring(attachFlag))
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)