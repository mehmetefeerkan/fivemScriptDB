ESX	= nil
math.randomseed(os.time())

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_meslekler:finishTruck')
AddEventHandler('esx_meslekler:finishTruck', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll('select * from users where identifier = @identifier', {['@identifier'] = identifier}, function(result)
		local truckerLevel = result[1].truckerLevel
		local pay = Config.TruckerPrice
		if truckerLevel >= 25 and truckerLevel < 75 then
			pay = pay + 250
		elseif truckerLevel >= 75 and truckerLevel < 150 then
			pay = pay + 500
		elseif truckerLevel >= 150 then
			pay = pay + 1000
		end
		
		xPlayer.addMoney(pay)
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Görevi tamamladınız ve " .. pay .. " $ maaşınızı aldınız.")
		
		if truckerLevel < 150 then
			MySQL.Sync.execute('update users set truckerLevel = @truckerLevel where identifier = @identifier', {['@identifier'] = identifier, ['@truckerLevel'] = truckerLevel + 1})
		end
		
		truckerLevel = truckerLevel + 1
		if truckerLevel >= 0 and truckerLevel < 25 then			
			TriggerClientEvent('chatMessage', xPlayer.source, "", {255, 255, 255}, "Kamyonculuk leveliniz 1, 2. levele ulaşmak için " .. 25 - truckerLevel .. " defa gidip gelmeniz gerekiyor.")
		elseif truckerLevel >= 25 and truckerLevel < 75 then
			TriggerClientEvent('chatMessage', xPlayer.source, "", {255, 255, 255}, "Kamyonculuk leveliniz 2, 3. levele ulaşmak için " .. 75 - truckerLevel .. " defa gidip gelmeniz gerekiyor.")
		elseif truckerLevel >= 75 and truckerLevel < 150 then
			TriggerClientEvent('chatMessage', xPlayer.source, "", {255, 255, 255}, "Kamyonculuk leveliniz 3, 4. levele ulaşmak için " .. 150 - truckerLevel .. " defa gidip gelmeniz gerekiyor.")
		end
	end)
end)

ESX.RegisterServerCallback('esx_fisher:shipRetailPay', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local pay = Config.ShipRetailPay
	
	if money < pay then
		cb(false)
	else
		xPlayer.removeMoney(pay)
		cb(true)
	end
end)

RegisterNetEvent('esx_fisher:randomFish')
AddEventHandler('esx_fisher:randomFish', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local rand = math.random(1, 160)
	local item = 0
	
	if rand >= 1 and rand < 10 then
		item = 1
	elseif rand >= 10 and rand < 20 then
		item = 1
	elseif rand >= 20 and rand < 30 then
		item = 1
	elseif rand >= 30 and rand < 40 then
		item = 1
	elseif rand >= 40 and rand < 50 then
		item = 2
	elseif rand >= 50 and rand < 60 then
		item = 1
	elseif rand >= 60 and rand < 70 then
		item = 2
	elseif rand >= 70 and rand < 80 then
		item = 1
	elseif rand >= 80 and rand < 90 then
		item = 3
	elseif rand >= 90 and rand < 100 then
		item = 2
	elseif rand >= 100 and rand < 110 then item = 3 elseif rand >= 110 and rand < 120 then item = 0
	elseif rand >= 120 and rand < 130 then item = 0 elseif rand >= 130 and rand < 140 then item = 4
	elseif rand >= 140 and rand < 150 then item = 3 elseif rand >= 150 and rand < 160 then item = 4
	end
	
	if item == 1 then
		local sourceItem = xPlayer.getInventoryItem('hamsi')
		
		if sourceItem.limit ~= -1 and (sourceItem.count + 1) < sourceItem.limit then
			if sourceItem.count <= 1 then
				xPlayer.addInventoryItem('hamsi', 2)
			else
				xPlayer.addInventoryItem('hamsi', 1)
			end
			
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Misinaya hamsi takıldı!')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Daha fazla hamsi taşıyamazsınız!')
		end
	elseif item == 2 then
		local sourceItem = xPlayer.getInventoryItem('palamut')
		
		if sourceItem.limit ~= -1 and (sourceItem.count + 1) < sourceItem.limit then
			if sourceItem.count <= 1 then
				xPlayer.addInventoryItem('palamut', 2)
			else
				xPlayer.addInventoryItem('palamut', 1)
			end
			
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Misinaya palamut takıldı!')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Daha fazla palamut taşıyamazsınız!')
		end
	elseif item == 3 then
		local sourceItem = xPlayer.getInventoryItem('lufer')
		
		if sourceItem.limit ~= -1 and (sourceItem.count + 1) < sourceItem.limit then
			if sourceItem.count <= 1 then
				xPlayer.addInventoryItem('lufer', 2)
			else
				xPlayer.addInventoryItem('lufer', 1)
			end
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Misinaya lüfer takıldı!')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Daha fazla lüfer taşıyamazsınız!')
		end
	elseif item == 4 then
		local sourceItem = xPlayer.getInventoryItem('somon')
		
		if sourceItem.limit ~= -1 and (sourceItem.count + 1) < sourceItem.limit then
			if sourceItem.count <= 1 then
				xPlayer.addInventoryItem('somon', 2)
			else
				xPlayer.addInventoryItem('somon', 1)
			end
	
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Misinaya somon takıldı!')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Daha fazla somon taşıyamazsınız!')
		end
	elseif item == 0 then
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Misinanun uci kopti!')
	end
end)


RegisterServerEvent('esx_fisher:sellFish')
AddEventHandler('esx_fisher:sellFish', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tItems = {
		'somon', 'hamsi', 'palamut', 'lufer'
	}
	
	local item = 'empty'
	
	for _, v in pairs(tItems) do
		item = xPlayer.getInventoryItem(v)
		if item.count > 0 then
			for i=1, item.count, 1 do
			
				if item.name == 'hamsi' then xPlayer.addMoney(10)
				elseif item.name == 'palamut' then xPlayer.addMoney(20)
				elseif item.name == 'somon' then xPlayer.addMoney(100)
				elseif item.name == 'lufer' then xPlayer.addMoney(35)
				end
				
				xPlayer.removeInventoryItem(v, 1)
				Citizen.Wait(1200)
			end
		end
	end
	
	if item == 'empty' then
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('fisher_need_fish'))
	end	
	
	TriggerClientEvent('esx_fisher:controlOn', xPlayer.source)
end)

RegisterServerEvent('esx_builder:canPay')
AddEventHandler('esx_builder:canPay', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(Config.BuilderPrice)
	TriggerClientEvent('esx:showNotification', xPlayer.source, Config.BuilderPrice .. "$ maaşınızı aldınız.")
end)

ESX.RegisterServerCallback('esx_trashmaster:canPay', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local pay = Config.TrasherCarPrice
	
	if money < pay then
		cb(false)
	else
		xPlayer.removeMoney(pay)
		cb(true)
	end
end)


RegisterServerEvent('esx_trasher:confirmPay')
AddEventHandler('esx_trasher:confirmPay', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(Config.TrasherPay)
	TriggerClientEvent('esx:showNotification', xPlayer.source, 'Görevi tamamladınız ve ' .. Config.TrasherPay .. '$ paranızı aldınız.')
end)



