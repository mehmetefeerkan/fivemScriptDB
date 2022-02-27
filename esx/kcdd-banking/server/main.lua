

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("vlast-banking:withdraw")
AddEventHandler("vlast-banking:withdraw", function(data)
    xPlayer = ESX.GetPlayerFromId(source)
    amount = tonumber(data.amount)
    local base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Geçersiz Tutar'})
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
	end
end)


RegisterServerEvent("vlast-banking:deposit")
AddEventHandler("vlast-banking:deposit", function(data)
    xPlayer = ESX.GetPlayerFromId(source)

    if tonumber(data.amount) <= xPlayer.getMoney() then
		xPlayer.removeMoney(data.amount)
		xPlayer.addAccountMoney('bank', tonumber(data.amount))
        print(xPlayer.getAccount('bank').money)
    end
end)

RegisterServerEvent("vlast-banking-transfer")
AddEventHandler("vlast-banking-transfer", function(data)
    xPlayer =  ESX.GetPlayerFromId(source)
    toPlayer = ESX.GetPlayerFromId(tonumber(data.toplayer))
    
    if toPlayer ~= nil then
        xPlayer.removeAccountMoney("bank", tonumber(data.amount))
        -- toPlayer.addAccountMoney("bank", data.amount)
    end
end)


RegisterServerEvent("vlast-banking-addBankHistory")
AddEventHandler("vlast-banking-addBankHistory", function(data)
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        exports.ghmattimysql:execute('INSERT INTO bankhistory (identifier, header, amount, msg, type) VALUES (@identifier, @header, @amount, @msg, @type)', {
            ['@identifier'] = xPlayer.identifier,
            ["@header"] = data.header,
            ["@amount"] = tonumber(data.amount),
            ["@msg"] = data.desc,
            ["@type"] = data.type
        }, function(result)
        end)
    end
end)

ESX.RegisterServerCallback("kocadede-banking:GetPlayerData", function(source, cb)
    xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then
        exports.ghmattimysql:execute("SELECT * FROM users WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier
        }, function(data)
            if data[1] ~= nil then
                data[1].bank = xPlayer.getAccount('bank').money       
                data[1].money = xPlayer.getMoney()       
                cb(data)
            else
                cb(false)
            end
        end)
    end

end)

ESX.RegisterServerCallback("kocadede-getPlayerAccountHistory", function(source, cb)
    xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then
        exports.ghmattimysql:execute("SELECT * FROM bankhistory WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier
        }, function(data)
            if data[1] ~= nil or data[i] ~= {} then              
                cb(data)
            else
                cb(false)
            end
        end)
    end
end)