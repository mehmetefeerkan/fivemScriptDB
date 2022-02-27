-- ================================================================================================--
-- ==                                VARIABLES - DO NOT EDIT                                     ==--
-- ================================================================================================--
ESX = nil

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result =  exports.ghmattimysql:executeSync("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
        TriggerClientEvent('chatMessage', _source, 'Geçersiz miktar')
    else
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))
    end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 or amount > base then
        TriggerClientEvent('chatMessage', _source, 'Geçersiz miktar')
    else
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
    end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    TriggerClientEvent('currentbalance1', _source, balance)

end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money
        if tonumber(_source) == tonumber(to) then
            -- advanced notification with bank icon
            TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank',
                               'Para Transferi',
                               'Kendine transfer yapamazsın!',
                               'CHAR_BANK_MAZE', 9)
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=
                0 then
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Banka', 'Para Transferi',
                                   'Yeterli paranız yok!',
                                   'CHAR_BANK_MAZE', 9)
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Banka', 'Para Transferi',
                                   'Transfer edilen: ~r~$' .. amountt ..
                                       '~s~ to ~r~' .. to .. ' .',
                                   'CHAR_BANK_MAZE', 9)
                TriggerClientEvent('esx:showAdvancedNotification', to, 'Banka',
                                   'Para Transferi', 'Gelen Para: ~r~$' ..
                                       amountt .. '~s~ Gönderen: ~r~' .. _source ..
                                       ' .', 'CHAR_BANK_MAZE', 9)
            end

        end
    end

end)

ESX.RegisterUsableItem('bankakarti', function(source)
    local player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('open:atm', source)
    player.showNotification('Banka Kartı Kullanıldı!')
end)
