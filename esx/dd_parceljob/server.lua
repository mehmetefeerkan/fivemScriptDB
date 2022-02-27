ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("dd_jobs:GetPaid")
AddEventHandler("dd_jobs:GetPaid", function(rndmqlty, rndmtip)
	local xPlayer = ESX.GetPlayerFromId(source)
	local payout = rndmqlty + rndmtip
	xPlayer.addMoney(payout)
end)
