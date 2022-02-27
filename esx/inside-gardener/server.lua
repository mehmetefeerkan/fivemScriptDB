ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('inside-gardener:checkMoney', function(playerId, cb)
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

RegisterServerEvent('inside-gardener:returnVehicle')
AddEventHandler('inside-gardener:returnVehicle', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = Config.DepositPrice
	
	xPlayer.addAccountMoney('bank', Config.DepositPrice)
end)

RegisterServerEvent('inside-gardener:Payout')
AddEventHandler('inside-gardener:Payout', function(salary, arg)	
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = salary * arg
	
	xPlayer.addMoney(Payout)
end)