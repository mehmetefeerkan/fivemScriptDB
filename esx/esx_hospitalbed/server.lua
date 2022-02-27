ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_beds:gethelp')
AddEventHandler('esx_beds:gethelp', function(hospital)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local allowed = false
    if not Config.Hospitals[hospital].Bed.occupied then
        if xPlayer.getMoney() >= Config.Price then
            xPlayer.removeMoney(Config.Price)
            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
                account.addMoney(Config.Price)
            end)
            allowed = true
        elseif xPlayer.getAccount('bank').money >= Config.Price then
            allowed = true
            xPlayer.removeAccountMoney('bank', Config.Price)
            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
                account.addMoney(Config.Price)
            end)
        else
            TriggerClientEvent('esx_beds:notify', src, Strings['not_enough'])
        end
        if allowed then
            TriggerClientEvent('esx_beds:revive', src, hospital)
            Config.Hospitals[hospital].Bed.occupied = true
            Wait(Config.ReviveTime * 1000)
            Config.Hospitals[hospital].Bed.occupied = false
        end
    else
        TriggerClientEvent('esx_beds:notify', src, Strings['occupied'])
    end
end)

ESX.RegisterUsableItem('coke1g', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('coke1g', 1)

    TriggerClientEvent('kypo-drug-effect:onCoke', source)
end)

-- Item use
ESX.RegisterUsableItem('joint2g', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('joint2g', 1)

    TriggerClientEvent('kypo-drug-effect:onWeed', source)
end)

ESX.RegisterUsableItem('ifak', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
		xPlayer.removeInventoryItem('ifak', 1)

		TriggerClientEvent('effects:onIfak', source)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'IFAK kullanıyorsun.'})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Nasıl kullanılacağını bilmiyorsun.'})
	end
end)