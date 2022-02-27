-- ================================================================================================--
-- ==                                VARIABLES - DO NOT EDIT                                     ==--
-- ================================================================================================--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > xPlayer.getMoney() then
            amount = xPlayer.getMoney()
        end
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
    if amount == nil or amount <= 0 then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
    end
end)

RegisterServerEvent('bank:withdrawK')
AddEventHandler('bank:withdrawK', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0

    amount = tonumber(200)
    base = xPlayer.getAccount('bank').money
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bank', 200)
        xPlayer.addMoney(200)
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
                               'Kendine transfer edemezsin!',
                               'CHAR_BANK_MAZE', 9)
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=
                0 then
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Banka', 'Para Transferi',
                                   'Para yollamak icin yeterli paran yok!',
                                   'CHAR_BANK_MAZE', 9)
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Banka', 'Para Transferi',
                                   'Transfer ettin ~r~$' .. amountt ..
                                       '~s~ icin ~r~' .. to .. ' .',
                                   'CHAR_BANK_MAZE', 9)
                TriggerClientEvent('esx:showAdvancedNotification', to, 'Bank',
                                   'Transfer Parasi', 'Para Geldi ~r~$' ..
                                       amountt .. '~s~ itibaren ~r~' .. _source ..
                                       ' .', 'CHAR_BANK_MAZE', 9)
            end

        end
    end

end)

ESX.RegisterServerCallback('new_banking:getCharacterName', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    print(identifier)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
        ['@identifier'] = identifier
    }, function(result)
        cb({firstname = result[1].firstname, lastname = result[1].lastname})
    end)
end)