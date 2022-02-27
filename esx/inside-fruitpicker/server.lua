ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('inside-fruitpicker:checkMoney', function(playerId, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
    local name = ESX.GetPlayerFromId(playerId)

	if xPlayer.getMoney() >= Config.DepositPrice then
        xPlayer.removeMoney(Config.DepositPrice)
		cb(true)
    elseif xPlayer.getAccount('bank').money >= Config.DepositPrice then
        xPlayer.removeAccountMoney('bank', Config.DepositPrice)
        cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('inside-fruitpicker:depositBack')
AddEventHandler('inside-fruitpicker:depositBack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = Config.DepositPrice
	
	xPlayer.addAccountMoney('bank', Config.DepositPrice)
end)

RegisterServerEvent('inside-fruitpicker:Payout')
AddEventHandler('inside-fruitpicker:Payout', function(arg)	
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = Config.Payout * arg
	
	xPlayer.addMoney(Payout)
end)