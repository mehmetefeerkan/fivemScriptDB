
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
if (GetCurrentResourceName() == "hsn-stashouse") then





RegisterServerEvent('hsn-stashouse:addnewowner')     --sooon
AddEventHandler('hsn-stashouse:addnewowner', function( targetplayer,evid)
	local _source = source
  local targetplayer = ESX.GetPlayerFromId(targetplayer)
  targetplayer = targetplayer
	local houseid   = evid

	if targetplayer ~= nil then
		if houseid ~= nil then
					exports.ghmattimysql:execute('SELECT * FROM hasan_stashouse WHERE identity = @identity', {
						['@identity'] = targetplayer.identifier,
					}, function(result2)
						if result2[1] == nil then
							exports.ghmattimysql:execute('INSERT INTO hasan_stashouse (identity, houseid) VALUES (@identity, @houseid)',{
                ['@identity'] = targetplayer.identifier, ['@houseid'] = houseid})
                
              TriggerClientEvent("notification",_source,"Kişiye evi verdiniz",2)
              TriggerClientEvent('esx:showNotification', targetplayer.source, ('Bir eve ortak oldunuz'))
						else 
							 TriggerClientEvent('esx:showNotification', _source, ('Kişiye ait zaten bir ev var'))
						end
					end)
		else
      TriggerClientEvent('esx:showNotification', _source, ('Böyle bir ev bulunamıyor'))
		end
	else
    TriggerClientEvent('esx:showNotification', _source, ('Böyle bir kişi bulunamıyor'))
	end
end)

ESX.RegisterServerCallback('hsn-stashouse:getid', function(source, cb, houseid)
  local src = source
  local pid = ESX.GetPlayerFromId(src)
  local playerIdent = pid.identifier

  exports.ghmattimysql:scalar("SELECT houseid FROM hasan_stashouse WHERE identity=@identity ", {['@identity'] = playerIdent, ['@houseid'] = houseid}, function(rentalID)
      if rentalID ~= nil then
          cb(rentalID)
      else
          cb(false)
      end
  end)

end)


ESX.RegisterServerCallback('hsn-stashouse:getprice', function(source, cb, price)
  local src = source
  local pid = ESX.GetPlayerFromId(src)
  local playerIdent = pid.identifier

  exports.ghmattimysql:scalar("SELECT price FROM hasan_stashouse WHERE identity=@identity ", {['@identity'] = playerIdent, ['@price'] = price}, function(rentalID)
      if rentalID ~= nil then
          cb(rentalID)
      else
          cb(false)
      end
  end)

end)


ESX.RegisterServerCallback('hsn-stashouse:checkIsOwner', function(source, cb, houseid)
  local pl    = ESX.GetPlayerFromId(source)

  exports.ghmattimysql:scalar("SELECT houseid FROM hasan_stashouse WHERE houseid = @houseid AND identity = @identity", {
      ['@houseid'] = houseid,
      ['@identity'] = pl.identifier
   }, function(isOwner)

      if isOwner ~= nil then
          cb(true)
      else
          cb(false)
      end
  end)
end)






ESX.RegisterServerCallback('hsn-stashouse:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('hsn-stashouse:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('hsn-stashouse:removeOutfit')
AddEventHandler('hsn-stashouse:removeOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)


RegisterServerEvent('hsn-stashouse:setbuy')
AddEventHandler('hsn-stashouse:setbuy', function(houseid,price)
  local _source = source
    local pl = ESX.GetPlayerFromId(source)
    local money = pl.getMoney()
    xPlayer = pl
    if money >= price then
      exports.ghmattimysql:execute('SELECT * FROM hasan_stashouse WHERE identity = @identity', {
        ['@identity'] = pl.identifier,
      }, function(result2)
        if result2[1] == nil then
          exports.ghmattimysql:execute('SELECT * FROM hasan_stashouse WHERE houseid = @houseid', {
      ['@houseid'] = houseid,
    }, function(result)
      if result[1] == nil then
        exports.ghmattimysql:execute('INSERT INTO hasan_stashouse (identity, houseid,price) VALUES (@identity, @houseid,@price)',
        {
          ['@identity']   = pl.identifier,
          ['@houseid']    = houseid,
          ['@price'] = price,
        }
      )
      pl.removeMoney(price)
      TriggerClientEvent('esx:showNotification', _source, (''..price..' $ karşılığında '..houseid..' nolu evi satın aldınız.'))
      TriggerEvent("hasan:logtobuyhouse",xPlayer,"Kişi "..price.." karşılığında "..houseid.." nolu evi satın aldı.")
    else
      TriggerClientEvent('esx:showNotification', _source, ('Bu ev zaten satın alınmış.'))
    end
    end)
  else
    TriggerClientEvent('esx:showNotification', _source, ('Zaten bir eve sahipsiniz.'))
  end
end)
  else
    TriggerClientEvent('esx:showNotification', _source, ('Yeterli paranız yok'..price..'$'))
  end
end)

RegisterServerEvent('hsn-stashouse:detelehouseownership')
AddEventHandler('hsn-stashouse:detelehouseownership', function(evinidsi,price)
  local _source = source
    local pl = ESX.GetPlayerFromId(source)
    local src = source
    amount = price/2

    exports.ghmattimysql:executeSync("DELETE FROM hasan_stashouse WHERE identity=@identity  AND  houseid=@houseid", {['@identity'] = pl.identifier, ['@houseid'] = evinidsi, })
    pl.addMoney(amount)
    TriggerClientEvent('esx:showNotification', _source, ("Şuanki evinizi sattınız ve size gelen para :" ..amount.."$"))
end)


else
		print("")
        print("--------------------------------")
        print("Scriptin ismi hsn-stashouse olmali.")
        print("Scriptin ismi hsn-stashouse olmali.")
        print("Scriptin ismi hsn-stashouse olmali.")
        print("Scriptin ismi hsn-stashouse olmali.")
        print("Scriptin ismi hsn-stashouse olmali.")
        print("Scriptin ismi hsn-stashouse olmali.")
        print("Scriptin ismi hsn-stashouse olmali.")
        print("--------------------------------")
        print("")
        ExecuteCommand('add_ace resource.hsn-stashouse command.stop allow')
        ExecuteCommand('stop hsn-stashouse')
        
end





