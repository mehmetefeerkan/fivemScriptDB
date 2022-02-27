ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('inside-farmer:payout')
AddEventHandler('inside-farmer:payout', function(arg)	
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = Config.Payout * arg
	xPlayer.addMoney(Payout)
end)
