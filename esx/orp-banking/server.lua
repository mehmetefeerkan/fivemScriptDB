ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('orp:bank:deposit')
AddEventHandler('orp:bank:deposit', function(amount)
    local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('orp:bank:notify', _source, "error", "Geçersiz Tutar...")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('orp:bank:notify', _source, "success", "Para Yatırma İşleminiz Gerçeklerşti... $" .. amount)
	end
end)

RegisterServerEvent('orp:bank:withdraw')
AddEventHandler('orp:bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local min = 0
	amount = tonumber(amount)
	min = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > min then
		TriggerClientEvent('orp:bank:notify', _source, "error", "Geçersiz Tutar...")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('orp:bank:notify', _source, "success", "Para Çekme İşleminiz Gerçeklerşti... $" .. amount)
	end
end)

RegisterServerEvent('orp:bank:balance')
AddEventHandler('orp:bank:balance', function()
	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('orp:bank:info', _source, balance)
end)

RegisterServerEvent('orp:bank:transfer')
AddEventHandler('orp:bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(to)
	local amount = amountt
	local balance = 0

	if(xTarget == nil or xTarget == -1) then
		TriggerClientEvent('orp:bank:notify', _source, "error", "Transfer Edilecek Alıcı Bulunamadı...")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = xTarget.getAccount('bank').money
		
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('orp:bank:notify', _source, "error", "Kendinize Para Transfer Edemezsiniz...")
		else
			if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
				TriggerClientEvent('orp:bank:notify', _source, "error", "Bu Transfer Için Yeterli Paranız Yok...")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amount))
				xTarget.addAccountMoney('bank', tonumber(amount))
				TriggerClientEvent('orp:bank:notify', _source, "success", "Transfer Gerçekleşti... $" .. amount)
				TriggerClientEvent('orp:bank:notify', to, "success", "Hesabınıza Para Geldi... $" .. amount .. ' via transfer')
			end
		end
	end
end)
